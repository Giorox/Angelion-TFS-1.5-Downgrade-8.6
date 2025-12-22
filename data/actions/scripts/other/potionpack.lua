function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:addItem(7618, 5) -- Give 5 health potions
	player:addItem(7620, 5) -- and 5 mana potions
	item:remove()
	return true
end
