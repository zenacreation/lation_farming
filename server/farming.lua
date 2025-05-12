-- Initalize config(s)
local shared = require 'config.shared'
local server = require 'config.server'

-- Localize export
local farming = exports.lation_farming

-- Initialize table to store ore data
local farm = {}

-- Ore has been mined
--- @param zoneId number
--- @param oreId number
RegisterNetEvent('lation_farming:minedore', function(zoneId, oreId)
    if not source or not zoneId or not oreId then return end
    local source = source

    local zone = shared.farming.zones[zoneId]
    if not zone then return end

    local ore = zone.farm[oreId]
    if not ore then return end

    farm[zoneId] = farm[zoneId] or {}
    farm[zoneId][oreId] = farm[zoneId][oreId] or {}
    local status = farm[zoneId][oreId][source]
    if status and status.time and status.time > os.time() then return end

    local coords = GetEntityCoords(GetPlayerPed(source))
    if #(coords - ore) > 10 then return end

    local level = farming:GetPlayerData(source, 'level')
    if level < zone.level then return end

    local identifier = GetIdentifier(source)
    if not identifier then return end
    local name = GetName(source)
    if not name then return end

    local shovel, data = false, {}
    for pick_level, pick_data in pairs(shared.shovels) do
        if pick_level <= level and GetItemCount(source, pick_data.item) > 0 then
            shovel, data = true, pick_data
            break
        end
    end
    if not shovel then return end

    local items = {}
    for _, add in pairs(zone.reward) do
        local chance = add.chance or 100
        if math.random(100) <= chance then
            local quantity = math.random(add.min, add.max)
            if not CanCarry(source, add.item, quantity) then
                TriggerClientEvent('lation_farming:notify', source, locale('notify.cant-carry'), 'error')
                return
            end
            AddItem(source, add.item, quantity)
            farming:AddPlayerData(source, 'mined', quantity)
            items[#items + 1] = { item = add.item, quantity = quantity }
        end
    end

    local metadata, metatype = GetMetadata(source, data.item), GetDurabilityType()
    if not metadata or not metadata[metatype] or metadata[metatype] < data.degrade then return end

    local durability = metadata[metatype] - data.degrade
    SetMetadata(source, data.item, metatype, durability)

    local addXP = math.random(zone.xp.min, zone.xp.max)
    farming:AddPlayerData(source, 'exp', addXP)

    farm[zoneId][oreId][source] = { time = os.time() + math.floor(zone.respawn / 1000) }

    if server.logs.events.mined then
        local rewards = ''
        for _, reward in ipairs(items) do
            rewards = rewards .. 'x' .. reward.quantity .. ' ' .. reward.item .. ', '
        end
        rewards = rewards:sub(1, -3)
        PlayerLog(source, locale('logs.mined-title'), locale('logs.mined-message', name, identifier, rewards))
    end
end)

-- Ore validation management thread
CreateThread(function()
    while true do
        if next(farm) then
            for zoneId, zoneData in pairs(farm) do
                for oreId, status in pairs(zoneData) do
                    if status.time and status.time <= os.time() then
                        farm[zoneId][oreId][source] = nil
                    end
                end
            end
            Wait(1000)
        else
            Wait(10000)
        end
    end
end)