--Veins of the Earth
--Zireael 2014

require "engine.class"

local Dialog = require "engine.ui.Dialog"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Textzone = require "engine.ui.Textzone"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(l, actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 14)
    self.title_shadow = false
    self.ui = "parchment"

    Dialog.init(self, "#BLACK#Lore found: "..l.name, game.w * 0.3, game.h*0.3, nil, nil, font)

    local text = "#BLACK#"..l.lore.."#LAST#"
    
    self.c_text = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = text}

    self:loadUI{
        {left=0, top=0, ui=self.c_text},
    }
    self:setupUI(false, true)
    
    self:setFocus(self.c_text)
    

    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end

