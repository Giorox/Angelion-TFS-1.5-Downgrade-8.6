local quests = {
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
	if not quests then
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
        player:addItem(item.id, item.count)
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
