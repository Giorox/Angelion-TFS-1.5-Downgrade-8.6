local creatureevent = CreatureEvent("EasterLoot")

-- Set flag for this event
isActive = false
currDate = os.time()
if (os.time{year=os.date("%Y"), month=4, day=16} <= currDate) and (currDate <= os.time{year=os.date("%Y"), month=4, day=23}) then
    isActive = true
end

eggs = {6541, 6542, 6543, 6544, 6545}  -- Coloured eggs item ids
addChance = 50  -- 60% chance of dropping a coloured egg
maxEggs = 2  -- Maximum amount of eggs dropped per creature

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if isActive then
        if math.random(100) < addChance then
	    	corpse:addItem(eggs[math.random(#eggs)], math.random(maxEggs))
	    end
    end
	return true
end

creatureevent:register()
