local boss = "Man In The Cave"
local bossPos = {x=32133,y=31147,z=2}  -- This is roughly the position to check for Man In The Cave
local newpos = {x=32131,y=31148,z=2}

local function checkArea(pos, monster)
	local spectators = getSpectators(pos, 8, 8) -- 4 tile left, 4 right, 4 up, 4 down
	if spectators ~= NULL then
        for _, pid in pairs(spectators) do
            if isMonster(pid) and getCreatureName(pid):lower() == monster:lower() then
                return true
            end
        end
	end
	return false
end

function onStepIn(creature, item, position, fromPosition)
    -- If player steps in the floor set with the unique id, and the boss is spawned, he gets "ROPED" up
    if item.uid == 6708 and checkArea(bossPos, boss) == TRUE then
	    creature:teleportTo(newpos, FALSE)
    end

    return true
end
