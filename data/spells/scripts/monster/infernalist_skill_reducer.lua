local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 20 * 1000},
	{key = CONDITION_PARAM_SKILL_MELEEPERCENT, value = 50},
	{key = CONDITION_PARAM_SKILL_SHIELDINGPERCENT, value = 50}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end