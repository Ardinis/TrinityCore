#!/usr/bin/env python2
import MySQLdb, MySQLdb.cursors 
import sys

MYSQL_HOST="localhost"
MYSQL_DB="world"
MYSQL_USER="root"
MYSQL_PASS="rototo"


MAP="603"



class GuidTranslator:
  def __init__(self):
    self.guid_allocated = {}
    self.guid_offset_next = 0
    self.guid_set = set()
    cur = db.cursor()
    cur.execute("SELECT guid FROM creature WHERE map = " + MAP, ())
    result = cur.fetchall()
    for row in result:
      row["guid"]
      self.guid_set.add(row["guid"])
    cur.execute("SELECT guid FROM gameobject WHERE map = " + MAP, ())
    result = cur.fetchall()
    for row in result:
      row["guid"]
      self.guid_set.add(row["guid"])
  def get_helper(self, guid):
    if guid in self.guid_allocated:
      return self.guid_allocated[guid]
    result = "@GUID_START + " + str(self.guid_offset_next) 
    self.guid_allocated[guid] = result
    self.guid_offset_next = self.guid_offset_next + 1
    #print >> sys.stderr, ("Translation automatique de GUID: " + str(guid) + " vers " + result)
    return result
  def guid_match(self, g):
    if type(g) is not int:
      return False
    if g in self.guid_set:
      return True
  def get(self, guid):
    if guid > 0:
      return self.get_helper(guid)
    else:
      return "-(" + self.get_helper(-guid) + ")"
      

    
def extract(comment, table, query,  idx=None , guid_columns=set()):
  cur = db.cursor()
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
      if (row[k] is not None) and ((k in guid_columns) or guid_translator.guid_match(row[k])):
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
  template = extract("Dump gameobject template", "gameobject_template", "SELECT * from gameobject_template WHERE entry=" + str(gob_id), "entry")
  print >> sys.stderr, ("Traitement gameobject: " + template[0]["name"])
  extract("Dump gameobject spawns", "gameobject", "SELECT * from gameobject WHERE  guid IN (SELECT guid FROM gameobject WHERE map=" + MAP + " and id=" + str(gob_id) + ")" , "guid", set(["guid"]))
  extract("Dump SmartScripts for gob entry", "smart_scripts", "SELECT * from smart_scripts WHERE source_type=1 AND entryorguid=" + str(gob_id), "entryorguid" )
  extract("Dump SmartScripts for gob guid", "smart_scripts", "SELECT * from smart_scripts WHERE source_type=1 AND entryorguid IN (SELECT -guid FROM gameobject WHERE map=" + MAP + " and id=" + str(gob_id) + ")" , "entryorguid", set(["entryguid"]))
  extract("Dump old-style SQL scripts for gameobject guid", "gameobject_scripts", "SELECT * from gameobject_scripts WHERE id IN (SELECT guid FROM gameobject WHERE map=" + MAP + " and id=" + str(gob_id) + ")", "id", set(["id"]))
  
def ninja_creature_single(creature_id, diff):
  if creature_id <= 0:
    return
  template = extract("Dump creature entry, difficulty: " + str(diff) , "creature_template", "SELECT * from creature_template WHERE entry=" + str(creature_id), "entry" )
  extract("Dump creature spawns, difficulty: " + str(diff), "creature", "SELECT * from creature WHERE map=" + MAP + " and id=" + str(creature_id) , "guid", set(["guid"]))
  extract("Dump creature template addon, difficulty: " + str(diff), "creature_template_addon", "SELECT * from creature_template_addon WHERE entry=" + str(creature_id), "entry" )
  extract("Dump creature addon, difficulty: " + str(diff), "creature_addon", "SELECT * from creature_addon WHERE guid IN (SELECT guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")" , "guid", set(["guid"]))
  extract("Dump creature spellclick, difficulty: " + str(diff), "npc_spellclick_spells", "SELECT * from npc_spellclick_spells WHERE npc_entry=" + str(creature_id), "npc_entry")
  extract("Dump vehicle template accessory, difficulty: " + str(diff), "vehicle_template_accessory", "SELECT * from vehicle_template_accessory WHERE entry=" + str(creature_id), "entry" )
  extract("Dump vehicle accessory, difficulty: " + str(diff), "vehicle_acecssory", "SELECT * from vehicle_accessory WHERE guid IN (SELECT guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")" , "guid", set(["guid"]))
  extract("Dump creature text, difficulty: " + str(diff), "creature_text", "SELECT * from creature_text WHERE entry=" + str(creature_id), "entry" )
  extract("Dump SmartScripts for creature entry, difficulty: " + str(diff), "smart_scripts", "SELECT * from smart_scripts WHERE source_type=0 AND entryorguid=" + str(creature_id), "entryorguid")
  extract("Dump SmartScripts for creature guid, difficulty: " + str(diff), "smart_scripts", "SELECT * from smart_scripts WHERE source_type=0 AND entryorguid IN (SELECT -guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")" , "entryorguid", set(["entryguid"]))
  extract("Dump old-style SQL scripts for creature guid", "creature_ai_scripts", "SELECT * from creature_ai_scripts WHERE id IN (SELECT guid FROM creature WHERE map=" + MAP + " and id=" + str(creature_id) + ")", "id", set(["id"]))
  extract("Dump old-style SQL scripts for creature entry", "creature_ai_scripts", "SELECT * from creature_ai_scripts WHERE creature_id=" + str(creature_id), "creature_id")
  #NOT PROCESSED: loot tables, formation templates, gossips, ...
  return template
  
def ninja_creature(creature_id):
  res = ninja_creature_single(creature_id, 0)
  if res is None:
    raise ValueError, ("Unknown creature ID: " + str(creature_id))
  print >> sys.stderr, ("Traitement creature: " + res[0]["name"])
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
  cur = db.cursor()
  cur.execute("SELECT spell_id,rank FROM spell_ranks WHERE first_spell_id=" + str(spell_id) )
  result = cur.fetchall()
  if len(result) == 0:
    ninja_spell_single(spell_id, 1)
    return
  for row in result:
    ninja_spell_single(row["spell_id"], row["rank"])
        
  

db = MySQLdb.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB, charset="utf8", cursorclass=MySQLdb.cursors.DictCursor)
guid_translator = GuidTranslator()
print ("set @GUID_START := (select greatest((select guid from creature order by guid desc limit 1),  (select guid from gameobject order by guid desc limit 1) ) + 1);")
if sys.argv[1] == "creature":
  func = ninja_creature
elif sys.argv[1] == "spell":
  func = ninja_spell
elif sys.argv[1] == "gameobject":
  func = ninja_gameobject
else:
  print("Usage: ./ninja.py spell|creature|gameobject <ID>")
  exit(1)

try:
  while True:
    id = input()
    func(id)
except EOFError:
  pass
  
  
db.close()
  
