local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 10 * 1000},
	{key = CONDITION_PARAM_SKILL_DISTANCEPERCENT, value = 10}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end