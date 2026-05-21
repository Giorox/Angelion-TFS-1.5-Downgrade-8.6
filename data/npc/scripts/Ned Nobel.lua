 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end


-- Basic
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Ned. Ned Nobel. Maybe you knew my {father}, his name was Alfred!'})
keywordHandler:addKeyword({'alfred'}, StdModule.say, {npcHandler = npcHandler, text = 'He laid the foundation for my {invention}.'})
keywordHandler:addAliasKeyword({'father'})
keywordHandler:addKeyword({'invention'}, StdModule.say, {npcHandler = npcHandler, text = 'I did plenty of testing and I can proudly say that they are much safer and better now. Nevertheless I can\'t tell you the formula. It\'s a {secret}.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = ' I\'m an inventor and a salesman. You know, without money no inventions.'})
keywordHandler:addKeyword({'secret'}, StdModule.say, {npcHandler = npcHandler, text = 'No, I will not tell you and now stop bothering me I have to work.', reset = true, ungreet = true})

npcHandler:addModule(FocusModule:new())
