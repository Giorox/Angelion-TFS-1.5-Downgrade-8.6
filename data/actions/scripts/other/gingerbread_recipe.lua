function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local position = player:getPosition()
	if player:getStorageValue(Storage.GingerbreadRecipe) == -1 then
		position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:say("You can now make gingerbread from normal cake dough in Santa's bakery.", TALKTYPE_MONSTER_SAY)
        player:setStorageValue(Storage.GingerbreadRecipe, 1)
    else
        position:sendMagicEffect(CONST_ME_POFF)
        player:say("You already know how to make gingerbread.", TALKTYPE_MONSTER_SAY)
        return true
	end

	item:remove()
	return true
end
