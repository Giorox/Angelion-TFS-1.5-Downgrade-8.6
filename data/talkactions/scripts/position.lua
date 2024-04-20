function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return false
	end

	if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return false
	end

	if param ~= "" then
		local split = param:split(",")
		player:teleportTo(Position(split[1], split[2], split[3]))
	end

	return false
end
