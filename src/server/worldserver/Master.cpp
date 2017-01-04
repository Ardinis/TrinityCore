/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/** \file
    \ingroup Trinityd
*/

#include <ace/Sig_Handler.h>

#include "Common.h"
#include "SystemConfig.h"
#include "SignalHandler.h"
#include "World.h"
#include "WorldRunnable.h"
#include "WorldSocket.h"
#include "WorldSocketMgr.h"
#include "Configuration/Config.h"
#include "Database/DatabaseEnv.h"
#include "Database/DatabaseWorkerPool.h"

#include "CliRunnable.h"
#include "Log.h"
#include "Master.h"
#include "RARunnable.h"
#include "TCSoap.h"
#include "Timer.h"
#include "Util.h"
#include "AuthSocket.h"

#include "BigNumber.h"

#ifdef _WIN32
#include "ServiceWin32.h"
extern int m_ServiceStatus;
#endif

#define CRASH_MAX 3
#define CRASH_RECOVERY_INTERVAL 300000
#define ANTICRASH_LOGFILE getenv("ANTICRASH_LOGFILE")
#define ANTICRASH_HANDLER getenv("ANTICRASH_HANDLER")
#define COREDUMP_HANDLER getenv("COREDUMP_HANDLER")

/*
 * Thread-local variables to store anticrash-related info. TODO move to something like sAntiCrashMgr
 */
#ifndef _WIN32
#include <setjmp.h>
#include <signal.h>
__thread bool in_handler = false;
__thread uint32 lastSigTime = 0;
__thread uint32 crash_num = 0;
__thread sigjmp_buf *crash_recovery = NULL;
__thread uint32 currently_updated = 0;

ACE_Thread_Mutex crash_mutex;

/* This unblocks, unignore and raises SIGABRT to quit quickly, with coredump */
static void crash_now() {
  sigset_t sigset;
  signal(SIGABRT, SIG_DFL);
  sigemptyset(&sigset);
  sigaddset(&sigset, SIGABRT);
  sigprocmask(SIG_UNBLOCK, &sigset, NULL);
  raise(SIGABRT);
}

#endif

void generate_coredump() {
#ifndef _WIN32
    sigset_t sigset, oldsigset;
    sigfillset(&sigset);
    sigprocmask(SIG_BLOCK, &sigset, &oldsigset);
    int r = fork();
    if (r == -1)
        return;

    if (r == 0) {
                                signal(SIGSEGV, SIG_DFL);
                                signal(SIGILL, SIG_DFL);
                                signal(SIGABRT, SIG_DFL);
                                signal(SIGBUS, SIG_DFL);
                                signal(SIGFPE, SIG_DFL);
                                sigemptyset(&sigset);
                                sigaddset(&sigset, SIGSEGV);
                                sigaddset(&sigset, SIGILL);
                                sigaddset(&sigset, SIGABRT);
                                sigaddset(&sigset, SIGBUS);
                                sigaddset(&sigset, SIGFPE);
                                sigprocmask(SIG_UNBLOCK, &sigset, NULL);

                                /* Launch the anti-crash shellscript handler. It will sort/record the stack trace in the anti-crash history, and possibly dump the
                                 * core of the child process. Argument1 is PID of child process (for coredump generating), argument2 is current Map-ID
                                 * (the Map-ID corresponding to the InstanceMap::Update() in which the signal was received */
                                char tmp[256];
                                tmp[255] = 0;
                                snprintf(tmp, 254, "%s %u", COREDUMP_HANDLER, getpid());
                                system(tmp);
                                raise(SIGKILL);
    } else {
                                /* Parent process : Restore signals blocked before fork(), and "recover" from the crash by jumpng to the point before the InstanceMap::Update()
                                 * The code before InstanceMap::Update() will detect the crash recovery, and flag the instance map for cleanup.
                                 */
                                sigprocmask(SIG_SETMASK, &oldsigset, NULL);
    }
#endif
    return;
}


/// Handle worldservers's termination signals
class WorldServerSignalHandler : public Trinity::SignalHandler
{
    public:
        virtual void HandleSignal(int SigNum)
        {
#ifndef _WIN32
	sigset_t sigset, oldsigset;
	bool too_many_crash = false;
#endif
            switch (SigNum)
            {
                case SIGINT:
                    World::StopNow(RESTART_EXIT_CODE);
                    break;
                case SIGTERM:
                #ifdef _WIN32
                case SIGBREAK:
                    if (m_ServiceStatus != 1)
                #endif /* _WIN32 */
                    World::StopNow(SHUTDOWN_EXIT_CODE);
                    break;
                case SIGCHLD:
                        while (waitpid(-1, NULL, WNOHANG) > 0) {
                                sLog->outError("A child process has terminated.");
                        }
                        break;
                case SIGSEGV:
                case SIGILL:
                case SIGABRT:
                case SIGBUS:
                case SIGFPE:
                    /* do not permit re-entry into crash handler */
                    if (in_handler)
                    	crash_now();
                    in_handler = true;

                    /* we want any crash in the handler to be handled as an unrecoverable error */
                    sigemptyset(&sigset);
                    sigaddset(&sigset, SIGSEGV);
                    sigaddset(&sigset, SIGILL);
                    sigaddset(&sigset, SIGABRT);
                    sigaddset(&sigset, SIGBUS);
                    sigaddset(&sigset, SIGFPE);
                    sigprocmask(SIG_UNBLOCK, &sigset, NULL);

                    /* Do not allow more than CRASH_MAX successive crashes with less than CRASH_RECOVERY_INTERVAL time between crashes */
                    if ((getMSTime() - lastSigTime) < CRASH_RECOVERY_INTERVAL) {
                        crash_num++;
                    } else {
                        crash_num = 0;
                    }
                    lastSigTime = getMSTime();
                    too_many_crash = (crash_num >= CRASH_MAX);

                    /* crash_recovery is set if signal was received while doing InstanceMap::Update(). We do not handle other cases yet.
                     * Crash recovery can be disabled globally by setting env var. ANTICRASH_DISABLE.
                     */
                    if (crash_recovery && !too_many_crash && getenv("ANTICRASH_ENABLE")) {
						char buf[512];
						snprintf(buf, 512, "ANTICRASH map %u", currently_updated);
						buf[511] = 1;
						sLog->outDB(LOG_TYPE_DEBUG, buf);

/*                        ACE_Stack_Trace st;
                        sLog->outError("SIGSEGV received during InstanceMap::Update(). Crash avoided.\n");

                        FILE *f = fopen(ANTICRASH_LOGFILE, "w");
                        if (f) {
                                fprintf(f, "%s\n", st.c_str());
                                fclose(f);
                        }
*/


                        /* We fork() to enable the core-dumping of the child process without freezing the main worldserver process *
                         * We block all signals before the fork() so we are sure nothing but our code will be executed in the child process
                         * (extra paranoia, but justified, since any code using the DB in the child process can lead to DB corruption) */

                        sigfillset(&sigset);
                        sigprocmask(SIG_BLOCK, &sigset, &oldsigset);
                        int r = fork();
                        if (r == -1) {
                                crash_now();
                        }

                        if (r == 0) {
                                /* Child process : Receiving any of these signals while blocked, will lead to undetermined behavior, so we must unblock them and
                                 * make sure that the child process will crash immediately if they are received */
                                signal(SIGSEGV, SIG_DFL);
                                signal(SIGILL, SIG_DFL);
                                signal(SIGABRT, SIG_DFL);
                                signal(SIGBUS, SIG_DFL);
                                signal(SIGFPE, SIG_DFL);
                                sigemptyset(&sigset);
                                sigaddset(&sigset, SIGSEGV);
                                sigaddset(&sigset, SIGILL);
                                sigaddset(&sigset, SIGABRT);
                                sigaddset(&sigset, SIGBUS);
                                sigaddset(&sigset, SIGFPE);
                                sigprocmask(SIG_UNBLOCK, &sigset, NULL);

                                /* Launch the anti-crash shellscript handler. It will sort/record the stack trace in the anti-crash history, and possibly dump the
                                 * core of the child process. Argument1 is PID of child process (for coredump generating), argument2 is current Map-ID
                                 * (the Map-ID corresponding to the InstanceMap::Update() in which the signal was received */
                                char tmp[256];
                                tmp[255] = 0;
                                snprintf(tmp, 254, "%s %u %u", ANTICRASH_HANDLER, getpid(), currently_updated);
                                system(tmp);
                                raise(SIGKILL);
                        } else {
                                /* Parent process : Restore signals blocked before fork(), and "recover" from the crash by jumpng to the point before the InstanceMap::Update()
                                 * The code before InstanceMap::Update() will detect the crash recovery, and flag the instance map for cleanup.
                                 */
                                sigprocmask(SIG_SETMASK, &oldsigset, NULL);
                                siglongjmp(*crash_recovery, 1);
                        }
                        /* never reached */
                    }
                    crash_now();
                    break;

            }
        }
};

class FreezeDetectorRunnable : public ACE_Based::Runnable
{
public:
    FreezeDetectorRunnable() { _delaytime = 0; }
    uint32 m_loops, m_lastchange;
    uint32 w_loops, w_lastchange;
    uint32 _delaytime;
    void SetDelayTime(uint32 t) { _delaytime = t; }
    void run(void)
    {
        if (!_delaytime)
            return;
        sLog->outString("Starting up anti-freeze thread (%u seconds max stuck time)...", _delaytime/1000);
        m_loops = 0;
        w_loops = 0;
        m_lastchange = 0;
        w_lastchange = 0;
        while (!World::IsStopped())
        {
            ACE_Based::Thread::Sleep(1000);
            uint32 curtime = getMSTime();
            // normal work
            if (w_loops != World::m_worldLoopCounter)
            {
                w_lastchange = curtime;
                w_loops = World::m_worldLoopCounter;
            }
            // possible freeze
            else if (getMSTimeDiff(w_lastchange, curtime) > _delaytime)
            {
                sLog->outError("World Thread hangs, kicking out server!");
                ASSERT(false);
            }
        }
        sLog->outString("Anti-freeze thread exiting without problems.");
    }
};

Master::Master()
{
}

Master::~Master()
{
}

/// Main function
int Master::Run()
{
    BigNumber seed1;
    seed1.SetRand(16 * 8);

    sLog->outString("%s (worldserver-daemon)", _FULLVERSION);
    sLog->outString("<Ctrl-C> to stop.\n");

    sLog->outString(" ______                       __");
    sLog->outString("/\\__  _\\       __          __/\\ \\__");
    sLog->outString("\\/_/\\ \\/ _ __ /\\_\\    ___ /\\_\\ \\, _\\  __  __");
    sLog->outString("   \\ \\ \\/\\`'__\\/\\ \\ /' _ `\\/\\ \\ \\ \\/ /\\ \\/\\ \\");
    sLog->outString("    \\ \\ \\ \\ \\/ \\ \\ \\/\\ \\/\\ \\ \\ \\ \\ \\_\\ \\ \\_\\ \\");
    sLog->outString("     \\ \\_\\ \\_\\  \\ \\_\\ \\_\\ \\_\\ \\_\\ \\__\\\\/`____ \\");
    sLog->outString("      \\/_/\\/_/   \\/_/\\/_/\\/_/\\/_/\\/__/ `/___/> \\");
    sLog->outString("                                 C O R E  /\\___/");
    sLog->outString("http://TrinityCore.org                    \\/__/\n");

#ifdef USE_SFMT_FOR_RNG
    sLog->outString("\n");
    sLog->outString("SFMT has been enabled as the random number generator, if worldserver");
    sLog->outString("freezes or crashes randomly, first, try disabling SFMT in CMAKE configuration");
    sLog->outString("\n");
#endif //USE_SFMT_FOR_RNG

    /// worldserver PID file creation
    std::string pidfile = ConfigMgr::GetStringDefault("PidFile", "");
    if (!pidfile.empty())
    {
        uint32 pid = CreatePIDFile(pidfile);
        if (!pid)
        {
            sLog->outError("Cannot create PID file %s.\n", pidfile.c_str());
            return 1;
        }

        sLog->outString("Daemon PID: %u\n", pid);
    }

    ///- Start the databases
    if (!_StartDB())
        return 1;

    // set server offline (not connectable)
    LoginDatabase.DirectPExecute("UPDATE realmlist SET flag = (flag & ~%u) | %u WHERE id = '%d'", REALM_FLAG_OFFLINE, REALM_FLAG_INVALID, realmID);

    ///- Initialize the World
    sWorld->SetInitialWorldSettings();

    // Initialise the signal handlers
    WorldServerSignalHandler SignalINT, SignalTERM;
    WorldServerSignalHandler SignalSEGV, SignalILL, SignalABRT, SignalBUS, SignalFPE, SignalUSR1, SignalCHLD;
    #ifdef _WIN32
    WorldServerSignalHandler SignalBREAK;
    #endif /* _WIN32 */

    // Register worldserver's signal handlers
    ACE_Sig_Handler Handler;
    Handler.register_handler(SIGINT, &SignalINT);
    Handler.register_handler(SIGTERM, &SignalTERM);

#ifndef _WIN32
    //    Handler.register_handler(SIGSEGV, &SignalSEGV);
    //  Handler.register_handler(SIGILL, &SignalILL);
    //    Handler.register_handler(SIGABRT, &SignalABRT);
    //  Handler.register_handler(SIGBUS, &SignalBUS);
    // Handler.register_handler(SIGFPE, &SignalFPE);
    // Handler.register_handler(SIGUSR1, &SignalUSR1);

    //    Handler.register_handler(SIGCHLD, &SignalCHLD);
#endif


    #ifdef _WIN32
    Handler.register_handler(SIGBREAK, &SignalBREAK);
    #endif /* _WIN32 */

    ///- Launch WorldRunnable thread
    ACE_Based::Thread world_thread(new WorldRunnable);
    world_thread.setPriority(ACE_Based::Highest);

    ACE_Based::Thread* cliThread = NULL;

#ifdef _WIN32
    if (ConfigMgr::GetBoolDefault("Console.Enable", true) && (m_ServiceStatus == -1)/* need disable console in service mode*/)
#else
    if (ConfigMgr::GetBoolDefault("Console.Enable", true))
#endif
    {
        ///- Launch CliRunnable thread
        cliThread = new ACE_Based::Thread(new CliRunnable);
    }

    ACE_Based::Thread rar_thread(new RARunnable);

    ///- Handle affinity for multiple processors and process priority on Windows
    #ifdef _WIN32
    {
        HANDLE hProcess = GetCurrentProcess();

        uint32 Aff = ConfigMgr::GetIntDefault("UseProcessors", 0);
        if (Aff > 0)
        {
            ULONG_PTR appAff;
            ULONG_PTR sysAff;

            if (GetProcessAffinityMask(hProcess, &appAff, &sysAff))
            {
                ULONG_PTR curAff = Aff & appAff;            // remove non accessible processors

                if (!curAff)
                {
                    sLog->outError("Processors marked in UseProcessors bitmask (hex) %x are not accessible for the worldserver. Accessible processors bitmask (hex): %x", Aff, appAff);
                }
                else
                {
                    if (SetProcessAffinityMask(hProcess, curAff))
                        sLog->outString("Using processors (bitmask, hex): %x", curAff);
                    else
                        sLog->outError("Can't set used processors (hex): %x", curAff);
                }
            }
            sLog->outString("");
        }

        bool Prio = ConfigMgr::GetBoolDefault("ProcessPriority", false);

        //if (Prio && (m_ServiceStatus == -1)  /* need set to default process priority class in service mode*/)
        if (Prio)
        {
            if (SetPriorityClass(hProcess, HIGH_PRIORITY_CLASS))
                sLog->outString("worldserver process priority class set to HIGH");
            else
                sLog->outError("Can't set worldserver process priority class.");
            sLog->outString("");
        }
    }
    #endif
    //Start soap serving thread
    ACE_Based::Thread* soap_thread = NULL;

    if (ConfigMgr::GetBoolDefault("SOAP.Enabled", false))
    {
        TCSoapRunnable* runnable = new TCSoapRunnable();
        runnable->setListenArguments(ConfigMgr::GetStringDefault("SOAP.IP", "127.0.0.1"), ConfigMgr::GetIntDefault("SOAP.Port", 7878));
        soap_thread = new ACE_Based::Thread(runnable);
    }

    ///- Start up freeze catcher thread
    if (uint32 freeze_delay = ConfigMgr::GetIntDefault("MaxCoreStuckTime", 0))
    {
        FreezeDetectorRunnable* fdr = new FreezeDetectorRunnable();
        fdr->SetDelayTime(freeze_delay*1000);
        ACE_Based::Thread freeze_thread(fdr);
        freeze_thread.setPriority(ACE_Based::Highest);
    }

    ///- Launch the world listener socket
    uint16 wsport = sWorld->getIntConfig(CONFIG_PORT_WORLD);
    std::string bind_ip = ConfigMgr::GetStringDefault("BindIP", "0.0.0.0");

    if (sWorldSocketMgr->StartNetwork(wsport, bind_ip.c_str ()) == -1)
    {
        sLog->outError("Failed to start network");
        World::StopNow(ERROR_EXIT_CODE);
        // go down and shutdown the server
    }

    // set server online (allow connecting now)
    LoginDatabase.DirectPExecute("UPDATE realmlist SET flag = flag & ~%u, population = 0 WHERE id = '%u'", REALM_FLAG_INVALID, realmID);

    sLog->outString("%s (worldserver-daemon) ready...", _FULLVERSION);
    sWorldSocketMgr->Wait();

    if (soap_thread)
    {
        soap_thread->wait();
        soap_thread->destroy();
        delete soap_thread;
    }

    // set server offline
    LoginDatabase.DirectPExecute("UPDATE realmlist SET flag = flag | %u WHERE id = '%d'", REALM_FLAG_OFFLINE, realmID);

    // when the main thread closes the singletons get unloaded
    // since worldrunnable uses them, it will crash if unloaded after master
    world_thread.wait();
    rar_thread.wait();

    ///- Clean database before leaving
    clearOnlineAccounts();

    _StopDB();

    sLog->outString("Halting process...");

    if (cliThread)
    {
        #ifdef _WIN32

        // this only way to terminate CLI thread exist at Win32 (alt. way exist only in Windows Vista API)
        //_exit(1);
        // send keyboard input to safely unblock the CLI thread
        INPUT_RECORD b[5];
        HANDLE hStdIn = GetStdHandle(STD_INPUT_HANDLE);
        b[0].EventType = KEY_EVENT;
        b[0].Event.KeyEvent.bKeyDown = TRUE;
        b[0].Event.KeyEvent.uChar.AsciiChar = 'X';
        b[0].Event.KeyEvent.wVirtualKeyCode = 'X';
        b[0].Event.KeyEvent.wRepeatCount = 1;

        b[1].EventType = KEY_EVENT;
        b[1].Event.KeyEvent.bKeyDown = FALSE;
        b[1].Event.KeyEvent.uChar.AsciiChar = 'X';
        b[1].Event.KeyEvent.wVirtualKeyCode = 'X';
        b[1].Event.KeyEvent.wRepeatCount = 1;

        b[2].EventType = KEY_EVENT;
        b[2].Event.KeyEvent.bKeyDown = TRUE;
        b[2].Event.KeyEvent.dwControlKeyState = 0;
        b[2].Event.KeyEvent.uChar.AsciiChar = '\r';
        b[2].Event.KeyEvent.wVirtualKeyCode = VK_RETURN;
        b[2].Event.KeyEvent.wRepeatCount = 1;
        b[2].Event.KeyEvent.wVirtualScanCode = 0x1c;

        b[3].EventType = KEY_EVENT;
        b[3].Event.KeyEvent.bKeyDown = FALSE;
        b[3].Event.KeyEvent.dwControlKeyState = 0;
        b[3].Event.KeyEvent.uChar.AsciiChar = '\r';
        b[3].Event.KeyEvent.wVirtualKeyCode = VK_RETURN;
        b[3].Event.KeyEvent.wVirtualScanCode = 0x1c;
        b[3].Event.KeyEvent.wRepeatCount = 1;
        DWORD numb;
        WriteConsoleInput(hStdIn, b, 4, &numb);

        cliThread->wait();

        #else

        cliThread->destroy();

        #endif

        delete cliThread;
    }

    // for some unknown reason, unloading scripts here and not in worldrunnable
    // fixes a memory leak related to detaching threads from the module
    //UnloadScriptingModule();

    // Exit the process with specified return value
    return World::GetExitCode();
}

/// Initialize connection to the databases
bool Master::_StartDB()
{
    MySQL::Library_Init();

    sLog->SetLogDB(false);
    std::string dbstring;
    uint8 async_threads, synch_threads;

    dbstring = ConfigMgr::GetStringDefault("WorldDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("World database not specified in configuration file");
        return false;
    }

    async_threads = ConfigMgr::GetIntDefault("WorldDatabase.WorkerThreads", 1);
    if (async_threads < 1 || async_threads > 32)
    {
        sLog->outError("World database: invalid number of worker threads specified. "
            "Please pick a value between 1 and 32.");
        return false;
    }

    synch_threads = ConfigMgr::GetIntDefault("WorldDatabase.SynchThreads", 1);
    ///- Initialise the world database
    if (!WorldDatabase.Open(dbstring, async_threads, synch_threads))
    {
        sLog->outError("Cannot connect to world database %s", dbstring.c_str());
        return false;
    }

    ///- Get character database info from configuration file
    dbstring = ConfigMgr::GetStringDefault("CharacterDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("Character database not specified in configuration file");
        return false;
    }

    async_threads = ConfigMgr::GetIntDefault("CharacterDatabase.WorkerThreads", 1);
    if (async_threads < 1 || async_threads > 32)
    {
        sLog->outError("Character database: invalid number of worker threads specified. "
            "Please pick a value between 1 and 32.");
        return false;
    }

    synch_threads = ConfigMgr::GetIntDefault("CharacterDatabase.SynchThreads", 2);

    ///- Initialise the Character database
    if (!CharacterDatabase.Open(dbstring, async_threads, synch_threads))
    {
        sLog->outError("Cannot connect to Character database %s", dbstring.c_str());
        return false;
    }


    ///- Get character database info from configuration file
    dbstring = ConfigMgr::GetStringDefault("CataCharacterDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("Character database not specified in configuration file");
        return false;
    }

    async_threads = ConfigMgr::GetIntDefault("CataCharacterDatabase.WorkerThreads", 1);
    if (async_threads < 1 || async_threads > 32)
    {
        sLog->outError("Character database: invalid number of worker threads specified. "
            "Please pick a value between 1 and 32.");
        return false;
    }

    synch_threads = ConfigMgr::GetIntDefault("CataCharacterDatabase.SynchThreads", 2);

    ///- Initialise the Character database
    if (!CataCharacterDatabase.Open(dbstring, async_threads, synch_threads))
    {
        sLog->outError("Cannot connect to Character database %s", dbstring.c_str());
        return false;
    }


    ///- Get login database info from configuration file
    dbstring = ConfigMgr::GetStringDefault("LoginDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("Login database not specified in configuration file");
        return false;
    }

    async_threads = ConfigMgr::GetIntDefault("LoginDatabase.WorkerThreads", 1);
    if (async_threads < 1 || async_threads > 32)
    {
        sLog->outError("Login database: invalid number of worker threads specified. "
            "Please pick a value between 1 and 32.");
        return false;
    }

    synch_threads = ConfigMgr::GetIntDefault("LoginDatabase.SynchThreads", 1);
    ///- Initialise the login database
    if (!LoginDatabase.Open(dbstring, async_threads, synch_threads))
    {
        sLog->outError("Cannot connect to login database %s", dbstring.c_str());
        return false;
    }

    ///- Get Web database info from configuration file
    dbstring = ConfigMgr::GetStringDefault("WebDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("Web database not specified in configuration file");
        return false;
    }

    async_threads = ConfigMgr::GetIntDefault("WebDatabase.WorkerThreads", 1);
    if (async_threads < 1 || async_threads > 32)
    {
        sLog->outError("Web database: invalid number of worker threads specified. "
            "Please pick a value between 1 and 32.");
        return false;
    }

    synch_threads = ConfigMgr::GetIntDefault("WebDatabase.SynchThreads", 1);
    ///- Initialise the login database
    if (!WebDatabase.Open(dbstring, async_threads, synch_threads))
    {
        sLog->outError("Cannot connect to web database %s", dbstring.c_str());
        return false;
    }

    ///- Get store database info from configuration file
    dbstring = ConfigMgr::GetStringDefault("StoreDatabaseInfo", "");
    if (dbstring.empty())
    {
        sLog->outError("Store database not specified in configuration file");
        return false;
    }

    async_threads = ConfigMgr::GetIntDefault("StoreDatabase.WorkerThreads", 1);
    if (async_threads < 1 || async_threads > 32)
    {
        sLog->outError("Store database: invalid number of worker threads specified. "
            "Please pick a value between 1 and 32.");
        return false;
    }

    synch_threads = ConfigMgr::GetIntDefault("StoreDatabase.SynchThreads", 1);
    ///- Initialise the login database
    if (!StoreDatabase.Open(dbstring, async_threads, synch_threads))
    {
        sLog->outError("Cannot connect to store database %s", dbstring.c_str());
        return false;
    }

    ///- Get the realm Id from the configuration file
    realmID = ConfigMgr::GetIntDefault("RealmID", 0);
    if (!realmID)
    {
        sLog->outError("Realm ID not defined in configuration file");
        return false;
    }
    sLog->outString("Realm running as realm ID %d", realmID);

    ///- Initialize the DB logging system
    sLog->SetLogDBLater(ConfigMgr::GetBoolDefault("EnableLogDB", false)); // set var to enable DB logging once startup finished.
    sLog->SetLogDB(false);
    sLog->SetRealmID(realmID);

    ///- Clean the database before starting
    clearOnlineAccounts();

    ///- Insert version info into DB
    WorldDatabase.PExecute("UPDATE version SET core_version = '%s', core_revision = '%s'", _FULLVERSION, _HASH);        // One-time query

    sWorld->LoadDBVersion();

    sLog->outString("Using World DB: %s", sWorld->GetDBVersion());
    return true;
}

void Master::_StopDB()
{
    CharacterDatabase.Close();
    WorldDatabase.Close();
    LoginDatabase.Close();

    MySQL::Library_End();
}

/// Clear 'online' status for all accounts with characters in this realm
void Master::clearOnlineAccounts()
{
    // Cleanup online status for characters hosted at current realm
    /// \todo Only accounts with characters logged on *this* realm should have online status reset. Move the online column from 'account' to 'realmcharacters'?
    LoginDatabase.DirectPExecute(
        "UPDATE account SET online = 0 WHERE online > 0 "
        "AND id IN (SELECT acctid FROM realmcharacters WHERE realmid = '%d')", realmID);

    CharacterDatabase.DirectExecute("UPDATE characters SET online = 0 WHERE online <> 0");

    // Battleground instance ids reset at server restart
    CharacterDatabase.DirectExecute(CharacterDatabase.GetPreparedStatement(CHAR_UPD_PLAYERS_BGDATA));
}
