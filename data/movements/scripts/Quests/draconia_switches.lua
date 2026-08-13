local switches = {
	[4251] = {  -- First switch, Draconia 3rd floor
        item = 1025,
        pos = {x=32796, y=31595, z=5, stackpos=1},
        effect = CONST_ME_MAGIC_BLUE
    },
    [4252] = {  -- Second switch, Draconia 3rd floor
        item = 1025,
        pos = {x=32796, y=31576, z=5, stackpos=1},
        effect = CONST_ME_MAGIC_BLUE
    },
    [4253] = {  -- Third switch (fake/decoy), Draconia 3rd floor
        item = 1026,
        pos = {x=32802, y=31589, z=5, stackpos=1},
        effect = CONST_ME_MAGIC_BLUE
    },
}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() or creature:isInGhostMode() then
		return true
	end

    local uID = item:getUniqueId()
    if uID == nil then
        return false
    end

    local target = switches[uID]
	if not target then
		return false
	end

    local tgtItem = Tile(target.pos):getItemById(target.item)
    if tgtItem then
        tgtItem:remove(1)
    end

    if target.effect then
        Position(target.pos):sendMagicEffect(target.effect)
    end
    item:transform(425)
	return true
end

function onStepOut(creature, item, position, fromPosition)
	if creature:isPlayer() and creature:isInGhostMode() then
		return true
	end

    local uID = item:getUniqueId()
    if uID == nil then
        return false
    end

    local target = switches[uID]
	if not target then
		return false
	end

    local tgtItem = Tile(target.pos):getItemById(target.item)
	if not tgtItem then
        Game.createItem(target.item, 1, target.pos)
    end

    if target.effect then
        Position(target.pos):sendMagicEffect(target.effect)
    end
    item:transform(426)
	return true
end
