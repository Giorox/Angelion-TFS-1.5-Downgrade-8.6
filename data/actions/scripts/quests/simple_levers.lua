-- Simple Lever System by Giorox
local levers = {
	[2007] = {  -- Behemoth Quest Lever - Edron
        id = 1304, 
        pos = {
            {x=33295, y=31677, z=15, stackpos=1},
            {x=33296, y=31677, z=15, stackpos=1},
            {x=33297, y=31677, z=15, stackpos=1},
            {x=33298, y=31677, z=15, stackpos=1},
            {x=33299, y=31677, z=15, stackpos=1}
        },
        effect = CONST_ME_HITAREA
    },
	[5638] = { -- Bear Room Lever - Rookgaard
        id = 1304,
        pos =  {
            {x=32145, y=32101, z=11, stackpos=1}
        },
        effect = CONST_ME_POFF
    },
}

local transformId = {
    [1945] = 1946, [1946] = 1945 -- lever
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local questId = item:getUniqueId()
    if questId == nil then
        return false
    end

    local target = levers[questId]
	if not target then
		return false
	end

    if item:getId() ~= 1945 and item:getId() ~= 1946 then
        return false
    end

    local itemExists = Tile(target.pos[1]):getItemById(target.id)

    if itemExists then
        for _, coord in pairs(target.pos) do
            local targetItem = Tile(coord):getItemById(target.id)
            if targetItem then
                targetItem:remove()
                Position(coord):sendMagicEffect(target.effect)
            end
        end
    else
        for _, coord in pairs(target.pos) do
            Game.createItem(target.id, 1, coord)
        end
    end

    item:transform(transformId[item:getId()])
    return true
end
