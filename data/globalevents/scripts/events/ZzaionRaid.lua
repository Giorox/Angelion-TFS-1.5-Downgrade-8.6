--Zzaion Raid System
--Script by Giorox

-- ID of the gate item
local gateID = 9485

-- Position of Zzaion gate pieces
local gatePosTable = {
	{x=33303,y=31491,z=7,stackpos=1},
	{x=33304,y=31491,z=7,stackpos=3},
	{x=33305,y=31491,z=7,stackpos=2},
	{x=33306,y=31491,z=7,stackpos=2},
	{x=33307,y=31491,z=7,stackpos=3},
	{x=33308,y=31491,z=7,stackpos=1},
	{x=33309,y=31491,z=7,stackpos=1},
	{x=33303,y=31498,z=7,stackpos=2},
	{x=33304,y=31498,z=7,stackpos=4},
	{x=33305,y=31498,z=7,stackpos=4},
	{x=33306,y=31498,z=7,stackpos=5},
	{x=33307,y=31498,z=7,stackpos=3},
	{x=33308,y=31498,z=7,stackpos=1},
	{x=33309,y=31498,z=7,stackpos=1},
	{x=33310,y=31498,z=7,stackpos=1},
}

local function checkGates() --Return true if gate is closed and false if the gate is open
	for i = 1,15 do
		local gate = getThingfromPos(gatePosTable[1])
        if gate.itemid ~= gateID then
            return false
        end
    end
	return true
end

local function removeGate() -- Function removes all gates
    for _, value in pairs(gatePosTable) do
        doRemoveItem(getThingfromPos(value).uid, 1)
    end	
	return true
end

local function executeAreaSpawn(monsters, eventInfo)  
    for i = 1, #monsters do
        for n = 1, monsters[i].amount do
            local spawnedSuccessfully = false
            local attempts = 0
            while attempts < 100 and spawnedSuccessfully == false do
                local monster = Game.createMonster(monsters[i].name, Position(math.random(eventInfo.topLeftPos.x, eventInfo.bottomRightPos.x), math.random(eventInfo.topLeftPos.y, eventInfo.bottomRightPos.y), math.random(eventInfo.topLeftPos.z, eventInfo.bottomRightPos.z)))
                if monster and monster:isCreature() then
                    spawnedSuccessfully = true
                end
                attempts = attempts + 1
            end
        end
    end

    Game.broadcastMessage(eventInfo.message, MESSAGE_EVENT_ADVANCE)
    return true
end

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
end

local function zzaionRaid()
    -- What monsters and how many will be spawned at each area spawn
    monsters = {
        {name="Orc", amount="110"},
        {name="Orc Spearman", amount="80"},
        {name="Orc Warrior", amount="80"},
        {name="Orc Shaman", amount="50"},
        {name="Orc Leader", amount="35"},
        {name="Orc Berserker", amount="15"},
        {name="Orc Marauder", amount="20"},
        {name="Orc Warlord", amount="10"}
    }

    -- Where the area spawns will happen and when and what message will be sent
    areaSpawns = {
        {
            topLeftPos = {x="33277", y="31468", z="7"},
            bottomRightPos = {x="33334", y="31482", z="7"},
            delay = 1000,
            message = "A massive orc force is gathering at the gates of Zzaion."
        },
        {
            topLeftPos = {x="33283", y="31476", z="7"},
            bottomRightPos = {x="33331", y="31489", z="7"},
            delay = 180000,
            message = "Orc reinforcements have arrived at the gates of Zzaion! The gates are under heavy attack!"
        },
        {
            topLeftPos = {x="33283", y="31476", z="7"},
            bottomRightPos = {x="33331", y="31489", z="7"},
            delay = 600000,
            message = "More orc reinforcements have arrived at the gates of Zzaion! The gates are under heavy attack!"
        },
        {
            topLeftPos = {x="33284", y="31503", z="7"},
            bottomRightPos = {x="33356", y="31614", z="5"},
            delay = 1200000,
            message = "The gates to Zzaion have been breached! Orcs are invading the city!"
        },
        {
            topLeftPos = {x="33284", y="31503", z="7"},
            bottomRightPos = {x="33356", y="31614", z="5"},
            delay = 1800000,
            message = "More orcs have arrived in Zzaion! The city is under attack! Strong lizard leaders have come to defend the city."
        }
    }

    -- Where the singles spawns will happen and when
    singleSpawns = {
        {
            pos = {x="33307", y="31540", z="7"},
            monster = "Cublarc the Plunderer",
            delay = 1800000
        },
        {
            pos = {x="33348", y="31610", z="1"},
            monster = "Zulazza the Corruptor",
            delay = 1800000
        },
        {
            pos = {x="33345", y="31608", z="4"},
            monster = "Chizzoron the Distorter",
            delay = 1800000
        }
    }

    -- Execute all area spawn events
    for _, area in pairs(areaSpawns) do
        addEvent(executeAreaSpawn, area.delay, monsters, area)
    end

    -- Execute all single spawn events
    for _, spawn in pairs(singleSpawns) do
        addEvent(executeSingleSpawn, spawn.delay, spawn)
    end
end

function onThink(interval)
	if(checkGates() == true) then --If gates are closed, run the sequence to open them
        zzaionRaid()
		addEvent(removeGate, 1800000) -- This time makes sure the gate only falls AFTER the last raid of the initial attack
	else --If gates are open, just warn, gates will be reset the following day
		print("[ZzaionRaid] Gates already open!")
	end
	return true
end
