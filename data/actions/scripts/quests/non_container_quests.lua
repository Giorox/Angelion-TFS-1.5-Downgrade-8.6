local quests = {
    [50032] = { {count = 1, id = 2798} }, -- Bloord Herb Quest Dead Tree -- Reward: Blood Herb
	[55000] = { {count = 1, id = 2088, aid = 5010} }, -- Black Knight Dead Tree 1 -- Reward: Black Knight Villa Key (Silver Key 5010)
	[55001] = { {count = 1, id = 2088, aid = 5010} }, -- Black Knight Dead Tree 2 -- Reward: Black Knight Villa Key (Silver Key 5010)
	[55002] = { {count = 1, id = 2487} }, -- Black Knight Quest -- Reward: Crown Armor
	[55003] = { {count = 1, id = 2519} }, -- Black Knight Quest -- Reward: Crown Shield
    [56000] = { {count = 1, id = 2676} }, -- Rookgaard Premium Side Palm Tree -- Reward: Banana
	[56001] = { {count = 1, id = 2676} }, -- Rookgaard Free Side Palm Tree -- Reward: Banana
	[56002] = { {count = 1, id = 2485} }, -- Rookgaard Doublet Quest -- Reward: Doublet
    [64131] = { {count = 1, id = 2103} }, -- Rookgaard Wasp Tower -- Reward: Honeyflower
}

function onUse(player, nonContainer, fromPosition, target, toPosition, isHotkey)
    local questId = nonContainer:getUniqueId()
    if questId == nil then
        return false
    end

    local reward = quests[questId]
	if not reward then
		return false
	end

    if player:getStorageValue(questId) ~= -1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
        return true
    end

    if #reward == 0 then
        error(string.format("[Error - NonContainerQuest::%d] No items found for quest %d", questId, questId))
    end

    local totalWeight = 0
    for _, item in pairs(reward) do
        totalWeight = totalWeight + ItemType(item.id):getWeight()
    end

    if player:getFreeCapacity() < totalWeight then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHCAPACITY)
        return true
    end

    local contentDescription = ""
    for _, item in pairs(reward) do
		local key = player:addItem(item.id, item.count)
		if table.contains(keys, item.id) then
			key:setActionId(item.aid)
		end

        if contentDescription == "" then
            contentDescription = ItemType(item.id):getName()
        else
            contentDescription = contentDescription .. ", " .. ItemType(item.id):getName()
        end
    end

    player:setStorageValue(questId, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have found a %s.", contentDescription))

    return true
end
