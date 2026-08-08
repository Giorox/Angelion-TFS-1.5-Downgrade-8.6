-- Simple Lever System by Giorox
local levers = {
	[2007] = {  -- Behemoth Quest Lever - Edron
        id = 1304,  -- Big rock
        pos = {
            {x=33295, y=31677, z=15, stackpos=1},
            {x=33296, y=31677, z=15, stackpos=1},
            {x=33297, y=31677, z=15, stackpos=1},
            {x=33298, y=31677, z=15, stackpos=1},
            {x=33299, y=31677, z=15, stackpos=1}
        },
        effect = CONST_ME_HITAREA
    },
    [2008] = {  -- MoLS Lever
        id = 383,  -- Hole
        pos = {
            {x=32483, y=31633, z=9, stackpos=1}
        },
        effect = CONST_ME_HITAREA,
        action = "transform"
    },
    [5637] = { -- Katana Quest Lever - Rookgaard
        id = 5109,  -- Open Door
        pos = {
            {x=32177, y=32148, z=11, stackpos=1}
        },
        action = "transform"
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
    [1945] = 1946, [1946] = 1945, -- lever
    [383] = 9024, [9024] = 383, -- open shovel hole becomes cave floor
    [5108] = 5109, [5109] = 5108, -- open door becomes closed door
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
    local isTransform = target.action ~= nil

    if itemExists then
        for _, coord in pairs(target.pos) do
            local targetItem = Tile(coord):getItemById(target.id)
            if targetItem then
                if isTransform then
                    targetItem:transform(transformId[target.id])
                else
                    targetItem:remove()
                end

                if target.effect then
                    Position(coord):sendMagicEffect(target.effect)
                end
            end
        end
    else
        for _, coord in pairs(target.pos) do
            if isTransform then
                local targetItem = Tile(coord):getItemById(transformId[target.id])
                targetItem:transform(target.id)
            else
                Game.createItem(target.id, 1, coord)
            end
        end
    end

    item:transform(transformId[item:getId()])
    return true
end
