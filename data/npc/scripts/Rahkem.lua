local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Please, not so loud, not so loud. Some of us are trying to rest in peace here.'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Twist of Fate
local blessKeyword = keywordHandler:addKeyword({'twist of fate'}, StdModule.say, {npcHandler = npcHandler,
	text = {
		'This is a special blessing I can bestow upon you once you have obtained at least one of the other blessings and which functions a bit differently. ...',
		'It only works when you\'re killed by other adventurers, which means that at least half of the damage leading to your death was caused by others, not by monsters or the environment. ...',
		'The {twist of fate} will not reduce the death penalty like the other blessings, but instead prevent you from losing your other blessings as well as the amulet of loss, should you wear one. It costs the same as the other blessings. ...',
		'Would you like to receive that protection for a sacrifice of |PVPBLESSCOST| gold, child?'
	}})
	blessKeyword:addChildKeyword({'yes'}, StdModule.bless, {npcHandler = npcHandler, text = 'So receive the protection of the twist of fate, pilgrim.', cost = '|PVPBLESSCOST|', bless = 6})
	blessKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Fine. You are free to decline my offer.', reset = true})

-- Healing
local function addHealKeyword(text, condition, effect)
	keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = text},
		function(player) return player:getCondition(condition) ~= nil end,
		function(player)
			player:removeCondition(condition)
			player:getPosition():sendMagicEffect(effect)
		end
	)
end

addHealKeyword('You are burning. Let me quench those flames.', CONDITION_FIRE, CONST_ME_MAGIC_GREEN)
addHealKeyword('You are poisoned. Let me soothe your pain.', CONDITION_POISON, CONST_ME_MAGIC_RED)
addHealKeyword('You are electrified, my child. Let me help you to stop trembling.', CONDITION_ENERGY, CONST_ME_MAGIC_GREEN)

keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'You are hurt, my child. I will heal your wounds.'},
	function(player) return player:getHealth() < 40 end,
	function(player)
		local health = player:getHealth()
		if health < 40 then player:addHealth(40 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'You aren\'t looking that bad. Sorry, I can\'t help you. But if you are looking for additional protection you should go on the {pilgrimage} of ashes or get the protection of the {twist of fate} here.'})

-- Wooden Stake
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'I think you have forgotten to bring your stake, pilgrim.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 8 and player:getItemCount(5941) == 0 end)

local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Yes, I was informed what to do. Are you prepared to receive my line of the prayer?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 8 end)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'So receive my prayer: \'Let there be power and compassion\'. Now, bring your stake to Brewster in Port Hope for the next line of the prayer. I will inform him what to do.', reset = true}, nil,
		function(player) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 9) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
	)
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'I will wait for you.', reset = true})

keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'You should visit Brewster in Port Hope now.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 9 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'You already received my line of the prayer.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) > 9 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'A blessed stake? That is a strange request. Maybe Quentin knows more, he is one of the oldest monks after all.'})

-- Basic
keywordHandler:addKeyword({'pilgrimage'}, StdModule.say, {npcHandler = npcHandler, text = 'Whenever you receive a lethal wound, your vital force is damaged and there is a chance that you lose some of your equipment. With every single of the five {blessings} you have, this damage and chance of loss will be reduced.'})
keywordHandler:addKeyword({'blessings'}, StdModule.say, {npcHandler = npcHandler, text = 'There are five blessings available in five sacred places: the {spiritual} shielding, the spark of the {phoenix}, the {embrace} of Tibia, the fire of the {suns} and the wisdom of {solitude}. Additionally, you can receive the {twist of fate} here.'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'I see you received the spiritual shielding in the whiteflower temple south of Thais.'}, function(player) return player:hasBlessing(1) end)
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'I can sense that the druids north of Carlin have provided you with the Embrace of Tibia.'}, function(player) return player:hasBlessing(2) end)
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'I can see you received the blessing of the two suns in the suntower near Ab\'Dendriel.'}, function(player) return player:hasBlessing(3) end)
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'I can sense that the spark of the phoenix already was given to you by the dwarven priests of earth and fire in Kazordoon.'}, function(player) return player:hasBlessing(4) end)
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'I can sense you already talked to the hermit Eremo on the isle of Cormaya and received this blessing.'}, function(player) return player:hasBlessing(5) end)
keywordHandler:addAliasKeyword({'wisdom'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'You can ask for the blessing of spiritual shielding in the whiteflower temple south of Thais.'})
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'The druids north of Carlin will provide you with the embrace of Tibia.'})
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'You can ask for the blessing of the two suns in the suntower near Ab\'Dendriel.'})
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'The spark of the phoenix is given by the dwarven priests of earth and fire in Kazordoon.'})
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'Talk to the hermit Eremo on the isle of Cormaya about this blessing.'})
keywordHandler:addAliasKeyword({'wisdom'})

npcHandler:addModule(FocusModule:new())


keywordHandler:addSpellKeyword({'animate','dead'}, {npcHandler = npcHandler, spellName = 'Animate Dead', price = 1200, level = 27, vocation ={2}})
keywordHandler:addSpellKeyword({'avalanche'}, {npcHandler = npcHandler, spellName = 'Avalanche', price = 1200, level = 30, vocation ={2}})
keywordHandler:addSpellKeyword({'chameleon'}, {npcHandler = npcHandler, spellName = 'Chameleon', price = 1300, level = 27, vocation ={2}})
keywordHandler:addSpellKeyword({'convince','creature'}, {npcHandler = npcHandler, spellName = 'Convince Creature', price = 800, level = 16, vocation ={2}})
keywordHandler:addSpellKeyword({'creature','illusion'}, {npcHandler = npcHandler, spellName = 'Creature Illusion', price = 1000, level = 23, vocation ={2}})
keywordHandler:addSpellKeyword({'cure','poison'}, {npcHandler = npcHandler, spellName = 'Cure Poison', price = 150, level = 10, vocation ={2}})
keywordHandler:addSpellKeyword({'cure','poison','rune'}, {npcHandler = npcHandler, spellName = 'Cure Poison Rune', price = 600, level = 15, vocation ={2}})
keywordHandler:addSpellKeyword({'destroy','field'}, {npcHandler = npcHandler, spellName = 'Destroy Field', price = 700, level = 17, vocation ={2}})
keywordHandler:addSpellKeyword({'disintegrate'}, {npcHandler = npcHandler, spellName = 'Disintegrate', price = 900, level = 21, vocation ={2}})
keywordHandler:addSpellKeyword({'energy','field'}, {npcHandler = npcHandler, spellName = 'Energy Field', price = 700, level = 18, vocation ={2}})
keywordHandler:addSpellKeyword({'energy','strike'}, {npcHandler = npcHandler, spellName = 'Energy Strike', price = 800, level = 12, vocation ={2}})
keywordHandler:addSpellKeyword({'energy','wall'}, {npcHandler = npcHandler, spellName = 'Energy Wall', price = 2500, level = 41, vocation ={2}})
keywordHandler:addSpellKeyword({'explosion'}, {npcHandler = npcHandler, spellName = 'Explosion', price = 1800, level = 31, vocation ={2}})
keywordHandler:addSpellKeyword({'find','person'}, {npcHandler = npcHandler, spellName = 'Find Person', price = 80, level = 8, vocation ={2}})
keywordHandler:addSpellKeyword({'fire','bomb'}, {npcHandler = npcHandler, spellName = 'Fire Bomb', price = 1500, level = 27, vocation ={2}})
keywordHandler:addSpellKeyword({'fire','field'}, {npcHandler = npcHandler, spellName = 'Fire Field', price = 500, level = 15, vocation ={2}})
keywordHandler:addSpellKeyword({'fire','wall'}, {npcHandler = npcHandler, spellName = 'Fire Wall', price = 2000, level = 33, vocation ={2}})
keywordHandler:addSpellKeyword({'flame','strike'}, {npcHandler = npcHandler, spellName = 'Flame Strike', price = 800, level = 14, vocation ={2}})
keywordHandler:addSpellKeyword({'food'}, {npcHandler = npcHandler, spellName = 'Food', price = 300, level = 14, vocation ={2}})
keywordHandler:addSpellKeyword({'great','light'}, {npcHandler = npcHandler, spellName = 'Great Light', price = 500, level = 13, vocation ={2}})
keywordHandler:addSpellKeyword({'haste'}, {npcHandler = npcHandler, spellName = 'Haste', price = 600, level = 14, vocation ={2}})
keywordHandler:addSpellKeyword({'heal','friend'}, {npcHandler = npcHandler, spellName = 'Heal Friend', price = 800, level = 18, vocation ={2}})
keywordHandler:addSpellKeyword({'heavy','magic','missile'}, {npcHandler = npcHandler, spellName = 'Heavy Magic Missile', price = 1500, level = 25, vocation ={2}})
keywordHandler:addSpellKeyword({'ice','strike'}, {npcHandler = npcHandler, spellName = 'Ice Strike', price = 800, level = 15, vocation ={2}})
keywordHandler:addSpellKeyword({'ice','wave'}, {npcHandler = npcHandler, spellName = 'Ice Wave', price = 850, level = 18, vocation ={2}})
keywordHandler:addSpellKeyword({'icicle'}, {npcHandler = npcHandler, spellName = 'Icicle', price = 1700, level = 28, vocation ={2}})
keywordHandler:addSpellKeyword({'intense','healing','rune'}, {npcHandler = npcHandler, spellName = 'Intense Healing Rune', price = 600, level = 15, vocation ={2}})
keywordHandler:addSpellKeyword({'invisible'}, {npcHandler = npcHandler, spellName = 'Invisible', price = 2000, level = 35, vocation ={2}})
keywordHandler:addSpellKeyword({'levitate'}, {npcHandler = npcHandler, spellName = 'Levitate', price = 500, level = 12, vocation ={2}})
keywordHandler:addSpellKeyword({'light'}, {npcHandler = npcHandler, spellName = 'Light', price = 0, level = 8, vocation ={2}})
keywordHandler:addSpellKeyword({'light','healing'}, {npcHandler = npcHandler, spellName = 'Light Healing', price = 0, level = 8, vocation ={2}})
keywordHandler:addSpellKeyword({'light','magic','missile'}, {npcHandler = npcHandler, spellName = 'Light Magic Missile', price = 500, level = 15, vocation ={2}})
keywordHandler:addSpellKeyword({'magic','rope'}, {npcHandler = npcHandler, spellName = 'Magic Rope', price = 200, level = 9, vocation ={2}})
keywordHandler:addSpellKeyword({'magic','shield'}, {npcHandler = npcHandler, spellName = 'Magic Shield', price = 450, level = 14, vocation ={2}})
keywordHandler:addSpellKeyword({'mass','healing'}, {npcHandler = npcHandler, spellName = 'Mass Healing', price = 2200, level = 36, vocation ={2}})
keywordHandler:addSpellKeyword({'poison','bomb'}, {npcHandler = npcHandler, spellName = 'Poison Bomb', price = 1000, level = 25, vocation ={2}})
keywordHandler:addSpellKeyword({'poison','field'}, {npcHandler = npcHandler, spellName = 'Poison Field', price = 300, level = 14, vocation ={2}})
keywordHandler:addSpellKeyword({'poison','wall'}, {npcHandler = npcHandler, spellName = 'Poison Wall', price = 1600, level = 29, vocation ={2}})
keywordHandler:addSpellKeyword({'soulfire'}, {npcHandler = npcHandler, spellName = 'Soulfire', price = 1800, level = 27, vocation ={2}})
keywordHandler:addSpellKeyword({'stalagmite'}, {npcHandler = npcHandler, spellName = 'Stalagmite', price = 1400, level = 24, vocation ={2}})
keywordHandler:addSpellKeyword({'stone','shower'}, {npcHandler = npcHandler, spellName = 'Stone Shower', price = 1100, level = 28, vocation ={2}})
keywordHandler:addSpellKeyword({'strong','haste'}, {npcHandler = npcHandler, spellName = 'Strong Haste', price = 1300, level = 20, vocation ={2}})
keywordHandler:addSpellKeyword({'summon','creature'}, {npcHandler = npcHandler, spellName = 'Summon Creature', price = 2000, level = 25, vocation ={2}})
keywordHandler:addSpellKeyword({'summon','grovebeast'}, {npcHandler = npcHandler, spellName = 'Summon Grovebeast', price = 50000, level = 200, vocation ={2}})
keywordHandler:addSpellKeyword({'terra','strike'}, {npcHandler = npcHandler, spellName = 'Terra Strike', price = 800, level = 13, vocation ={2}})
keywordHandler:addSpellKeyword({'terra','wave'}, {npcHandler = npcHandler, spellName = 'Terra Wave', price = 2500, level = 38, vocation ={2}})
keywordHandler:addSpellKeyword({'ultimate','healing'}, {npcHandler = npcHandler, spellName = 'Ultimate Healing', price = 1000, level = 30, vocation ={2}})
keywordHandler:addSpellKeyword({'ultimate','light'}, {npcHandler = npcHandler, spellName = 'Ultimate Light', price = 1600, level = 26, vocation ={2}})
keywordHandler:addKeyword({'attack', 'spells'}, StdModule.say, {npcHandler = npcHandler, text = "In this category I have '{Energy Strike}', '{Flame Strike}', '{Ice Strike}', '{Ice Wave}', '{Terra Strike}' and '{Terra Wave}'."})
keywordHandler:addKeyword({'healing', 'spells'}, StdModule.say, {npcHandler = npcHandler, text = "In this category I have '{Cure Poison}', '{Heal Friend}', '{Light Healing}', '{Mass Healing}' and '{Ultimate Healing}'."})
keywordHandler:addKeyword({'support', 'spells'}, StdModule.say, {npcHandler = npcHandler, text = "In this category I have '{Animate Dead}', '{Avalanche}', '{Chameleon}', '{Convince Creature}', '{Creature Illusion}', '{Cure Poison Rune}', '{Destroy Field}', '{Disintegrate}', '{Energy Field}', '{Energy Wall}', '{Explosion}', '{Find Person}', '{Fire Bomb}', '{Fire Field}', '{Fire Wall}', '{Food}', '{Great Light}', '{Haste}', '{Heavy Magic Missile}', '{Icicle}', '{Intense Healing Rune}', '{Invisible}', '{Levitate}', '{Light}', '{Light Magic Missile}', '{Magic Rope}', '{Magic Shield}', '{Poison Bomb}', '{Poison Field}', '{Poison Wall}', '{Soulfire}', '{Stalagmite}', '{Stone Shower}', '{Strong Haste}', '{Summon Creature}', '{Summon Grovebeast}' and '{Ultimate Light}'."})
keywordHandler:addKeyword({'spells'}, StdModule.say, {npcHandler = npcHandler, text = 'I can teach you {Attack spells}, {Healing spells} and {Support spells}.'})