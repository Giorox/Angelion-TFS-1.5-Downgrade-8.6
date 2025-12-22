function onAddItem(moveitem, tileitem, position)
	if moveitem:getId() == 2047 or moveitem:getId() == 2048 then -- Moving candlestick on top of a decorated cake
		tileitem:transform(6280)
        moveitem:remove(1)
	end
	return true
end
