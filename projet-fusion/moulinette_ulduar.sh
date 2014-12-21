#!/bin/sh
cat <<EOF1 > ulduar.sql
DELETE FROM creature WHERE map=603;
DELETE FROM gameobject WHERE map=603;
EOF1
echo "Traitement des spells"
cat spell_ids.biglist | ../../dev-tools/ninja/ninja.py spell $A >> ulduar.sql
echo "Traitement des gameobjects"
cat gob_ids.biglist | ../../dev-tools/ninja/ninja.py gameobject >> ulduar.sql
echo "Traitement des creatures"
cat mob_ids.biglist | ../../dev-tools/ninja/ninja.py creature >> ulduar.sql
cat <<EOF >> ulduar.sql
update creature_template set speed_fly=speed_run where speed_fly = -1;
EOF
