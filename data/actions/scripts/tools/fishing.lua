local waterIds = {493, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 7236, 10499}
local giantShimmeringPearls = {7632, 7633}
local useWorms = true

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target.itemid
	if not table.contains(waterIds, targetId) then
		return false
	end

	if targetId == 10499 then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player:getId() then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are not the owner.")
			return true
		end

		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		target:transform(targetId + 1)
		target:decay()

		local rareChance = math.random(1, 10000)
		if 9109 <= rareChance and rareChance < 9625 then  -- 5.16% chance - White Pearl
			player:addItem(2143, 1)
		elseif 9625 <= rareChance and rareChance < 9800 then -- 1.75% chance - Small Sapphire
			player:addItem(2146, 1)
		elseif 9800 <= rareChance and rareChance < 9975 then -- 1.75% chance - Small Emerald
			player:addItem(2149, 1)
		elseif 9975 <= rareChance and rareChance < 10000 then -- 0.25% chance - Giant Shimmering Pearl
			player:addItem(giantShimmeringPearls[math.random(#giantShimmeringPearls)], 1)
        elseif rareChance == 10000 then -- 1/10000 chance - Leviathan's Amulet
            player:addItem(10220, 1)
            player:addAchievementProgress("Lucky Devil", 2)
		end
		return true
	end

	if targetId ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end

	if targetId == 493 then
		return true
	end

	player:addSkillTries(SKILL_FISHING, 1)
	if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		if useWorms and not player:removeItem(3976, 1) then
			return true
		end

		if targetId == 7236 then
			target:transform(targetId + 1)
			target:decay()
			player:addAchievementProgress("Exquisite Taste", 250)

			local rareChance = math.random(1, 100)
			if rareChance == 1 then
				player:addItem(7158, 1)
				return true
			elseif rareChance <= 4 then
				player:addItem(2669, 1)
				return true
			elseif rareChance <= 10 then
				player:addItem(7159, 1)
				return true
			end
		end
		player:addAchievementProgress("Here, Fishy Fishy!", 1000)
		player:addItem(2667, 1)
	end
	return true
end
