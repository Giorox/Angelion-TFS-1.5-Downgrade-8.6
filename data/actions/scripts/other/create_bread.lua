local liquidContainers = {1775, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015, 2023, 2031, 2032, 2033}
local millstones = {1381, 1382, 1383, 1384}
local ovens = {1786, 1788, 1790, 1792}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item:getId()
	if itemId == 2692 then -- Convert flour to dough
		if target.type == FLUID_WATER and table.contains(liquidContainers, target.itemid) then -- Bread Dough
			item:remove(1)
			player:addItem(2693, 1)
			target:transform(target.itemid, FLUID_NONE)
			return true
        elseif target.type == FLUID_MILK and table.contains(liquidContainers, target.itemid) then -- Cake Dough
            item:remove(1)
			player:addItem(6277, 1)
			target:transform(target.itemid, FLUID_NONE)
            player:addAchievementProgress("The Cake's the Truth", 30)
			return true
        elseif target.itemid == 7494 then -- Special case for dough made with HOLY WATER
            item:remove(1)
			player:addItem(9112, 1)
			target:transform(2006, FLUID_NONE)
			return true
		end
    elseif itemId == 6277 then -- Convert cake dough 
        if target.itemid == 6574 then -- To chocolate cake dough using a Bar of Chocolate
            item:remove(1)
			player:addItem(8846, 1)
			target:remove(1)
            player:addAchievementProgress("Sweet Tooth", 10)
            if player:getAchievementProgress("With a Cherry on Top") >= 1 and not player:hasAchievement("Piece of Cake") then
                player:addAchievement("Piece of Cake")
            end
			return true
        elseif target.itemid == 2561 then -- To cookie tray using a Baking Tray
            item:remove(1)
			target:transform(8848)
            player:addAchievementProgress("Cookie Monster", 20)
			return true
        elseif table.contains(ovens, target.itemid) then  -- COOKING CAKE DOUGH HAS TO BE HERE, else it breaks
            item:remove(1)
            toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
            if target:getActionId() == 15800 and player:getStorageValue(Storage.GingerbreadRecipe) == 1 then -- Convert cake dough
                Game.createItem(6501, 1, toPosition)  -- to gingerbread cookie
	    	else
                Game.createItem(6278, 1, toPosition)  -- or to cake
            end
        end
    elseif itemId == 9112 then -- Convert holy water dough into garlic dough
        if target.itemid == 9114 then -- Garlic
            item:remove(1)
			player:addItem(9113, 1)
			target:remove(1)
			return true
        end
    elseif itemId == 9113 then -- Convert garlic dough to garlic cookies
        if target.itemid == 2561 then -- To garlic cookie tray using a Baking Tray
            item:remove(1)
			target:transform(9115)
			return true
        elseif table.contains(ovens, target.itemid) then  -- COOKING GARLIC DOUGH HAS TO BE HERE, else it breaks
            item:remove(1)
            toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
            Game.createItem(9111, 1, toPosition)
        end
    elseif itemId == 6280 then -- Blow out candles on Party Cake
        item:transform(6279)
        player:say(player:getName() .. " blew out the candle.", TALKTYPE_MONSTER_SAY)
        item:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:addAchievementProgress("Make a Wish", 5)
		return true
	elseif table.contains(millstones, target.itemid) then -- Convert wheat to flour
		item:remove(1)
		player:addItem(2692, 1)
		return true
    elseif table.contains(ovens, target.itemid) then -- Cooking the multiple doughs
        if itemId == 2693 then -- Bread dough
	    	Game.createItem(2689, 1, toPosition)
        elseif itemId == 8846 then -- Chocolate Cake dough
	    	Game.createItem(8847, 1, toPosition)
        elseif itemId == 8848 then  -- Baking Tray with cookies dough
	    	Game.createItem(2561, 1, toPosition)
            Game.createItem(2687, 12, toPosition)
        elseif itemId == 9115 then  -- Baking Tray with GARLIC cookies dough
	    	Game.createItem(2561, 1, toPosition)
            Game.createItem(9116, 12, toPosition)
	    end
        item:remove(1)
        toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
        return true
	end
	return false
end
