local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)
combat:setArea(createCombatArea(AREA_SQUAREWAVE6))

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 20 * 1000},
	{key = CONDITION_PARAM_SKILL_DISTANCEPERCENT, value = math.random(25, 40)}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end