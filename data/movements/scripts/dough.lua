function onAddItem(moveitem, tileitem, position)
	if moveitem:getId() == 2693 then -- Bread
		moveitem:transform(2689)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
	elseif moveitem:getId() == 6277 then -- Cake
		moveitem:transform(6278)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
    elseif moveitem:getId() == 8846 then -- Chocolate Cake
		moveitem:transform(8847)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
    elseif moveitem:getId() == 9113 then  -- Garlic Bread
		moveitem:transform(9111)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
    elseif moveitem:getId() == 8848 then  -- Baking Tray with cookies
		moveitem:transform(2561)
        Game.createItem(2687, 12, position)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
    elseif moveitem:getId() == 9115 then  -- Baking Tray with GARLIC cookies
		moveitem:transform(2561)
        Game.createItem(9116, 12, position)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
	end
	return true
end
