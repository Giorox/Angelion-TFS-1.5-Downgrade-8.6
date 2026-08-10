function resetItem(item, count, pos)
    -- Check if there's a hole, remove if so
    local hole = Tile(pos):getGround()
    if hole:getId() == 383 then
        hole:transform(9024)
    end

    -- Create item
    local newItem = Game.createItem(item, count, pos)

    -- Recreate hole
    local ground = Tile(pos):getItemById(9024)
    if ground then
        ground:transform(383)
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Naginata Quest Rock
    if toPosition == Position({x=32356, y=32074, z=10}) and target:getId() == 1304 then
	    if math.random(1, 10) <= 8 then
	    	doTargetCombat(0, player, COMBAT_PHYSICALDAMAGE, -150, -200, CONST_ME_DRAWBLOOD)
	    end

        addEvent(resetItem, 4 * 60 * 60 * 1000, 1304, 1, target:getPosition())  -- Reset in 4 hours
        target:getPosition():sendMagicEffect(CONST_ME_HITAREA)
        target:remove(1)
        return true
    end

	return onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
end
