local whiteTrapDoorID = 433
local floordID = 424
local trapDoorPos = {x=32225, y=32282, z=9, stackpos=1}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() or creature:isInGhostMode() then
		return true
	end

    local floorTile = Tile(trapDoorPos):getItemById(floordID)
    if floorTile then
        floorTile:transform(whiteTrapDoorID)
    end

    Position(trapDoorPos):sendMagicEffect(CONST_ME_MAGIC_BLUE)
    item:transform(425)
	return true
end

function onStepOut(creature, item, position, fromPosition)
	if creature:isPlayer() and creature:isInGhostMode() then
		return true
	end

    local trapDoorTile = Tile(trapDoorPos):getItemById(whiteTrapDoorID)
	if trapDoorTile then
        trapDoorTile:transform(floordID)
    end

    Position(trapDoorPos):sendMagicEffect(CONST_ME_MAGIC_BLUE)
    item:transform(426)
	return true
end
