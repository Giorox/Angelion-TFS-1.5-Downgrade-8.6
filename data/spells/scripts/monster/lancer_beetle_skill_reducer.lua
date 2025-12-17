local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ANI_POISON)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ME_POISONAREA)

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 6 * 1000},
	{key = CONDITION_PARAM_SKILL_DISTANCEPERCENT, value = math.random(15, 40)}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end
