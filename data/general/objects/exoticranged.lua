--Veins of the Earth
--Zireael 2013-2015

local Talents = require "engine.interface.ActorTalents"

--Exotic ranged weapons

newEntity{
    define_as = "BASE_EXOTIC_RANGED",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon",
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    addons = "/data/general/objects/properties/bonus_weapons.lua",
    egos = "/data/general/objects/properties/weapons.lua",
    egos_chance = resolvers.ego_chance(), --egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_EXOTIC_RANGED",
    define_as = "BASE_HANDXBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="crossbow",
    require = { talent = { Talents.T_HAND_CROSSBOW_PROFICIENCY }, },
    image = "tiles/object/crossbow_hand.png",
    display = "}", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("hand_crossbow"),
    encumber = 2,
    rarity = 10,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    desc = "A normal trusty hand crossbow.\n\n",
    name = "hand crossbow",
    level_range = {1, 10},
--    cost = 100,
    cost = resolvers.value{silver=175},
    combat = {
        dam = {1,4},
        threat = 1,
        range = 3,
    },
}
