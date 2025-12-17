local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_LARGEROCK)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_TELEPORT)

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 3 * 1000},
	{key = CONDITION_PARAM_SKILL_MELEEPERCENT, value = math.random(0, 30)},
	{key = CONDITION_PARAM_SKILL_SHIELDINGPERCENT, value = math.random(0, 30)}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end