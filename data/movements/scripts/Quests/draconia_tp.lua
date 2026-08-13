local puzzle =  {
    {id = 1945, pos = {x=32802, y=31584, z=1, stackpos=1}},
    {id = 1946, pos = {x=32803, y=31584, z=1, stackpos=1}},
    {id = 1945, pos = {x=32804, y=31584, z=1, stackpos=1}},
    {id = 1946, pos = {x=32805, y=31584, z=1, stackpos=1}}
}

local wrongAnswerDest = {x=32802, y=31587, z=1}
local rightAnswerDest = {x=32701, y=31639 , z=6}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() or creature:isInGhostMode() then
		return true
	end

    -- Check lever positions, if any are wrong, send back to corner of room
    for _, lever in pairs(puzzle) do
        if not Tile(lever.pos):getItemById(lever.id) then
            creature:teleportTo(wrongAnswerDest, false)
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    end

    -- Everything correct? Send to Ab'Dendriel
    creature:teleportTo(rightAnswerDest, false)
    creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end