local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 13 * 1000},
	{key = CONDITION_PARAM_SKILL_DISTANCEPERCENT, value = math.random(25, 50)}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end