--Veins of the Earth
--Zireael

-- Classes
newBirthDescriptor {
	type = 'class',
	name = 'Barbarian',
	desc = 'Raging warriors of the wilds.\n\n +33% movement speed. HD d12, BAB +1, Fort +2 at first class level. 16 skill points at 1st character level.\n\n BAB +1, Fort +1, Will +0.5, Ref +0.5, 4 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="iron battleaxe", ego_chance=-1000 },
			{ name="chain mail", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 12, --4x skill points at 1st character level
		movement_speed_bonus = 0.33
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
		[ActorTalents.T_MARTIAL_WEAPON_PROFICIENCY]=1,
		[ActorTalents.T_RAGE]=1,
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		},
		--Prevent another game-breaking combo; why would anyone want a fighter/spellcaster is beyond me
		background =
		{
			['Magical thief'] = "disallow",
			['Spellcaster'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) +2
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.skill_point = (actor.skill_point or 0) + 4

			if actor.descriptor.race == "Half-Orc" then
			actor.max_life = actor.max_life + 14
			else
			actor.max_life = actor.max_life + 12 end
		
		else

		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 4
			if actor.descriptor.race == "Half-Orc" then
			--Favored class bonuses
			actor.combat_attack = (actor.combat_attack or 0) + 1
			actor.max_life = actor.max_life + 14
			else
			actor.max_life = actor.max_life + 12 end
		end
	end,
} 

newBirthDescriptor {
	type = 'class',
	name = 'Bard',
	desc = 'Musicians and gentlefolk.\n\n HD d6, BAB +0, Ref +2, Fort +2 at first class level. 24 skill points at 1st character level.\n\n BAB +0.75, Ref +1, Fort +1, Will +0.5, 6 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="rapier", ego_chance=-1000 },
			{ name="chain shirt", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 18, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
		[ActorTalents.T_SHOW_SPELLBOOK]=1,
		[ActorTalents.T_BARDIC_CLW]=1,
		[ActorTalents.T_SUMMON_CREATURE_I]=1,
		[ActorTalents.T_SLEEP]=1,
		[ActorTalents.T_GREASE]=1,
	},
	talents_types = {
		["arcane/arcane"] = {true, 0.0},
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		},
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 6
			if actor.descriptor.race == "Half-Elf" or actor.descriptor.race == "Gnome" then
			actor.max_life = actor.max_life + 8
			else
			actor.max_life = actor.max_life + 6 end
		
		else

		actor.combat_bab = (actor.combat_bab or 0) + 0.75
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 4
		if actor.descriptor.race == "Half-Elf" or actor.descriptor.race == "Gnome" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 8
		else
		actor.max_life = actor.max_life + 6 end
		end
	end,
} 


newBirthDescriptor {
	type = 'class',
	name = 'Cleric',
	desc = 'Clerics are masters of healing.\n\n HD d8. Fort +2, Will +2 at first class level. 8 skill points at 1st character level.\n\n BAB +0.75, Will +1, Fort +1, Ref +0.5,  2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="heavy mace", ego_chance=-1000 },
			{ name="chain mail", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 6, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_SHOW_SPELLBOOK]=1,
		[ActorTalents.T_CURE_LIGHT_WOUNDS]=1,
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_HEAVY_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
	},
	talents_types = {
		["cleric/cleric"] = {true, 0.0},
		["divine/divine"] = {true, 0.0}
	},
	descriptor_choices = {
		domains = {
			__ALL__ = "allow",
		},
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.will_save = (actor.will_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 2
			if (actor.descriptor.race == "Drow" and actor.descriptor.sex == "Female") or actor.descriptor.race == "Half-Drow" then
			actor.max_life = actor.max_life + 10
			else
			actor.max_life = actor.max_life + 8 end
			
		else

		actor.will_save = (actor.will_save or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.combat_bab = (actor.combat_bab or 0) + 0.75
		actor.skill_point = (actor.skill_point or 0) + 2

		if (actor.descriptor.race == "Drow" and actor.descriptor.sex == "Female") or actor.descriptor.race == "Half-Drow" then
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 1
		else
		actor.max_life = actor.max_life + 8 end
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Druid',
	desc = 'Clerics of nature.\n\n HD d8. Fort +2 Will +2 at first class level. 8 skill points at 1st character level.\n\n BAB +0.75, Will +1, Fort +1, Ref +0.5,  2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="quarterstaff", ego_chance=-1000 },
			{ name="padded armor", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 12, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_CURE_LIGHT_WOUNDS]=1,
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Evil'] = "disallow",
			['Chaotic Good'] = "disallow",
			['Chaotic Evil'] = "disallow",
		},
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.will_save = (actor.will_save or 0) + 2

			actor.max_life = actor.max_life + 8
			actor.skill_point = (actor.skill_point or 0) + 2
		
		else
		actor.will_save = (actor.will_save or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.combat_bab = (actor.combat_bab or 0) + 0.75

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 4
		end
	end,
}   


newBirthDescriptor {
	type = 'class',
	name = 'Fighter',
	desc = 'Simple fighters, they hack away with their trusty weapon.\n\n HD d10, BAB +1, Fort +2 at 1st class level. 8 skill points at 1st character level.\n\n BAB +1, Fort +1, Ref +0.5, Will +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword", ego_chance=-1000 },
			{ name="chain mail", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 6, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_HEAVY_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
		[ActorTalents.T_MARTIAL_WEAPON_PROFICIENCY]=1,
	},
	descriptor_choices =
	{
		--Prevent another game-breaking combo; why would anyone want a fighter/spellcaster is beyond me
		background =
		{
			['Spellcaster'] = "disallow",
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.skill_point = (actor.skill_point or 0) + 2
			if actor.descriptor.race == "Dwarf" or actor.descriptor.race == "Duergar" then
			actor.max_life = actor.max_life + 12
			else
			actor.max_life = actor.max_life + 10 end
		
		else

		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		if actor.descriptor.race == "Dwarf" or actor.descriptor.race == "Duergar" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 12
		end
		actor.max_life = actor.max_life + 10
		actor.skill_point = (actor.skill_point or 0) + 2
		end
	end,
}


newBirthDescriptor {
	type = 'class',
	name = 'Ranger',
	desc = 'Rangers are capable archers but are also trained in hand to hand combat and divine magic.\n\n HD d8, BAB +1, Fort +2, Ref +2 at first class level. 24 skill points at 1st character level. \n\n BAB +1, Fort +1, Ref +1, Will +0.5, 6 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword", ego_chance=-1000 },
			{ name="iron dagger", ego_chance=-1000 },
			{ name="studded leather", ego_chance=-1000 },

		},
		resolvers.inventory {
			full_id=true,
			{ name="shortbow", ego_chance=-1000},
			{ name="arrows (20)", ego_chance=-1000 },
		},

	},
	copy_add = {
		skill_point = 18, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
		[ActorTalents.T_MARTIAL_WEAPON_PROFICIENCY]=1,
		[ActorTalents.T_FAVORED_ENEMY]=1,
	},
	descriptor_choices =
	{
		--Prevent another game-breaking combo
		background =
		{
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 6
			if actor.descriptor.race == "Elf" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 10	
			else
			actor.max_life = actor.max_life + 8 end
		
		else
		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 6
		if actor.descriptor.race == "Elf" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 10
		else
		actor.max_life = actor.max_life + 8 end
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Rogue',
	desc = 'Rogues are masters of tricks.\n\n HD d6, Ref +2 at first class level. 32 skill points at 1st character level.\n\n BAB +0.75, Ref +1, Fort +0.5, Will +0.5, 8 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="light crossbow", ego_chance=-1000 },
			{ name="bolts (10)", ego_chance=-1000 },
			{ name="studded leather", ego_chance=-1000 },
		},
		resolvers.inventory {
			full_id=true,
			{ name="iron dagger", ego_chance=-1000},
		}
	},
	copy_add = {
		sneak_attack = 1,
		skill_point = 24, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		},
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.sneak_attack = (actor.sneak_attack or 0) + 1
			actor.skill_point = (actor.skill_point or 0) + 8
			if  actor.descriptor.race == "Deep gnome" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 8
			else
			actor.max_life = actor.max_life + 6 end
		
		else

		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.75
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 8
		if actor.descriptor.race == "Deep gnome" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 8
		else
		actor.max_life = actor.max_life + 6 end
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Wizard',
	desc = 'Masters of arcane magic.\n\n HD d4, Will +2 at first character level. 8 skill points at 1st class level.\n\n BAB +0.5, Will +1, Ref +0.5, Fort +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="iron dagger", ego_chance=-1000 },

		},
		resolvers.inventory {
			full_id=true,
			{ name="light crossbow", ego_chance=-1000},
			{ name="bolts (10)", ego_chance=-1000},
		}

	},
	copy_add = {
		skill_point = 6, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_SHOW_SPELLBOOK]=1,
		[ActorTalents.T_ACID_SPLASH]=1,
		[ActorTalents.T_GREASE]=1,
		[ActorTalents.T_MAGIC_MISSILE]=1,
		[ActorTalents.T_BURNING_HANDS]=1,
		[ActorTalents.T_SUMMON_CREATURE_I]=1,
		[ActorTalents.T_SLEEP]=1,
		[ActorTalents.T_BLINDNESS_DEAFNESS]=1,
	},
	talents_types = {
		["arcane/arcane"] = {true, 0.0},
	},
	descriptor_choices =
	{
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.will_save = (actor.will_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 2
			if actor.descriptor.race == "Drow" and actor.descriptor.sex == "Male" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 6
			else
			actor.max_life = actor.max_life + 4 end
		
		else

		--Learn a new spell tier every 3rd level
		if 3 % level == 0 then
			local spell_level = (level / 3) + 1
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
		        if t.type[1] == "arcane/arcane" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
		        	actor:learnTalent(t.id)
		        end
		    end
		end

		actor.will_save = (actor.will_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 2
		if actor.descriptor.race == "Drow" and actor.descriptor.sex == "Male" then
		--Favored class bonuses
		actor.max_life = actor.max_life + 6
		else
		actor.max_life = actor.max_life + 4 end

		end
	end,
}


--Non-standard classes
newBirthDescriptor {
	type = 'class',
	name = 'Warlock',
	desc = 'A spellcaster who needs no weapon.\n\n HD d6, Will +2 at first character level. 8 skill points at 1st class level.\n\n BAB +0.5, Will +1, Ref +0.5, Fort +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword", ego_chance=-1000 },
			{ name="chain shirt", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 6, --4x skill points at start
	},
	talents = {
		[ActorTalents.T_ELDRITCH_BLAST]=1,
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
	},
	descriptor_choices =
	{
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.will_save = (actor.will_save or 0) + 2
			actor.max_life = actor.max_life + 4
			actor.skill_point = (actor.skill_point or 0) + 2
		
		else

		actor.will_save = (actor.will_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.reflex_save = (actor.reflex_save or 0) + 0.5

		actor.max_life = actor.max_life + 6
		actor.skill_point = (actor.skill_point or 0) + 2
		end
	end,
} 

--Prestige classes!
newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Shadowdancer',
	desc = [[Requires Move Silently 8 ranks and Hide 10 ranks.

	Skilled rogues who can summon shades and hide in plain sight.]],
	can_level = function(actor)
		if actor.classes and actor.classes["Shadowdancer"] and actor.classes["Shadowdancer"] >= 10 then return false end
		if actor.skill_movesilently >= 8 and actor.skill_hide >= 10 then return true end

		return false
	end,
	on_level = function(actor, level)
		if level == 1 then actor.reflex_save = (actor.reflex_save or 0) + 2
			--grant hide in plain sight
		elseif level == 2 then 
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 1
		
		-- only if he doesn't have better infravision already
			if actor.infravision and actor.infravision > 3 then
				actor.infravision = actor.infravision + 1
			else
				actor.infravision = 3
			end
		
		else
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		end
	end,
} 

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Assasin',
	desc = [[Requires Move Silently 8 ranks and Hide 8 ranks.

	Evil backstabbers who want to kill just for the fun of it.]],
	can_level = function(actor)
		if actor.classes and actor.classes["Assasin"] and actor.classes["Assasin"] >= 10 then return false end
	--	if player.descriptor.alignment ~= "Neutral Evil" or player.descriptor.alignment == "Lawful Evil" or player.descriptor.alignment == "Chaotic Evil" then
		if actor.skill_movesilently >= 8 and actor.skill_hide >= 8 then return true end

		return false
	
	end,
	on_level = function(actor, level)
		if level == 1 then actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 3 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 5 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 7 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 9 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		
		else
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		end
	end,
} 