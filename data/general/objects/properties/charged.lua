--Veins of the Earth
--Zireael 2014-2016

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

--ID
newEntity{
	name = " of identify", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "divination",
    use_simple = { name = "read",
    use = function(self, who)
        local inven = game.player:getInven("INVEN")
        local d d = who:showInventory("Identify which item?", inven, function(o) return not o.identified end, function(o, item)
            if o.identified == false then o.identified = true end
        end)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

--Targeted spells
newEntity{
	name = " of magic missile", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "evocation",
    use_simple = { name = "read",
    use = function(self, who)
        local tg = {type="bolt", range=5, display={display='*',color=colors.ORCHID}}
        local x, y = who:getTarget(tg)
        local _ _, _, _, x, y = who:canProject(tg, x, y)
        if not x or not y then return nil end

        local damage = rng.dice(1,4)+1

        who:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
end
},
}

newEntity{
    name = " of burning hands", suffix = true, addon=true,
	level_range = {3, nil},
    rarity = 5,
    cost = resolvers.value{platinum=450},
    school = "evocation",
    use_simple = { name = "read",
    use = function(self, who)
        local tg = {type="cone", range=0, radius=3, nolock = true, selffire=false, talent=t}
        local x, y = who:getTarget(tg)
        local _ _, _, _, x, y = who:canProject(tg, x, y)
        if not x or not y then return nil end

        local damage = rng.dice(1,4)+1

        self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc = 15})
        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
end
},
}



--[[newEntity{
    name = " of sleep", suffix = true,
    level_range = {1, 10},
    rarity = 5,
    cost = resolvers.value{platinum=450},
    school = "enchantment",
    use_simple = { name = "read",
    use = function(self, who)
        local tg = {type="cone", range=0, radius=4, nolock = true, selffire=false, talent=t}
        local x, y = who:getTarget(tg)
        local _ _, _, _, x, y = who:canProject(tg, x, y)
        if not x or not y then return nil end

        local damage = rng.dice(1,4)+1

        who:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
end
},
}]]



--Buffs
newEntity{
    name = " of mage armor", suffix = true, addon=true,
	level_range = {3, nil},
    rarity = 5,
--  cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "conjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_MAGE_ARMOR, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of delay poison", suffix = true, addon=true,
	level_range = {3, nil},
    rarity = 5,
--  cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "conjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_DELAY_POISON, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from evil", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_EVIL, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from good", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_GOOD, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from chaos", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_CHAOS, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from law", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_LAW, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from acid", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_ACID, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from cold", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_COLD, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from fire", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_FIRE, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from electric", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_ELECTRIC, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from sonic", suffix = true, addon=true,
	level_range = {3, nil},
	rarity = 5,
--	cost = 450,
    cost = resolvers.value{platinum=450},
    school = "abjuration",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_SONIC, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}


newEntity{
    name = " of levitation", suffix = true, addon=true,
    level_range = {3, nil},
    rarity = 15,
--  cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_LEVITATE, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of bear endurance", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of bull strength", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
       who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of cat's grace", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
       who:setEffect(who.EFF_CAT_GRACE, 5, {})
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of fox cunning", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of owl wisdom", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of eagle splendor", suffix = true, addon=true,
	level_range = {9, nil},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}


newEntity{
    name = " of flying", suffix = true, addon=true,
    level_range = {9, nil},
    rarity = 15,
--  cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_FLY, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of haste", suffix = true, addon=true,
    level_range = {9, nil},
    rarity = 25,
--  cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_HASTE, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of expeditious retreat", suffix = true, addon=true,
    level_range = {1, nil},
    rarity = 15,
--  cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "read",
    use = function(self, who)
    who:setEffect(who.EFF_EXPEDITIOUS_RETREAT, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}
