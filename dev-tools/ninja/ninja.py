#!/usr/bin/env python2
import MySQLdb, MySQLdb.cursors 
import sys

MYSQL_HOST="localhost"
MYSQL_DB="world"
MYSQL_USER="root"
MYSQL_PASS="rototo"


MAP="603"


exclure_gobs = set([189973,
190170,
190171,
190176,
191019
])

exclure_mobs = set([21252,
22515,
30298,
32780
])






class GuidTranslator:
  def __init__(self):
    self.guid_allocated = {}
    self.guid_offset_next = 0
    self.guid_set_gob = set()
    self.guid_set_npc = set()
    self.not_a_guid = set([33162,33152,33116,33293])
    cur = CURSOR
    cur.execute("SELECT guid FROM creature WHERE map = " + MAP, ())
    result = cur.fetchall()
    for row in result:
      row["guid"]
      self.guid_set_npc.add(row["guid"])
    cur.execute("SELECT guid FROM gameobject WHERE map = " + MAP, ())
    result = cur.fetchall()
    for row in result:
      row["guid"]
      self.guid_set_gob.add(row["guid"])
  def get_helper(self, guid):
    if guid in self.guid_allocated:
      return self.guid_allocated[guid]
    result = "@GUID_START + " + str(self.guid_offset_next) 
    self.guid_allocated[guid] = result
    self.guid_offset_next = self.guid_offset_next + 1
    #if guid == 33293:
    #print >> sys.stderr, ("Translation automatique de GUID: " + str(guid) + " vers " + result)
    return result
  def guid_match(self, g, table, col):
    if type(g) is not int:
      return False
    res = False
    if g in self.not_a_guid:
      return False
    if g in self.guid_set_gob:
      if sys.argv[1] != "gameobject":
        print >> sys.stderr,("On essaye de traduire un guid gobject (" + str(g) + " ) alors que on est en mode: " + sys.argv[1] + " (table: " + table + " colonne: " + col + ")")
      res = True
    if g in self.guid_set_npc:
      if sys.argv[1] != "creature":
        print >> sys.stderr,("On essaye de traduire un guid creature (" + str(g) + " ) alors que on est en mode: " + sys.argv[1] + " (table: " + table + " colonne: " + col + ")")
      res = True
    if res:
      if (table == "creature_template") and (col == "entry"):
        print >> sys.stderr, ("Ambiguite GUID/entry: " + str(g))
    return res
  def get(self, guid):
    if guid > 0:
      return self.get_helper(guid)
    else:
      return "-(" + self.get_helper(-guid) + ")"
      


def get_item_name(entry):
  cur = CURSOR
  cur.execute("SELECT name FROM item_template WHERE entry=%s", (entry))
  result = cur.fetchall()
  if result is None:
    return ("???")
  else:
    return result[0]["name"]
    
    
def extract(comment, table, query,  idx=None , guid_columns=set()):
  cur = CURSOR
  cur.execute(query, ())
  result = cur.fetchall()
  if len(result) == 0:
    return None
  text = ""
  first_idx_val = None
  for row in result:
    row_struct = ""
    row_values = ""
    i = 0
    first = True
    idx_val = None
    for k in row:
      if not first:
        row_struct = row_struct + ", "
        row_values = row_values + ", "
      row_struct = row_struct + str(k)
      if (row[k] is not None) and ((k in guid_columns) or guid_translator.guid_match(row[k], table, k)):
        val = guid_translator.get(row[k])
      else:
        val = "NULL" if row[k] is None else "'" + db.escape_string(str(row[k])) + "'"
      try:
        if (idx is not None) and (k == idx) and (int(eval(val)) > 0):
          idx_val = val
      except:
        pass
      row_values = row_values + val
      first = False
      i = i + 1
    if idx_val is not None:
      if first_idx_val is None:
        first_idx_val = idx_val
        text = text + "DELETE FROM " + table + " WHERE " + idx + "=" + idx_val + ";\n"
      elif first_idx_val != idx_val:
        raise ValueError("idx " + idx + " is not a primary key!")
    text = text + "REPLACE INTO " + table + " (" + row_struct + ") VALUES(" + row_values + ");\n"

  print("-- " + comment)
  print(text)
  return result


#creature script
#gameobject script

def ninja_gameobject(gob_id):
  if gob_id <= 0:
    return
  if not (gob_id in exclure_gobs):
    template = extract("Dump gameobject template", "gameobject_template", "SELECT * from gameobject_template WHERE entry=" + str(gob_id), "entry")
    li = LootInfo(gob_id, template[0]["name"], True)
    if template[0]["type"] == 3:
      if template[0]["data1"] != 0:
        ninja_loot("gameobject", template[0]["data1"], li)
    extract("Dump SmartScripts for gob entry", "smart_scripts", "SELECT * from smart_scripts WHERE source_type=1 AND entryorguid=" + str(gob_id), "entryorguid" )
  extract("Dump SmartScripts for gob guid", "smart_scripts", "SELECT * from smart_scripts WHERE source_type=1 AND entryorguid IN (SELECT -guid FROM gameobject WHERE map=" + MAP + " and id=" + str(gob_id) + ")" , "entryorguid", set(["entryguid"]))
  extract("Dump old-style SQL scripts for gameobject guid", "gameobject_scripts", "SELECT * from gameobject_scripts WHERE id IN (SELECT guid FROM gameobject WHERE map=" + MAP + " and id=" + str(gob_id) + ")", "id", set(["id"]))
  extract("Dump gameobject spawns", "gameobject", "SELECT * from gameobject WHERE  guid IN (SELECT guid FROM gameobject WHERE map=" + MAP + " and id=" + str(gob_id) + ")" , "guid", set(["guid"]))
  

class LootInfo(object):
  def __init__(self, id, name, report):
    self.id = id
    self.name = name
    self.report = report

def ninja_loot(loot_type, id, li):
   if (loot_type != "reference"):
     li.type = loot_type
   template = extract("Dump "  + loot_type + " loots", loot_type + "_loot_template", "SELECT * from " + loot_type + "_loot_template WHERE entry=" + str(id), "entry")
   if template is None: 
     print >> sys.stderr, ("Loot type " + loot_type + " id " + str(id) + " n'existe pas.")
   else:
     for loot in template:
       chance = loot["ChanceOrQuestChance"]
       if (chance == 0.0):
         chance="100.0(groupe)"
       elif (chance < 0.0):
         chance=str(-chance) + "(quete)"
       if loot["mincountOrRef"] < 0:
         ninja_loot("reference", -loot["mincountOrRef"], li)
       else:
         if li.report:
           print >> lf,("Loot_Type: " + li.type + ", ID: "+  str(li.id) + ", Name:" + li.name + " Chance: " + str(chance) + " HardMode_Flags: " + str(loot["lootmode"]) + ", ItemID: " + str(loot["item"]) +  " ItemName: " + get_item_name(loot["item"]))

def ninja_creature_single(creature_id, diff):
  if creature_id <= 0:
    return
  template = None
  if not (creature_id in exclure_mobs):
    template = extract("Dump creature entry, difficulty: " + str(diff) , "creature_template", "SELECT * from creature_template WHERE entry=" + str(creature_id), "entry" )
    li = LootInfo(creature_id, template[0]["name"], (template[0]["rank"] == 3))
    if template[0]["lootid"] != 0:
      ninja_loot("creature", template[0]["lootid"], li)
    if template[0]["pickpocketloot"] != 0:
      ninja_loot("pickpocketing", template[0]["pickpocketloot"], li)
    if template[0]["skinloot"] != 0:
      ninja_loot("skinning", template[0]["skinloot"], li)
    extract("Dump creature template addon, difficulty: " + str(diff), "creature_template_addon", "SELECT * from creature_template_addon WHERE entry=" + str(creature_id), "entry" )
    extract("Dump creature spellclick, difficulty: " + str(diff), "npc_spellclick_spells", "SELECT * from npc_spellclick_spells WHERE npc_entry=" + str(creature_id), "npc_entry")
    extract("Dump old-style SQL scripts for creature entry", "creature_ai_scripts", "SELECT * from creature_ai_scripts WHERE creature_id=" + str(creature_id), "creature_id")
    extract("Dump vehicle template accessory, difficulty: " + str(diff), "vehicle_template_accessory", "SELECT * from vehicle_template_accessory WHERE entry=" + str(creature_id), "entry" )
    extract("Dump creature text, difficulty: " + str(diff), "creature_text", "SELECT * from creature_text WHERE entry=" + str(creature_id), "entry" )
    extract("Dump SmartScripts for creature entry, difficulty: " + str(diff), "smart_scripts", "SELECT * from smart_scripts WHERE source_type=0 AND entryorguid=" + str(creature_id), "entryorguid")
  
  extract("Dump vehicle accessory, difficulty: " + str(diff), "vehicle_acecssory", "SELECT * from vehicle_accessory WHERE guid IN (SELECT guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")" , "guid", set(["guid"]))
  extract("Dump creature spawns, difficulty: " + str(diff), "creature", "SELECT * from creature WHERE map=" + MAP + " and id=" + str(creature_id) , "guid", set(["guid"]))
  extract("Dump creature addon, difficulty: " + str(diff), "creature_addon", "SELECT * from creature_addon WHERE guid IN (SELECT guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")" , "guid", set(["guid"]))
  extract("Dump SmartScripts for creature guid, difficulty: " + str(diff), "smart_scripts", "SELECT * from smart_scripts WHERE source_type=0 AND entryorguid IN (SELECT -guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")" , "entryorguid", set(["entryguid"]))
  extract("Dump old-style SQL scripts for creature guid", "creature_ai_scripts", "SELECT * from creature_ai_scripts WHERE id IN (SELECT guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")", "id", set(["id"]))
  #NOT PROCESSED: loot tables, formation templates, gossips, ...
  return template
  
def ninja_creature(creature_id):
  res = ninja_creature_single(creature_id, 0)
  if res is None:
    return
  #print >> sys.stderr, ("Traitement creature: " + res[0]["name"])
  #extract for all difficulties
  for diff in range(1,4):
    ninja_creature_single(res[0]["difficulty_entry_" + str(diff)], diff)


def ninja_spell_single(spell_id, rank):
  extract("Dump spell C++ script association, rank: " + str(rank), "spell_script_names", "SELECT * from spell_script_names WHERE spell_id=" + str(spell_id), "spell_id")
  #TODO: translate constants in condition table ? 
  extract("Dump spell targetting conditions, rank: " + str(rank), "conditions", "SELECT * from conditions where SourceTypeOrReferenceId=13 AND SourceEntry=" + str(spell_id), "SourceEntry")
  extract("Dump spell SQL script, rank: " + str(rank), "spell_scripts", "SELECT * from spell_scripts where id=" + str(spell_id), "id")
  extract("Dump SmartScripts for spell, rank: " + str(rank), "smart_scripts", "SELECT * from smart_scripts WHERE source_type=6 AND entryorguid=" + str(spell_id), "entryorguid" )
  extract("Dump Spell DBC, rank: " + str(rank), "spell_dbc", "SELECT * from spell_dbc WHERE id=" + str(spell_id), "id")
  
def ninja_spell(spell_id):
  #extract for all ranks
  cur = CURSOR
  cur.execute("SELECT spell_id,rank FROM spell_ranks WHERE first_spell_id=" + str(spell_id) )
  result = cur.fetchall()
  if len(result) == 0:
    ninja_spell_single(spell_id, 1)
    return
  for row in result:
    ninja_spell_single(row["spell_id"], row["rank"])
        
  

db = MySQLdb.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB, charset="utf8", cursorclass=MySQLdb.cursors.DictCursor)
CURSOR = db.cursor()
guid_translator = GuidTranslator()
print ("set @GUID_START := (select greatest((select guid from creature order by guid desc limit 1),  (select guid from gameobject order by guid desc limit 1) ) + 1);")
print ("DELETE from gameobject where map = 603;")
print ("DELETE from creature where map = 603;")

if sys.argv[1] == "creature":
  func = ninja_creature
elif sys.argv[1] == "spell":
  func = ninja_spell
elif sys.argv[1] == "gameobject":
  func = ninja_gameobject
else:
  print("Usage: ./ninja.py spell|creature|gameobject <ID>")
  exit(1)

lf = open("loots.txt", "a")
try:
  while True:
    id = input()
    func(id)
except EOFError:
  pass
  

lf.close()
  
db.close()
  
