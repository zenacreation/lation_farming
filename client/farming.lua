
-- Initialize config(s)
local shared = require 'config.shared'
local client = require 'config.client'
local icons  = require 'config.icons'

-- Initialize table to store farm
local farm = {}

-- Initialize variable to store inside mine state
local inside = false

-- Localize export
local farming = exports.lation_farming

-- Mine an ore
--- @param zoneId number
--- @param oreId number
local function mineOre(zoneId, oreId)
    if not zoneId or not oreId then return end

    local zone = shared.farming.zones[zoneId]
    if not zone then return end

    local ore = farm[zoneId] and farm[zoneId][oreId]
    if not ore or not DoesEntityExist(ore.entity) then return end

    local level = farming:GetPlayerData('level')
    if level < zone.level then
        ShowNotification(locale('notify.not-experienced'), 'error')
        return
    end

    local shovel, item = false, nil
    for pick_level, pick_data in pairs(shared.shovels) do
        if pick_level <= level and HasItem(pick_data.item, 1) then
            shovel, item = true, pick_data.item
            break
        end
    end
    if not shovel then
        ShowNotification(locale('notify.missing-shovel'), 'error')
        return
    end

    local metadata = lib.callback.await('lation_farming:getmetadata', false, item)
    local metatype = GetDurabilityType()
    local degrade = shared.shovels[level].degrade
    if not metadata or not metadata[metatype] or metadata[metatype] < degrade then
        ShowNotification(locale('notify.shovel-no-durability'), 'error')
        return
    end

    local hour = GetClockHours()
    local hours = shared.farming.hours
    if hour < hours.min or hour > hours.max then
        ShowNotification(locale('notify.nighttime'), 'error')
        return
    end
---------------------------------[animation logic]----------------------------------------------

local duration = math.random(zone.duration.min, zone.duration.max)
local anim = client.anims.farming
if not anim or not duration then return end

anim.duration = duration

local ped = PlayerPedId()

if anim.scenario then
    -- Use a simple scenario like WORLD_HUMAN_GARDENER_PLANT
    TaskStartScenarioInPlace(ped, anim.scenario, 0, true)
else
    -- Load and play standard animation
    if anim.anim and anim.anim.dict and anim.anim.clip then
        RequestAnimDict(anim.anim.dict)
        while not HasAnimDictLoaded(anim.anim.dict) do Wait(100) end

        TaskPlayAnim(ped, anim.anim.dict, anim.anim.clip, 8.0, -8.0, anim.duration or -1, anim.anim.flag or 49, 0, false, false, false)
    end
end

   --[[ local duration = math.random(zone.duration.min, zone.duration.max)
    local anim = client.anims.farming
    if not anim or not duration then return end
    anim.duration = duration]]

    if ProgressBar(anim) then
        DeleteEntity(ore.entity)
        farm[zoneId][oreId] = { respawn = GetGameTimer() + zone.respawn }
        TriggerServerEvent('lation_farming:minedore', zoneId, oreId)
    end
end 

-- Spawn an ore

--- @param zoneId number
--- @param oreId number
local function spawnOre(zoneId, oreId)
    if not zoneId or not oreId then return end

    local zone = shared.farming.zones[zoneId]
    if not zone then return end

    local ore = zone.farm[oreId]
    if not ore then return end

    local models = zone.models
    local model = models[math.random(#models)]
    lib.requestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local groundFound, groundZ = GetGroundZFor_3dCoord(ore.x, ore.y, ore.z, false)
    local oreZ = groundFound and groundZ or ore.z
    local entity = CreateObject(model, ore.x, ore.y, oreZ, false, false, false)
    print(ore.x, ore.y, ore.z, oreZ, groundFound)
    AddTargetEntity(entity, {
        {
            name = zoneId .. oreId,
            label = locale('target.mine-ore'),
            icon = icons.mine,
            iconColor = icons.mine_color,
            distance = 2,
            canInteract = function()
                return not IsPedInAnyVehicle(cache.ped, true)
            end,
            onSelect = function()
                mineOre(zoneId, oreId)
            end,
            action = function()
                mineOre(zoneId, oreId)
            end
        }
    })

    farm[zoneId][oreId] = { entity = entity, respawn = nil }
end

-- Setup on mine enter
local function enterMine()
    inside = not inside
    for zoneId, zone in pairs(shared.farming.zones) do
        farm[zoneId] = farm[zoneId] or {}
        for oreId, _ in pairs(zone.farm) do
            spawnOre(zoneId, oreId)
        end
    end
end

-- Cleanup on mine exit
local function exitMine()
    inside = not inside
    for zoneId, oreData in pairs(farm) do
        for _, data in pairs(oreData) do
            if data.entity and DoesEntityExist(data.entity) then
                DeleteEntity(data.entity)
            end
        end
        farm[zoneId] = nil
    end
    for _, data in pairs(shared.farming.zones) do
        for _, model in pairs(data.models) do
            SetModelAsNoLongerNeeded(model)
        end
    end
end

-- Ore respawn management thread
CreateThread(function()
    while true do
        if inside then
            for zoneId, oreData in pairs(farm) do
                for oreId, data in pairs(oreData) do
                    if data.respawn and GetGameTimer() >= data.respawn then
                        spawnOre(zoneId, oreId)
                    end
                end
            end
            Wait(1000)
        else
            Wait(10000)
        end
    end
end)

-- Setup on player loaded
AddEventHandler('lation_farming:onPlayerLoaded', function()
    lib.zones.sphere({
        coords = shared.farming.center,
        radius = 400,
        onEnter = enterMine,
        onExit = exitMine,
        debug = shared.setup.debug
    })
end)

-- Cleanup on resource stop
--- @param resourceName string
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for zoneId, oreData in pairs(farm) do
        for _, data in pairs(oreData) do
            if data.entity and DoesEntityExist(data.entity) then
                DeleteEntity(data.entity)
            end
        end
        farm[zoneId] = nil
    end
end)