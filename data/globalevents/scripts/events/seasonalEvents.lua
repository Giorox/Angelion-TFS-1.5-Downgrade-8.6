SeasonalEvents = {
    -- Thais Primitive Raid during Tibia's Anniversary month
    ThaisPrimitiveRaid = {
        schedule = "Daily",
        period = {
            startMonth = 1,  -- January
            startDay = 15,
            endMonth = 6,  -- February
            endDay = 15
        },
        type = "raid",
        content = {
            areaSpawns = {  -- Where the area spawns will happen and when and what message will be sent
                {
                    monsters = {
                        {name="Primitive", amount="40"},
                        {name="Hacker", amount="40"},
                        {name="Tibia Bug", amount="40"}
                    },
                    topLeftPos = {x="32325", y="32184", z="7"},
                    bottomRightPos = {x="32432", y="32270", z="7"},
                    delay = 1000,
                    message = "Primitives are attacking Thais!"
                },
                {
                    monsters = {
                        {name="Primitive", amount="80"},
                        {name="Hacker", amount="80"},
                        {name="Tibia Bug", amount="80"}
                    },
                    topLeftPos = {x="32325", y="32184", z="7"},
                    bottomRightPos = {x="32432", y="32270", z="7"},
                    delay = 120 * 1000,
                    message = "Primitives are everywhere in Thais trying a take over!"
                },
                {
                    monsters = {
                        {name="Primitive", amount="110"},
                        {name="Hacker", amount="110"},
                        {name="Tibia Bug", amount="110"}
                    },
                    topLeftPos = {x = "32325", y = "32184", z = "7"},
                    bottomRightPos = {x="32432", y="32270", z="7"},
                    delay = 240 * 1000,
                    message = "Stop the primitives in Thais!"
                }
            }
        }
    },
    -- The Ruthless Herald raid during April Fools in PoH
    PoHAprilFoolsRaid = {
        schedule = "Daily",
        period = {
            startMonth = 4,  -- April
            startDay = 1,
            endMonth = 4,  -- April
            endDay = 30
        },
        type = "raid",
        content = {
            announcements = {  -- Only announcements, no spawns here
                {
                    message = "You feel the earth shaking!",
                    delay = 1000
                },
                {
                    message = "The end is near! The Ruthless Seven are rising!",
                    delay = 120 * 1000
                },
                {
                    message = "The Ruthless Seven have risen to hold their secret council. They will gather somewhere in the Plains of Havoc to debate Tibias destiny and doom. Don't come to close, for if you do, you will face your own destiny!",
                    delay = 180 * 1000
                }
            },
            singleSpawns = {  -- Where the singles spawns will happen and when and what message will be sent (message is optional)
                {    
                    monster = "The Ruthless Herald",
                    pos = {x="32801", y="32294", z="7"},
                    delay = 240 * 1000,
                    message = "The herald of the Ruthless Seven is preparing their arrival close to the spiders rock. Behold mortals. It is the end of times!"
                }
            }
        }
    },
}

RashidConfig = {
    Monday = {x="32210", y="31158", z="7"},
    Tuesday = {x="32302", y="32833", z="7"},
    Wednesday = {x="32579", y="32753", z="7"},
    Thursday = {x="33070", y="32881", z="6"},
    Friday = {x="33233", y="32483", z="7"},
    Saturday = {x="33170", y="31810", z="6"},
    Sunday = {x="32329", y="31781", z="6"}
}

local function executeSingleSpawn(eventInfo)
    local spawnedSuccessfully = false
    local attempts = 0
    while attempts < 10 and spawnedSuccessfully == false do
        local monster = Game.createMonster(eventInfo.monster, Position(eventInfo.pos.x, eventInfo.pos.y, eventInfo.pos.z))
        if monster and monster:isCreature() then
            spawnedSuccessfully = true
        end
        attempts = attempts + 1
    end

    if eventInfo.message ~= nil then
        Game.broadcastMessage(eventInfo.message, MESSAGE_EVENT_ADVANCE)
    end

    return true
end

local function executeAreaSpawn(eventInfo)
    for i = 1, #eventInfo.monsters do
        for n = 1, eventInfo.monsters[i].amount do
            node = {
                monster = eventInfo.monsters[i].name,
                pos = {x=math.random(eventInfo.topLeftPos.x, eventInfo.bottomRightPos.x), y=math.random(eventInfo.topLeftPos.y, eventInfo.bottomRightPos.y), z=math.random(eventInfo.topLeftPos.z, eventInfo.bottomRightPos.z)},
                message = eventInfo.message
            }
            executeSingleSpawn(node)
        end
    end

    return true
end

local function executeRaid(raidContent)
    -- Schedule all announcements
    if raidContent.announcements ~= nil then
        for _, announcement in pairs(raidContent.announcements) do
            addEvent(Game.broadcastMessage, announcement.delay, announcement.message, MESSAGE_EVENT_ADVANCE)
        end
    end

    -- Schedule all area spawn events
    if raidContent.areaSpawns ~= nil then
        for _, area in pairs(raidContent.areaSpawns) do
            addEvent(executeAreaSpawn, area.delay, area)
        end
    end

    -- Schedule all single spawn events
    if raidContent.singleSpawns ~= nil then
        for _, single in pairs(raidContent.singleSpawns) do
            addEvent(executeSingleSpawn, single.delay, single)
        end
    end
end

function onStartup()
    -- Get current day of the week and day/month of the year in epoch seconds
    weekDay = os.date("%A")
    currDate = os.time()

    -- Check day of the week and spawn Rashid
    local rashidPos = RashidConfig[weekDay]
	local rashid = Game.createNpc("Rashid", rashidPos)
    print("Seasonal Event: Today is " .. weekDay .. " -- Rashid is in (" .. rashidPos.x .. ", " .. rashidPos.y .. ", " .. rashidPos.z .. ")")
	if rashid then
		rashid:setMasterPos(rashidPos)
	end

    -- Check seasonal events
    for name, param in pairs(SeasonalEvents) do
        -- Check that today's date falls within the range of this event
        if (os.time{year=os.date("%Y"), month=param.period.startMonth, day=param.period.startDay} <= currDate) and (currDate <= os.time{year=os.date("%Y"), month=param.period.endMonth, day=param.period.endDay}) then
            print("Seasonal Event: " .. name .. " in effect!")
            if param.type == "raid" then
                addEvent(executeRaid, 60 * 1000, param.content)
            end
        end
    end
end