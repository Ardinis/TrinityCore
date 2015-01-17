update creature_template set unit_flags=(unit_flags & ~0x300) where entry IN(32874,32872,32873);
update creature_template set unit_flags=(unit_flags | 2) where entry IN(32874,32872, 32873);
