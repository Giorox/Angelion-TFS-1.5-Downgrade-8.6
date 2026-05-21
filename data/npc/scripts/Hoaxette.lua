local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local jesterDoll = {
    {id=9694, count=1},  -- The Head of a Jester Doll
    {id=9695, count=1},  -- The Torso of a Jester Doll
    {id=9698, count=1},  -- Part of a Jester Doll (Left Leg)
    {id=9699, count=1},  -- Part of a Jester Doll (Right Leg)
    {id=9696, count=1},  -- Part of a Jester Doll (Left Arm)
    {id=9697, count=1}  -- Parte of a Jester Doll (Right Arm)
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)	

	if msgcontains(msg, 'jester') then
		npcHandler:say('Oh! <giggles> Have you found all six parts of a jester doll and would like me to assemble them?', cid)
		npcHandler.topic[cid] = 1	
		
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
            for i = 1, #jesterDoll do			
                if player:getItemCount(jesterDoll[i].id) < tonumber(jesterDoll[i].count) then
			    	npcHandler:say('Are you trying to make a fool out of me? You don\'t have all six body parts!', cid)
			    	npcHandler.topic[cid] = 0
			    	return true
			    end
            end
            for i =1, #jesterDoll do	
                player:removeItem(jesterDoll[i].id, tonumber(jesterDoll[i].count))
            end
			npcHandler:say({'Goodie! Here you are! <giggles>'}, cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            player:addItem(9693, 1)  -- Jester Doll
			npcHandler.topic[cid] = 0
		end	
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] ~= 0 then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Well, admittedly, owning parts of a doll can be just as fun. Hehe!', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'friend'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m here to enrich your life and to {sell} little trinkets of fun and joy. Just ask about my {goods} if you like to learn more.'})
keywordHandler:addAliasKeyword({'job'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell special spellwands, pillows and presents that have ... funny effects. Where would be the fun if I told everything you about it? Ask me for a {trade}!'})
keywordHandler:addAliasKeyword({'goods'})
keywordHandler:addAliasKeyword({'offers'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m the lovely, inimitable, and hilarious Hoaxette. I\'ll stay here for the whole month before I leave this country again.'})
keywordHandler:addKeyword({'fun'}, StdModule.say, {npcHandler = npcHandler, text = 'If it were up to me, the whole year would be prank time!'})
keywordHandler:addKeyword({'prank'}, StdModule.say, {npcHandler = npcHandler, text = 'A prank in the morning and the day won\'t be boring <giggles>. I offer funny items for this purpose. Let me know if you are interested in my offers.'})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'d love to play a prank on the king if he showed up here. <giggles>'})
keywordHandler:addKeyword({'joke'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m not specialised in telling jokes - I\'m offering ITEMS that make people laugh. I can tell you something about my offers if you are interested.'})

npcHandler:setMessage(MESSAGE_GREET, 'Hiddeliho my friend |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Have fun with all my ... funny stuff.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'See you, |PLAYERNAME|! Have fun playing pranks on your friends!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Hey! Fools have feelings too.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
