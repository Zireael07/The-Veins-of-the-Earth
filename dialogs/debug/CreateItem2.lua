--Veins of the Earth
-- Zireael 2014-2015

--based on Zizzo's ToME port

require 'engine.class'
local Dialog = require 'engine.ui.Dialog'
local List = require 'engine.ui.List'
local Button = require 'engine.ui.Button'
local Numberbox = require 'engine.ui.Numberbox'
local TreeList = require "engine.ui.TreeList"

local Ego = require 'mod.class.Ego'

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
  self.ego_names = {}

  Dialog.init(self, 'Create Object', 800, 600)

  self:generateListCategory()
--    self:generateTree()

--new
  self.c_category = List.new {
  width = 100,
  nb_items = 20,
  display_prop = 'display',
  list = self.list_category,
  scrollbar = true,
  fct = function(item) self:setupItems(item) end,
}

--old
  self.c_items = List.new {
    width = 200,
    nb_items = 20,
    display_prop = 'display',
    list = {},
--    list = self.list,
    scrollbar = true,
    fct = function(item) self:selectItem(item) end,
  }

--[[  self.c_tree = TreeList.new{width=250, height=self.ih*0.8, scrollbar=true, columns={
      {width=100, display_prop="name"},
  }, tree=self.all_items,
      fct=function(item, sel, v) self:treeUse(item, sel, v) end,
      select=function(item, sel) end, --self:on_select(item) end,
      on_expand=function(item) end,
      on_drawitem=function(item) end,
  }]]

  self.c_pfx_egos = List.new {
    width = 200,
    nb_items = 15,
    display_prop = 'display',
    list = {},
    scrollbar = true,
    fct = function(item) self:selectEgo(item, self.c_pfx_egos, 'prefix') end,
  }
  self.c_sfx_egos = List.new {
    width = 200,
    nb_items = 15,
    display_prop = 'display',
    list = {},
    scrollbar = true,
    fct = function(item) self:selectEgo(item, self.c_sfx_egos, 'suffix') end,
  }
  self.c_nitems = Numberbox.new {
    title = 'Number: ',
    number = 1,
    min = 1,
    max = 100,
    chars = 3,
    fct = function(text) end,
  }
  self.c_create = Button.new {
    text = 'Create',
    fct = function() self:createItem() end,
  }
  self.c_close = Button.new {
    text = 'Close',
    fct = function() self.key:triggerVirtual('EXIT') end,
  }


  self:loadUI {
--    {left=0, top=0, ui=self.c_tree},
    {left=0, top=0, ui=self.c_category},
    { left=self.c_category.w, top=0, ui=self.c_items},
    { left=0, top=self.c_items.h, ui=self.c_nitems },
    { right=0, top=0, ui=self.c_sfx_egos },
    { right=self.c_sfx_egos.w, top=0, ui=self.c_pfx_egos },
    { right=0, bottom=0, ui=self.c_close },
    { right=self.c_close.w, bottom=0, ui=self.c_create },
  }

  self:setupUI()
  self:updateButton()

  self.key:addBinds {
    EXIT = function() game:unregisterDialog(self) end,
  }

end

function _M:onRegister()
  game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:readyToCreate()
  return self.sel_item and self.sel_item.e and self.c_nitems.number
end

function _M:updateButton()
  self:toggleDisplay(self.c_create, self:readyToCreate())
end

function _M:setDisplayText(item, which)
  local sel = which
  if type(sel) == 'string' then
    sel = (item.id and item.id == self.ego_names[which]) or
      (not item.id and not self.ego_names[which])
  end
  local name = item.base_display or item.name
  item.display = sel and '#{bold}#'..name..'#{normal}#' or name
end

function _M:selectItem(item)
  if self.sel_item and not self.sel_item.type then
    self:setDisplayText(self.sel_item, false)
    self.c_items:drawItem(self.sel_item)
  end
  self.sel_item = item
  if self.sel_item and not self.sel_item.type then
    self:setDisplayText(self.sel_item, true)
    self.c_items:drawItem(self.sel_item)
  end
  self:updateButton()
  if self.sel_item and not self.sel_item.unique then --and not self.sel_item.type then
      self:setupEgoLists()
    end

end

function _M:setupEgoLists()
  if not self.sel_item or not self.sel_item.e then
    self.c_pfx_egos.list = {}
    self.c_pfx_egos:generate()
    self.c_sfx_egos.list = {}
    self.c_sfx_egos:generate()
    self.ego_names = {}
    return
  end

  local Ego = require 'mod.class.Ego'

  local pfx_egos = { { name = 'No prefix ego' } }
  local sfx_egos = { { name = 'No suffix ego' } }

  for id, ego in ipairs(Ego:allowedEgosFor(self.sel_item.e)) do
    local dst = ego.prefix and pfx_egos or ego.suffix and sfx_egos
    local item = { name = ego.name, id = id }
    table.insert(dst, item)
--    game.log("Inserted ego: "..item.name)
  end
  self.ego_names = {}
  for _, item in ipairs(pfx_egos) do self:setDisplayText(item, 'prefix') end
  for _, item in ipairs(sfx_egos) do self:setDisplayText(item, 'suffix') end

  self.c_pfx_egos.list = pfx_egos
  self.c_pfx_egos:generate()
  self.c_sfx_egos.list = sfx_egos
  self.c_sfx_egos:generate()
end

function _M:selectEgo(item, c_egos, which)
  local egos = c_egos.list
  local prev_sel = self.ego_names[which] and egos[self.ego_names[which]] or egos[1]
  self.ego_names[which] = item.id
  self:setDisplayText(prev_sel, which)
  c_egos:drawItem(prev_sel)
  self:setDisplayText(item, which)
  c_egos:drawItem(item)
end

function _M:createItem()
  if not self:readyToCreate() then return end

    local qty = self.c_nitems.number

    local o = game.zone:makeEntity(game.level, "object", {name = self.sel_item.name, ego_chance=-1000}, nil, true)

    --sometimes filters prevent us from creating
    if o then
        o:setNumber(qty)

        if self.ego_names.prefix or self.ego_names.suffix then
            o.force_ego = {}
            for _, id in pairs(self.ego_names) do table.insert(o.force_ego, id) end
        end

        Ego:placeForcedEgos(o)

        game.zone:addEntity(game.level, o, 'object', game.player.x, game.player.y)
    	game.log('Created '..o.name)
    else
        game.log('Could not create the item')
    end
end

function _M:treeUse(item, sel, v)
	if not item then return end
	if item.nodes then
		for _, other in ipairs(self.c_tree.tree) do
			if other.shown then self.c_tree:treeExpand(false, other) end
		end
		self.c_tree:treeExpand(true, item)
	elseif item.e then
	--	self:use(item)
        self:selectItem(item)
	end
end

--Generate item tree
--[[function _M:generateTree()
	local player = game.player
	local oldtree = {}
	for i, t in ipairs(self.all_items or {}) do oldtree[t.id] = t.shown end

	local tree = {}
	local newsel = nil
	for i, e in ipairs(game.zone.object_list) do
				local nodes = {}

                if e.name and e.rarity and e.level_range then
                --    if #nodes == 0 or (nodes[type] and not nodes[type] == e.type) then --or (nodes[type] and not table.same_values(table.values(nodes.type), e.type)) then
                    local display = (e.unique and '#ffd700#' or '#ffffff#') .. e.name .. '#LAST#'
						nodes[#nodes+1] = {
							name = e.name,
                            type = e.type,
                            display = display,
                            unique = e.unique,
							e = e
						}

						if self.sel_feat and self.sel_feat.type == e.type then newsel = nodes[#nodes] end
                --    end
                end

				if #nodes > 0 then
					tree[#tree+1] = {
						name = e.type,
                        display = e.type,
						id = e.type,
						shown = oldtree[e.type],
						nodes = nodes,
					}
				end
	end

	self.all_items = tree
	if self.c_tree then
		self.c_tree.tree = self.all_items
		self.c_tree:generate()
		if newsel then self:treeUse(newsel)
		else
			self.sel_feat = nil
		end
	end
end]]



--Generate item list
function _M:generateList(type)
    local list = {}

    for i, e in ipairs(game.zone.object_list) do
        if e.name and e.rarity and e.type then
            local display = (e.unique and '#ffd700#' or '#ffffff#') .. e.name .. '#LAST#'

            list[#list+1] = {name=e.name, display=display, base_display=display, unique=e.unique, e=e}
        end
    end

    table.sort(list, function(a,b)
        if a.unique and not b.unique then return true
        elseif not a.unique and b.unique then return false end
        return a.name < b.name
    end)

    local chars = {}
    for i, v in ipairs(list) do
        v.name = v.name
        chars[self:makeKeyChar(i)] = i
    end
    list.chars = chars

    self.list = list
end

--Generate categories
function _M:generateListCategory()
    local list = {}
    local hits = {}

    for _, o in ipairs(game.zone.object_list) do
        if o.type and _G.type(o.type) == "string" then
            local name = o.type
            local key = o.type
            local display = "#ffffff#".. name ..'#LAST'

            if not hits[key] then
      	         list[#list+1] = { name=key, filter={ type=o.type,}} --subtype=o.subtype } }
      	         hits[key] = true
            end
        end
    end

    for _, item in ipairs(list) do self:setDisplayText(item, false) end

    table.sort(list, function(a,b) return a.name < b.name end)
    self.list_category = list
end

function _M:setupItems(item)
  if not item then return end
  local f = item.filter

  if self.sel_grp then
    self:setDisplayText(self.sel_grp, false)
    self.c_category:drawItem(self.sel_grp)
  end
  self.sel_grp = item
  if self.sel_grp then
    self:setDisplayText(self.sel_grp, true)
    self.c_category:drawItem(self.sel_grp)
  end

  local list = {}
  for _, o in ipairs(game.zone.object_list) do
    if o.name and o.rarity and o.type == f.type then --and o.subtype == f.subtype then
        list[#list+1] = { name = o.name, tmpl = o, e=o}
    end
  end
  for _, item in ipairs(list) do self:setDisplayText(item, false) end

  self.c_items.list = list
  self.c_items:generate()
  self:selectItem(nil)
  self:setFocus(self.c_items)
end
