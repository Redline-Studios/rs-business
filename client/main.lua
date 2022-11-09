QBCore = exports['qb-core']:GetCoreObject()
sharedItems = QBCore.Shared.Items
local Player = QBCore.Functions.GetPlayerData()
local PlayerJob = QBCore.Functions.GetPlayerData().job
local onDuty = QBCore.Functions.GetPlayerData().job.onDuty
local zonesTable = {} -- Table for food target zones

-- FUNCTIONS --
local function ToggleDuty(bool)
    onDuty = not onDuty
    TriggerServerEvent('QBCore:ToggleDuty')
end

local function DestroyBusinessZones()
    for k,v in pairs(zonesTable) do
        exports['qb-target']:RemoveZone(v)
    end
end

local function CreateBusinessZones()
    for k, v in pairs(Config.Locations) do
        if k ~= 'Registers' then
            for r, s in pairs(Config.Locations[k]) do
                BusinessZone = exports['qb-target']:AddBoxZone(Config.Job..k..r, s.coords, s.length, s.width, {
                    name = Config.Job..k..r,
                    heading = s.heading,
                    debugPoly = Config.DebugPoly,
                    minZ = s.coords.z - 1,
                    maxZ = s.coords.z + 1,
                    }, {
                        options = {
                            {
                                type = 'client',
                                event = 'rs-'..Config.Job..':client:Open'..k,
                                icon = s.info.icon,
                                label = s.info.label,
                                job = Config.Job
                            },
                        },
                    distance = 2.0
                })

                table.insert(BusinessZone, zonesTable)
            end
        else
            for r, s in pairs(Config.Locations['Registers']) do
                RegistersZones = exports['qb-target']:AddBoxZone('Register '..Config.Job..r, s.coords, s.length, s.width, {
                    name = 'Register '..Config.Job..r,
                    heading = s.heading,
                    debugPoly = Config.DebugPoly,
                    minZ = s.coords.z - 1,
                    maxZ = s.coords.z + 1,
                    }, {
                        options = {
                            {
                                type = 'client',
                                event = s.info.event,
                                icon = s.info.icon,
                                label = s.info.label,
                                job = Config.Job
                            },
                        },
                    distance = 2.0
                })
            end

            table.insert(RegistersZones, zonesTable)
        end
    end
end

local function CreateDutyZones()
    if not ZonesCreated then
        local InstallZones = PolyZone:Create(Config.Business.BusinessPoly.zone, {
            name = "Zone" .. Config.Job,
            minZ = Config.Business.BusinessPoly.minZ,
            maxZ = Config.Business.BusinessPoly.maxZ,
            debugPoly = Config.DebugPoly
        })
        InstallZones:onPlayerInOut(function(isPointInside)
            if isPointInside then
                if PlayerJob.name == Config.Job then
                    if not onDuty then
                        ToggleDuty(true)
                    end
                end
            else
                if PlayerJob.name == Config.Job then
                    if onDuty then
                        ToggleDuty(false)
                    end
                end
            end
        end)
        ZonesCreated = true
    end
end

local function RemoveBusinessBlips()
    RemoveBlip(businessBlip)
end

local function CreateBusinessBlip()
    local businessBlipInfo = Config.Business.Blip

    local businessBlip = AddBlipForCoord(businessBlipInfo.coords.x, businessBlipInfo.coords.y, businessBlipInfo.coords.z)
    SetBlipSprite(businessBlip, businessBlipInfo.sprite)
    SetBlipScale(businessBlip, businessBlipInfo.size)
    SetBlipDisplay(businessBlip, 4)
    SetBlipColour(businessBlip, businessBlipInfo.color)
    SetBlipAsShortRange(businessBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Business.Name)
    EndTextCommandSetBlipName(businessBlip)
end

RegisterNetEvent('rs-'..Config.Job..':client:MakeFood', function(data)
    local Item = data.item
    local Required = data.required
    local ItemID = data.itemID
    local Emote = data.emote

    QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:HasItems', function(hasItems)
        if hasItems then
            TriggerEvent('animations:client:EmoteCommandStart', {Emote})
            exports['ps-ui']:Circle(function(success)
                if success then
                    QBCore.Functions.Progressbar('business_food', 'Making a '..sharedItems[Item].label, (Config.Times.Food * 1000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:GetItem', function(isMade)
                            if isMade then
                                QBCore.Functions.Notify('You made a '..sharedItems[Item].label..'!', 'success', 5000)
                            end
                        end, Item, Required)
                    end, function()
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify('Canceled...', 'error', 2000)
                    end)
                else
                    QBCore.Functions.Notify('Nice, you spilled the drink. Make another!', 'error', 5000)
                end
            end, Config.Minigame.Circles, Config.Minigame.Time)
        else
            QBCore.Functions.Notify('You don\'t have the required items!', 'error', 5000)
        end
    end, Config.Food[ItemID].Required)
end)

RegisterNetEvent('rs-'..Config.Job..':client:MakeDrink', function(data)
    local Item = data.item
    local Required = data.required
    local ItemID = data.itemID
    local Emote = data.emote

    QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:HasItems', function(hasItems)
        if hasItems then
            TriggerEvent('animations:client:EmoteCommandStart', {Emote})
            exports['ps-ui']:Circle(function(success)
                if success then
                    QBCore.Functions.Progressbar('business_drink', 'Making a '..sharedItems[Item].label, (Config.Times.Drinks * 1000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:GetItem', function(isMade)
                            if isMade then
                                QBCore.Functions.Notify('You made a '..sharedItems[Item].label..'!', 'success', 5000)
                            end
                        end, Item, Required)
                    end, function()
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify('Canceled...', 'error', 2000)
                    end)
                else
                    QBCore.Functions.Notify('Nice, you spilled the drink. Make another!', 'error', 5000)
                end
            end, Config.Minigame.Circles, Config.Minigame.Time)
        else
            QBCore.Functions.Notify('You don\'t have the required items!', 'error', 5000)
        end
    end, Config.Drinks[ItemID].Required)
end)

-- PLAYER LOAD / UNLOAD --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Player = QBCore.Functions.GetPlayerData()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = QBCore.Functions.GetPlayerData().job.onDuty

    CreateBusinessZones()
    CreateBusinessBlip()
    if Config.Business.AutoDuty then
        CreateDutyZones()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnloaded', function()
    DestroyBusinessZones()
    RemoveBusinessBlips()
end)

-- RESOURCE START / STOP --
AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
      Wait(100)
      CreateBusinessZones()
      CreateBusinessBlip()
      if Config.Business.AutoDuty then
        CreateDutyZones()
    end
   end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DestroyBusinessZones()
        RemoveBusinessBlips()
    end
end)