CityRaidAreas = {  -- Define standard areas for raids in cities
    Svargrond = {
        topLeftPos = {x="32197", y="31119", z="7"},
        bottomRightPos = {x="32278", y="31176", z="7"}
    },
    Yalahar = {
        topLeftPos = {x="32757", y="31164", z="7"},
        bottomRightPos = {x="32846", y="31246", z="7"}
    },
    Carlin = {
        topLeftPos = {x="32307", y="31764", z="7"},
        bottomRightPos = {x="32377", y="31818", z="7"}
    },
    AbDendriel = {
        topLeftPos = {x="32640", y="31648", z="7"},
        bottomRightPos = {x="32701", y="31701", z="7"}
    },
    Kazordoon = {
        topLeftPos = {x="32599", y="31875", z="9"},
        bottomRightPos = {x="32649", y="31939", z="9"}
    },
    Edron = {
        topLeftPos = {x="33173", y="31786", z="7"},
        bottomRightPos = {x="33234", y="31871", z="7"}
    },
    Thais = {
        topLeftPos = {x="32325", y="32184", z="7"},
        bottomRightPos = {x="32432", y="32270", z="7"}
    },
    Venore = {
        topLeftPos = {x="32889", y="32031", z="6"},
        bottomRightPos = {x="32997", y="32109", z="6"}
    },
    Darashia = {
        topLeftPos = {x="33197", y="32401", z="7"},
        bottomRightPos = {x="33268", y="32476", z="7"}
    },
    LibertyBay = {
        topLeftPos = {x="32262", y="32774", z="7"},
        bottomRightPos = {x="32346", y="32855", z="7"}
    },
    PortHope = {
        topLeftPos = {x="32570", y="32740", z="7"},
        bottomRightPos = {x="32685", y="32799", z="7"}
    },
    Ankrahmun = {
        topLeftPos = {x="33098", y="32785", z="7"},
        bottomRightPos = {x="33214", y="32865", z="7"}
    },
}

DryadRaidConfig = {
    Edron = {
        message = "Dryads have returned to protect the forest north of Edron.",
        topLeftPos = {x="33156", y="31683", z="7"},
        bottomRightPos = {x="33208", y="31726", z="7"}
    },
    PortHope = {
        message = "Dryads have returned to protect the jungle of Tiquanda.",
        topLeftPos = {x="32733", y="32691", z="7"},
        bottomRightPos = {x="32792", y="32752", z="7"}
    },
    Carlin = {
        message = "Dryads have returned to protect the northern forests near Ab'Dendriel.",
        topLeftPos = {x="32418", y="31693", z="7"},
        bottomRightPos = {x="32469", y="31742", z="7"}
    }
}

SeasonalEvents = {
    -- Thais Primitive Raid during Tibia's Anniversary month
    ThaisPrimitiveRaid = {
        period = {
            startMonth = 1,  -- January
            startDay = 15,
            endMonth = 2,  -- February
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
                    topLeftPos = CityRaidAreas.Thais.topLeftPos,
                    bottomRightPos = CityRaidAreas.Thais.bottomRightPos,
                    delay = 1000,
                    message = "Primitives are attacking Thais!"
                },
                {
                    monsters = {
                        {name="Primitive", amount="80"},
                        {name="Hacker", amount="80"},
                        {name="Tibia Bug", amount="80"}
                    },
                    topLeftPos = CityRaidAreas.Thais.topLeftPos,
                    bottomRightPos = CityRaidAreas.Thais.bottomRightPos,
                    delay = 120 * 1000,
                    message = "Primitives are everywhere in Thais trying a take over!"
                },
                {
                    monsters = {
                        {name="Primitive", amount="110"},
                        {name="Hacker", amount="110"},
                        {name="Tibia Bug", amount="110"}
                    },
                    topLeftPos = CityRaidAreas.Thais.topLeftPos,
                    bottomRightPos = CityRaidAreas.Thais.bottomRightPos,
                    delay = 240 * 1000,
                    message = "Stop the primitives in Thais!"
                }
            }
        }
    },
    -- Spawn Stan, NPC who sells costume bags, in Venore
    MasqueradeDay = {
        period = {
            startMonth = 2,  -- February
            startDay = 1,
            endMonth = 2,  -- February
            endDay = 28
        },
        type = "npc",
        content = {
            npc = "Stan",
            pos = {
                {x="32950", y="32106", z="6"} -- Venore (+1)
            }
        }
    },
    -- Spawn Valentina, NPC who sells Valentine's Day items, in Greenshore
    ValentinesDay = {
        period = {
            startMonth = 2,  -- February
            startDay = 14,
            endMonth = 2,  -- February
            endDay = 14
        },
        type = "npc",
        content = {
            npc = "Valentina",
            pos = {
                {x="32271", y="32052", z="7"} -- Greenshore (0)
            }
        }
    },
    -- The Ruthless Herald raid during April Fools in PoH
    PoHAprilFoolsRaid = {
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
    -- Spawn Hoaxette, NPC who trades pieces of Jester Dolls, in Thais
    AprilFoolsDay = {
        period = {
            startMonth = 4,  -- April
            startDay = 1,
            endMonth = 4,  -- April
            endDay = 30
        },
        type = "npc",
        content = {
            npc = "Hoaxette",
            pos = {
                {x="32369", y="32214", z="7"} -- Thais (0)
            }
        }
    },
    UndeadJesterRaid = {
        period = {
            startMonth = 4,  -- April
            startDay = 1,
            endMonth = 4,  -- April
            endDay = 15
        },
        type = "globalraid",  -- Global Raids are raids that can happen in different cities, at random
        content = {
            areaSpawns = {  -- Where the area spawns will happen and when and what message will be sent
                {
                    monsters = {
                        {name="Undead Jester", amount="300"}
                    },
                    delay = 1000,
                    message = "Oh no! |CITY_NAME| beware! All bad entertainers are returning from their graves to haunt their audience once again!"
                }
            }
        }
    },
    HalloweenHareRaid = {
        period = {
            startMonth = 10,  -- October
            startDay = 31,
            endMonth = 10,  -- October
            endDay = 31
        },
        type = "raid",
        content = {
            announcements = {  -- Only announcements, no spawns here
                {
                    message = "Beware, beware the halloween hare.",
                    delay = 1000
                }
            },
            singleSpawns = {  -- Where the singles spawns will happen and when and what message will be sent (message is optional)
                {    
                    monster = "The Halloween Hare",
                    pos = {x="32615", y="31983", z="7"},  -- South of Dwarven Bridge
                    delay = 1000
                },
                {    
                    monster = "The Halloween Hare",
                    pos = {x="32097", y="32202", z="7"},  -- Rookgaard center
                    delay = 1000
                }
            }
        }
    },
    MutatedPumpkinRaid = {
        period = {
            startMonth = 10,  -- October
            startDay = 31,
            endMonth = 11,  -- November
            endDay = 3
        },
        type = "raid",
        content = {
            singleSpawns = {  -- Where the singles spawns will happen and when and what message will be sent (message is optional)
                {    
                    monster = "The Mutated Pumpkin",
                    pos = {x="33170", y="32433", z="7"},
                    delay = 1000,
                    message = "Oh noes! It's a mutated pumpkin!"
                }
            }
        }
    },
    Christmas = {
        period = {
            startMonth = 12,  -- December
            startDay = 12,
            endMonth = 12,  -- December
            endDay = 31
        },
        type = "npc",
        content = {
            npc = "Santa Claus",
            pos = {
                {x="32655", y="31664", z="8"},  -- Ab'Dendriel (-1)
                {x="33067", y="32880", z="6"},  -- Ankrahmun (+1)
                {x="32313", y="31839", z="8"},  -- Carlin (-1)
                {x="33232", y="32486", z="7"},  -- Darashia (0)
                {x="33191", y="31810", z="7"},  -- Edron (0)
                {x="33000", y="31538", z="10"},  -- Farmine (-3, fully restored city)
                {x="32642", y="31894", z="9"},  -- Kazordoon (-2)
                {x="32322", y="32834", z="7"},  -- Liberty Bay (0)
                {x="32623", y="32751", z="7"},  -- Port Hope (0)
                {x="32240", y="31139", z="7"},  -- Svargrond (0)
                {x="32362", y="32207", z="7"},  -- Thais (0)
                {x="32915", y="32071", z="9"},  -- Venore (-2)
                {x="32811", y="31245", z="7"}  -- Yalahar (0)
            }
        }
    },
    GrynchClanGoblinRaid = {
        period = {
            startMonth = 12,  -- December
            startDay = 20,
            endMonth = 12,  -- December
            endDay = 28
        },
        type = "globalraid",  -- Global Raids are raids that can happen in different cities, at random
        content = {
            areaSpawns = {  -- Where the area spawns will happen and when and what message will be sent
                {
                    monsters = {
                        {name="Grynch Clan Goblin", amount="100"}
                    },
                    delay = 1000,
                    message = "Goblins of the infamous Grynch Clan are invading |CITY_NAME| to steal all presents, beware!"
                },
                {
                    monsters = {
                        {name="Grynch Clan Goblin", amount="100"}
                    },
                    delay = 120 * 1000,
                    message = "The Goblins sometimes have stolen presents with them! Confiscate them!"
                },
                {
                    monsters = {
                        {name="Grynch Clan Goblin", amount="100"}
                    },
                    delay = 180 * 1000,
                    message = "Return the stolen presents to Ruprecht on Vega at Santa's home for a reward."
                }
            }
        }
    },
    FlowerMonth = {
        period = {
            startMonth = 6,  -- June
            startDay = 1,
            endMonth = 6,  -- June
            endDay = 30
        },
        type = "npc",
        content = {
            npc = "Rosemarie",
            pos = {
                {x="32534", y="32827", z="7"}  -- Port Hope (0)
            }
        }
    },
    DryadRaid = {
        period = {
            startMonth = 6,  -- June
            startDay = 1,
            endMonth = 6,  -- June
            endDay = 30
        },
        type = "globalraid",  -- Global Raids are raids that can happen in different cities, at random
        content = {
            positionRef = DryadRaidConfig,
            areaSpawns = {  -- Where the area spawns will happen and when and what message will be sent
                {
                    monsters = {
                        {name="Dryad", amount="100"}
                    },
                    delay = 1000
                },
                {
                    monsters = {
                        {name="Dryad", amount="100"}
                    },
                    delay = 15 * 60 * 1000
                },
                {
                    monsters = {
                        {name="Dryad", amount="100"}
                    },
                    delay = 30 * 60 * 1000
                },
                {
                    monsters = {
                        {name="Dryad", amount="100"}
                    },
                    delay = 45 * 60 * 1000
                },
                {
                    monsters = {
                        {name="Dryad", amount="100"}
                    },
                    delay = 60 * 60 * 1000
                }
            }
        }
    },
    HotCuisineQuest = {
        period = {
            startMonth = 8,  -- August
            startDay = 1,
            endMonth = 8,  -- August
            endDay = 31
        },
        type = "npc",
        content = {
            npc = "Jean Pierre",
            pos = {
                {x="33072", y="32528", z="6"}  -- Jean Pierre's House in Ashta'Daramai (+1)
            }
        }
    },
    NewYearsEve = {
        period = {
            startMonth = 12,  -- December
            startDay = 27,
            endMonth = 1,  -- January
            endDay = 3
        },
        type = "npc",
        content = {
            npc = "Ned Nobel",
            pos = {
                {x="32651", y="31700", z="7"},  -- Ab'Dendriel (0)
                {x="32342", y="31795", z="7"},  -- Carlin (0)
                {x="33191", y="31791", z="7"},  -- Edron (0)
                {x="32610", y="31922", z="8"},  -- Kazordoon (-1)
                {x="32321", y="32836", z="7"},  -- Liberty Bay (0)
                {x="32329", y="32216", z="7"}  -- Thais (0)
            }
        }
    }
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
        broadcastMessage(eventInfo.message, MESSAGE_EVENT_ADVANCE)
    end

    return true
end

local function executeAreaSpawn(eventInfo)
    for i = 1, #eventInfo.monsters do
        for n = 1, eventInfo.monsters[i].amount do
            local node = {
                monster = eventInfo.monsters[i].name,
                pos = {x=math.random(eventInfo.topLeftPos.x, eventInfo.bottomRightPos.x), y=math.random(eventInfo.topLeftPos.y, eventInfo.bottomRightPos.y), z=math.random(eventInfo.topLeftPos.z, eventInfo.bottomRightPos.z)},
                message = nil
            }
            executeSingleSpawn(node)
        end
    end

    broadcastMessage(eventInfo.message, MESSAGE_EVENT_ADVANCE)

    return true
end

local function executeRaid(raidContent)
    -- Schedule all announcements
    if raidContent.announcements ~= nil then
        for _, announcement in pairs(raidContent.announcements) do
            addEvent(broadcastMessage, announcement.delay, announcement.message, MESSAGE_EVENT_ADVANCE)
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

local function spawnNPC(raidContent)
    for _, position in pairs(raidContent.pos) do
        local npc = Game.createNpc(raidContent.npc, position)
	    if npc then
	    	npc:setMasterPos(position)
	    end
    end
end

local function configGlobalRaid(raidContent)
    -- Configure positional reference for randomized raid
    local positionRef = CityRaidAreas
    if raidContent.positionRef ~= nil then
        positionRef = raidContent.positionRef
    end

    -- Build list of valid keys from positional reference config
    local keys = {}
    for k, _ in pairs(positionRef) do
        table.insert(keys, k)
    end

    -- Choose an entry from the positional reference table
    local idx = keys[math.random(#keys)]
    local targetArea = positionRef[idx]

    -- Some modification to town text
    if idx == "AbDendriel" then
        idx = "Ab'Dendriel"
    elseif idx == "PortHope" then
        idx = "Port Hope"
    elseif idx == "LibertyBay" then
        idx = "Liberty Bay"
    end

    -- Schedule area spawns
    for _, area in pairs(raidContent.areaSpawns) do
        area.topLeftPos = targetArea.topLeftPos
        area.bottomRightPos = targetArea.bottomRightPos

        if area.message == nil then
            area.message = targetArea.message
        end
    
        area.message = string.gsub(area.message, "|CITY_NAME|", idx)

        addEvent(executeAreaSpawn, area.delay, area)
    end
end

function onStartup()
    -- Get current day of the week and day/month of the year in epoch seconds
    local weekDay = os.date("%A")
    local currDate = os.time()

    -- Check day of the week and spawn Rashid
    local rashidPos = RashidConfig[weekDay]
	local rashid = Game.createNpc("Rashid", rashidPos)
    print("Seasonal Event: Today is " .. weekDay .. " -- Rashid is in (" .. rashidPos.x .. ", " .. rashidPos.y .. ", " .. rashidPos.z .. ")")
	if rashid then
		rashid:setMasterPos(rashidPos)
	end

    -- For events that occur simultaneously, we want to stagger them along noon (12PM) everyday they happen
    local simulEventCount = 0
    local secsToNoon = (os.time{year=os.date("%Y"), month=os.date("%m"), day=os.date("%d"), hour=12} - currDate)

    -- Check seasonal events
    for name, param in pairs(SeasonalEvents) do
        -- Check that today's date falls within the range of this event
        if (os.time{year=os.date("%Y"), month=param.period.startMonth, day=param.period.startDay} <= currDate) and (currDate <= os.time{year=os.date("%Y"), month=param.period.endMonth, day=param.period.endDay}) then
            -- Calculate how large (in +/- 1 hour increments) the interval around noon the event should be scheduled to hgappen
            simulEventCount = simulEventCount + 1
            local deltaSecs = simulEventCount * 60 * 60

            -- Schedule event -- All events are scheduled for the noon (12PM) +/- N hours interval (where N is the amount of simultaneous events)
            print("Seasonal Event: " .. name .. " in effect!")
            if param.type == "raid" then
                addEvent(executeRaid, math.random(secsToNoon - deltaSecs, secsToNoon + deltaSecs) * 1000, param.content)
            elseif param.type == "npc" then
                spawnNPC(param.content)
            elseif param.type == "globalraid" then
                addEvent(configGlobalRaid, math.random(secsToNoon - deltaSecs, secsToNoon + deltaSecs) * 1000, param.content)
            end
        end
    end
end