local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 20 * 1000},
	{key = CONDITION_PARAM_SKILL_MELEEPERCENT, value = math.random(70, 80)}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end