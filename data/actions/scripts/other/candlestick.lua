local candlestickIds = {2041, 2042, 2047, 2048}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itemId = item.itemid
	local targetId = target.itemid
	if not table.contains(candlestickIds, targetId) then
		return false
	end

	if itemId == 2096 then -- Pumpkinhead turns into Jack'o Lantern
		item:transform(2097)
    elseif itemId == 2229 then -- Skull turns into Skull Candle
        item:transform(5812)
        target:remove(1)
	end

	return true
end
