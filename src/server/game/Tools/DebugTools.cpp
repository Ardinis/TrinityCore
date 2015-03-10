#include <stdio.h>
#ifndef _WIN32
#include <execinfo.h>
#endif
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

#include "Common.h"

#define BACKTRACE_SIZE 256


// I don't use the default ACE stack trace generator because it appears buggy
void genBackTrace() {
#ifndef _WIN32
  void *array[BACKTRACE_SIZE];
  size_t size;
  char **buf = NULL;
  size = backtrace(array, BACKTRACE_SIZE);
  buf = backtrace_symbols(array, size);
  if (buf != NULL) {
    for (int i = 0; i < size; i++) {
      sLog->outString("%u: %s", i, buf[i]);
      if (i < 10)
        sLog->outDB(LOG_TYPE_DEBUG, buf[i]);
    }
  }
#endif
}

