delete from spell_group where id >= 1139 and id <= 1144;
delete from spell_group_stack_rules where group_id >= 1139 and group_id <= 1144;


#degats/hate
insert into spell_group values(1139, 50172); #aura moonkin
insert into spell_group values(1139, 63531); #truc pala
insert into spell_group values(1139, 31579); #arcane empowerement
insert into spell_group values(1139, 75593); #truc chassou BM
insert into spell_group values(1139, 7294); #aura de vindicte + vindicte sanctifiee
insert into spell_group_stack_rules values(1139, 3);


#cumul force/endu sur benediction sanctuaire/rois
insert into spell_group values(1140, 67480);
insert into spell_group values(1140, 20217);
insert into spell_group values(1140, 25898);
insert into spell_group values(1140, 25899);
insert into spell_group_stack_rules values(1140, 3);


#debuff degats subis
insert into spell_group values(1141,58684);
insert into spell_group values(1141,30069);
insert into spell_group_stack_rules values(1141, 1);


#debuff crit subis
insert into spell_group values(1142,17800);
insert into spell_group values(1142,22959);
insert into spell_group values(1142,12579);
insert into spell_group_stack_rules values(1142, 1);

#bonus ps
insert into spell_group values(1143,48090);
insert into spell_group values(1143,52109);
insert into spell_group values(1143,57663);
insert into spell_group_stack_rules values(1143, 1);

#malus hit
insert into spell_group values(1144,770); #lucioles
insert into spell_group values(1144,33196); #misere
insert into spell_group_stack_rules values(1144, 3);


#stacking partiel totem / cor de l'hiver
# 8076 / 57330
update spell_group_stack_rules set stack_rule=3 where group_id=1082
