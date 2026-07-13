local mwalID = 1498
local mwalPos = {
    {x=32186, y=31626, z=8, stackpos=1},
    {x=32187, y=31626, z=8, stackpos=1},
    {x=32188, y=31626, z=8, stackpos=1},
    {x=32189, y=31626, z=8, stackpos=1}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == 1945 or item:getId() == 1946 then  -- Remove magic walls
        for _, mwallCoord in pairs(mwalPos) do
            local mwall = Tile(mwallCoord):getItemById(mwalID)
            mwall:remove()
        end

        toPosition:sendMagicEffect(CONST_ME_POFF)
        item:remove()
    end

    return true
end
