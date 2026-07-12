local doorID = 5108
local doorPos = {x=32177, y=32148, z=11, stackpos=1}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local doorTile = Tile(doorPos)

    if item:getId() == 1945 then  -- Activated lever - Close door
        doorTile:getItemById(5109):transform(5108)
        item:transform(1946)
    elseif item:getId() == 1946 then  -- Unactivated lever - Open door
        doorTile:getItemById(5108):transform(5109)
        item:transform(1945)
    end

    return true
end
