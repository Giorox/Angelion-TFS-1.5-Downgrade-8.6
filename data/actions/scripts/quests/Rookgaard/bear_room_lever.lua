local rockID = 1304
local rockPos = {x=32145, y=32101, z=11, stackpos=1}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local rockTile = Tile(rockPos)

    if item:getId() == 1946 then  -- Unactivated lever - Put rock back in place
        Game.createItem(rockID, 1, rockPos)
        item:transform(1945)
    elseif item:getId() == 1945 then  -- Activated lever - remove rock
        local rock = rockTile:getItemById(rockID)
        if rock:getId() == rockID then
            Position(rockPos):sendMagicEffect(CONST_ME_POFF)
            rock:remove()
        end
        item:transform(1946)
    end

    return true
end
