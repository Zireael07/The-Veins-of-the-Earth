-- Underdark
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- 



newBirthDescriptor{
	type = "base",
	name = "base",
	desc = {
	},
	experience = 1.0,
        body = { MAIN_HAND=1, OFF_HAND=1, BODY=1, CLOAK=1, LAUNCHER=1, QUIVER=1, GLOVES=1, BOOTS=1, HELM=1, RING=2, AMULET=1, LITE=1, TOOL=1, INVEN=23 },

	copy = {
		str = 0,
		dex = 0,
		con = 0,
		int = 0,
		wis = 0,
		cha = 0,
		luc = 0,
		lite = 4,
		money = 10,
		max_life = 10,
		max_level = 100,

	},
}

newBirthDescriptor {
  type = 'sex',
  name = 'Female',
  desc = [[You are a female of the species.  There is no in-game difference between the two sexes.]],
}

newBirthDescriptor {
  type = 'sex',
  name = 'Male',
  desc = [[You are a male of the species.  There is no in-game difference between the two sexes.]],
}

load('/data/birth/race-class.lua')