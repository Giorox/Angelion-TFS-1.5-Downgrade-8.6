function onUse(player, chest, fromPosition, target, toPosition, isHotkey)
    local questId = chest:getUniqueId()
    if questId == nil then
        return false
    end

    if not chest:getType():isContainer() then
        error(string.format("[Error - LittleQuestChests::%d] Item %d is not a container.", questId, chest:getId()))
    end

    if player:getStorageValue(questId) ~= -1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
        return true
    end

    local items = chest:getItems()
    if #items == 0 then
        error(string.format("[Error - LittleQuestChests::%d] No items found for quest %d", questId, questId))
    end

    local totalWeight = 0
    for _, item in pairs(items) do
        totalWeight = totalWeight + item:getWeight()
    end

    if player:getFreeCapacity() < totalWeight then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHCAPACITY)
        return true
    end

    player:setStorageValue(questId, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have found %s.", chest:getContentDescription()))
    for _, item in pairs(items) do
        player:addItemEx(item:clone(), true)
    end
    return true
end
