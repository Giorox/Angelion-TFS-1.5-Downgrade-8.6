local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(60, 2000, -10)

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)

	if msgcontains(msg, 'cookie') then
		if player:getStorageValue(Storage.WhatAFoolishQuest.Questline) == 31
				and player:getStorageValue(Storage.WhatAFoolishQuest.CookieDelivery.Wyda) ~= 1 then
			npcHandler:say('You brought me a cookie?', cid)
			npcHandler.topic[cid] = 1
        else
            npcHandler:say('I bake cookies now and then in my spare time.', cid)
                npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
		npcHandler:say({
			"A quest? Well, if you\'re so keen on doing me a favour... Why don\'t you try to find a {blood herb}?",
			"To be honest, I\'m drowning in blood herbs by now."
		}, cid)
		npcHandler.topic[cid] = 0
    elseif msgcontains(msg, 'become a witch') and player:getSex() == PLAYERSEX_MALE then
        npcHandler:say('You\'re a MAN!', cid)
        npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'bloodherb') or msgcontains(msg, 'blood herb') then
		if player:getStorageValue(Storage.BloodHerbQuest) == 1  then
			npcHandler:say('Arrr... here we go again.... do you have a #$*§# blood herb for me?', cid)
			npcHandler.topic[cid] = 2
		else
			npcHandler:say({
				"The blood herb is very rare. This plant would be very useful for me, but I don't know any accessible places to find it.",
				"To be honest, I'm drowning in blood herbs by now. But if it helps you, well yes.. I guess I could use another blood herb..."
			}, cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if not player:removeItem(8111, 1) then
				npcHandler:say('You have no cookie that I\'d like.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.WhatAFoolishQuest.CookieDelivery.Wyda, 1)
			player:addCondition(condition)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement('Allow Cookies?')
			end

			Npc():getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say('Well, it\'s a welcome change from all that gingerbread ... AHHH HOW DARE YOU??? FEEL MY WRATH!', cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		elseif npcHandler.topic[cid] == 2 then
			if player:removeItem(2798, 1) then
				player:setStorageValue(Storage.BloodHerbQuest, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				player:addItem(2324, 1) -- witchesbroom
				npcHandler:say('Thank you -SOOO- much! No, I really mean it! Really! Here, let me give you a reward...', cid)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say('No, you don\'t have any...', cid)
				npcHandler.topic[cid] = 0
			end
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 or npcHandler.topic[cid] == 2 then
			npcHandler:say('I see.', cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am a {witch}. Didn't you notice?"})
keywordHandler:addKeyword({'my', 'name', 'is'}, StdModule.say, {npcHandler = npcHandler, text = "Nice to meet you."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "My name is Wyda, and what's yours?"})
keywordHandler:addKeyword({'sister'}, StdModule.say, {npcHandler = npcHandler, text = "Some sisters of mine are having a meeting nearby. Don't disturb them, or they will get angry and attack you."})
keywordHandler:addAliasKeyword({'witches'})
keywordHandler:addKeyword({'witch'}, StdModule.say, {npcHandler = npcHandler, text = "Aye, I'm a witch."})
keywordHandler:addKeyword({'mother'}, StdModule.say, {npcHandler = npcHandler, text = "Of course my mother was also a witch!"})
keywordHandler:addKeyword({'i', 'live', 'in'}, StdModule.say, {npcHandler = npcHandler, text = "That's nice."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = "I've heard {stories} about that city. It's nowhere near here, that's all I can tell you about it."})
keywordHandler:addKeyword({'stories'}, StdModule.say, {npcHandler = npcHandler, text = "Thais is an overcrowded place inhabited by brutal murderers. At least, that's what I've been told."})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, text = "Isn't that the name of the {little bearded fellows'} town?"})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "Carlin is a beautiful town, but far from here. Do you live there?"})
keywordHandler:addKeyword({'plains', 'of', 'havoc'}, StdModule.say, {npcHandler = npcHandler, text = "Many tales exist about the so-called Plains of Havoc. It seems to be a dangerous place."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "Tibia is the name of our continent."})
keywordHandler:addKeyword({'hunter'}, StdModule.say, {npcHandler = npcHandler, text = "To the east, there is a little settlement of hunters. They are cruel humans who attack everything they see."})
keywordHandler:addKeyword({'giant', 'spider'}, StdModule.say, {npcHandler = npcHandler, text = "Yes, there is such a thing in the east, on a small island. It's very powerful."})
keywordHandler:addKeyword({'beholder'}, StdModule.say, {npcHandler = npcHandler, text = "Beholders? Strange creatures that have mysterious magical abilities."})
keywordHandler:addKeyword({'slime'}, StdModule.say, {npcHandler = npcHandler, text = "There's lots of slime around. It is said that they live from the swamp water."})
keywordHandler:addKeyword({'black', 'knight'}, StdModule.say, {npcHandler = npcHandler, text = "A black knight? Black is the colour of witches, why would a knight wear black?"})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = "Sorcerers have forgotten about the root of all beings: nature."})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins can use bows, but no brains."})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = "Knights succumb to the blindness of rage and the desire for violence and blood."})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = "Druids are mostly fine people. I'm always happy when I meet one. After all, they are often a bit less prejudiced against my profession."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, text = "Haha, that's a stupid name. Who's that?"})
keywordHandler:addAliasKeyword({'ferumbras'})
keywordHandler:addKeyword({'bridge'}, StdModule.say, {npcHandler = npcHandler, text = "There's a bridge to the west, but it's guarded by {dwarfs}."})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, text = "The little bearded fellows have a town somewhere to the north-west"})
keywordHandler:addAliasKeyword({'dwarves'})
keywordHandler:addAliasKeyword({'little', 'fellows'})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = "Eloise is the queen of {Carlin}. I don't care much about royals as long as they don't try to tax me."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "There are too many royals on this continent if you ask me..."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "I think it is the fourth year after Queen Eloise's crowning, but I cannot tell you date or time."})
keywordHandler:addKeyword({'evil'}, StdModule.say, {npcHandler = npcHandler, text = "Evilness doesn't scare me"})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "I can only help with knowledge. About what do you want me to tell you something?"})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, text = "I'm currently not selling anything."})
keywordHandler:addAliasKeyword({'offer'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = "There's nothing I need right now, thanks."})
keywordHandler:addKeyword({'key'}, StdModule.say, {npcHandler = npcHandler, text = "I keep my keys where they belong - in my pocket."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = "Many creatures live in, around and beneath the {swamp}. Be careful!"})
keywordHandler:addAliasKeyword({'creature'})
keywordHandler:addKeyword({'swamp'}, StdModule.say, {npcHandler = npcHandler, text = "Be careful of the swamp water, it's poisonous!"})
keywordHandler:addKeyword({'herbs'}, StdModule.say, {npcHandler = npcHandler, text = "The {swamp} is home to a wide variety of herbs, but the most famous is the {blood herb}."})
keywordHandler:addKeyword({'nature'}, StdModule.say, {npcHandler = npcHandler, text = "There are many swamp {plant}s, {mushroom}s and {herb}s around here."})
keywordHandler:addKeyword({'plant'}, StdModule.say, {npcHandler = npcHandler, text = "There are many kind of swamp plants, some can be used for {potion}s, some not."})
keywordHandler:addKeyword({'potion'}, StdModule.say, {npcHandler = npcHandler, text = "The recipe of the potions is one of the witches' secrets!"})
keywordHandler:addAliasKeyword({'secret'})
keywordHandler:addAliasKeyword({'recipe'})
keywordHandler:addKeyword({'mushroom'}, StdModule.say, {npcHandler = npcHandler, text = "Mushrooms taste good and are useful for {potion}s."})
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = "I don't have any healing potions available right now."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = "I believe that nature itself is God."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "The magic of the witches is one of our secrets!"})
keywordHandler:addAliasKeyword({'spell'})
keywordHandler:addKeyword({'granny', 'weatherwax'}, StdModule.say, {npcHandler = npcHandler, text = "I think I've heard that name before..."})
keywordHandler:addAliasKeyword({'nanny', 'ogg'})
keywordHandler:addKeyword({'voodoo'}, StdModule.say, {npcHandler = npcHandler, text = "I don't practice such nonsense, that's just a rumour."})
keywordHandler:addKeyword({'coffin'}, StdModule.say, {npcHandler = npcHandler, text = "That's none of your business."})
keywordHandler:addKeyword({'gold'}, StdModule.say, {npcHandler = npcHandler, text = "Money means nothing to me."})
keywordHandler:addAliasKeyword({'platinum'})
keywordHandler:addKeyword({'orange'}, StdModule.say, {npcHandler = npcHandler, text = "I love exotic fruits. I import oranges from the south sometimes, but that's very expensive."})
keywordHandler:addKeyword({'broom'}, StdModule.say, {npcHandler = npcHandler, text = "What about it?"})
keywordHandler:addKeyword({'fly', 'broom'}, StdModule.say, {npcHandler = npcHandler, text = "Haha, no... where did you get that idea? I use it to sweep my {platform}."})
keywordHandler:addKeyword({'platform'}, StdModule.say, {npcHandler = npcHandler, text = "This platform and house were built by my {mother}, long ago."})
keywordHandler:addKeyword({'crystal', 'ball'}, StdModule.say, {npcHandler = npcHandler, text = "It's a magical item that only witches can use."})
keywordHandler:addKeyword({'earthquake'}, StdModule.say, {npcHandler = npcHandler, text = "The earth in this region shakes now and then. Foolish people think that this is because the {god}s are angry."})
keywordHandler:addKeyword({'man'}, StdModule.say, {npcHandler = npcHandler, text = "There are only female witches."})
keywordHandler:addKeyword({'wand'}, StdModule.say, {npcHandler = npcHandler, text = "I use a wooden wand. Why are you asking?"})
keywordHandler:addKeyword({'power', 'wand'}, StdModule.say, {npcHandler = npcHandler, text = "The power of the wand can only be used by witches."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
