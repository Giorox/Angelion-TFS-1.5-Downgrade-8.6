function onStepIn(creature, item, position, fromPosition)
    -- Position where player will be teleported to
	local isle = {x=32856, y=32332, z=6}

    -- Get player look direction to enable pushback
    playerDir = creature:getDirection()
	if playerDir == 0 then
		newdir = 2
		newdir2 = 2
	elseif playerDir== 1 then
		newdir = 3
		newdir2 = 3
	elseif playerDir == 2 then
		newdir = 0
		newdir2 = 0
	else
		newdir = 1
		newdir2 = 1
	end

    -- Check if player is a Druid or an Elder Druid
	if creature:getVocation():getId() == 2 or creature:getVocation():getId() == 6 then
        creature:teleportTo(isle)
        Position(isle):sendMagicEffect(11)
	else
        creature:say("Only Druids can enter.", TALKTYPE_ORANGE_1)
        creature:move(newdir)
        creature:move(newdir2)
		creature:getPosition():sendMagicEffect(3)
	end
end