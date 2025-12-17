local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_THROWINGKNIFE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_RED)

local parameters = {
	{key = CONDITION_PARAM_TICKS, value = 10 * 1000},
	{key = CONDITION_PARAM_SKILL_MELEEPERCENT, value = 30}
}

function onCastSpell(creature, variant)
	for _, target in ipairs(combat:getTargets(creature, variant)) do
		target:addAttributeCondition(parameters)
	end
	return true
end