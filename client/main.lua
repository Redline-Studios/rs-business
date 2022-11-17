QBCore = exports['qb-core']:GetCoreObject()
sharedItems = QBCore.Shared.Items
local Player = QBCore.Functions.GetPlayerData()
local PlayerJob = QBCore.Functions.GetPlayerData().job
local onDuty = false
local zonesTable = {} -- Table for target zones

-- FUNCTIONS --
local function ToggleDuty()
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
        if k ~= 'Registers' and k ~= 'Duty' and k ~= 'Stashes' and k ~= 'Trays' and k ~= 'Sink' then
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
        elseif k == 'Registers' then
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

        elseif k == 'Duty' then
            for r, s in pairs(Config.Locations['Duty']) do
                DutyZones = exports['qb-target']:AddBoxZone('Duty '..Config.Job..r, s.coords, s.length, s.width, {
                    name = 'Duty '..Config.Job..r,
                    heading = s.heading,
                    debugPoly = Config.DebugPoly,
                    minZ = s.coords.z - 1,
                    maxZ = s.coords.z + 1,
                    }, {
                        options = {
                            {
                                type = 'server',
                                event = 'QBCore:ToggleDuty',
                                icon = s.info.icon,
                                label = s.info.label,
                                job = Config.Job
                            },
                        },
                    distance = 2.0
                })
            end

            table.insert(DutyZones, zonesTable)

        elseif k == 'Stashes' then
            for r, s in pairs(Config.Locations['Stashes']) do
                StashZones = exports['qb-target']:AddBoxZone('Stash '..Config.Job..r, s.coords, s.length, s.width, {
                    name = 'Stash '..Config.Job..r,
                    heading = s.heading,
                    debugPoly = Config.DebugPoly,
                    minZ = s.coords.z - 1,
                    maxZ = s.coords.z + 1,
                    }, {
                        options = {
                            {
                                action = function()
                                    TriggerEvent('rs-'..Config.Job..':OpenStash', r)
                                end,
                                icon = s.info.icon,
                                label = s.info.label,
                                job = Config.Job
                            },
                        },
                    distance = 2.0
                })
            end

            table.insert(StashZones, zonesTable)

        elseif k == 'Trays' then
            for r, s in pairs(Config.Locations['Trays']) do
                CounterZones = exports['qb-target']:AddBoxZone('Tray '..Config.Job..r, s.coords, s.length, s.width, {
                    name = 'Tray '..Config.Job..r,
                    heading = s.heading,
                    debugPoly = Config.DebugPoly,
                    minZ = s.coords.z - 1,
                    maxZ = s.coords.z + 1,
                    }, {
                        options = {
                            {
                                action = function()
                                    TriggerEvent('rs-'..Config.Job..':OpenTray', r)
                                end,
                                icon = s.info.icon,
                                label = s.info.label,
                            },
                        },
                    distance = 2.0
                })
            end

            table.insert(CounterZones, zonesTable)

        elseif k == 'Sink' then
            for r, s in pairs(Config.Locations['Sink']) do
                SinkZones = exports['qb-target']:AddBoxZone('Sink '..Config.Job..r, s.coords, s.length, s.width, {
                    name = 'Sink '..Config.Job..r,
                    heading = s.heading,
                    debugPoly = Config.DebugPoly,
                    minZ = s.coords.z - 1,
                    maxZ = s.coords.z + 1,
                    }, {
                        options = {
                            {
                                type = 'client',
                                event = 'rs-'..Config.Job..'WashHands',
                                icon = s.info.icon,
                                label = s.info.label,
                                job = Config.Job
                            },
                        },
                    distance = 2.0
                })
            end

            table.insert(SinkZones, zonesTable)
        end
    end
end

RegisterNetEvent('rs-'..Config.Job..':OpenTray', function(stashID)
    print('BusinessTray_'..Config.Job..'_'..stashID)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'BusinessTray_'..Config.Job..'_'..stashID, {maxweight = Config.Trays.MaxWeight, slots = Config.Trays.MaxSlots})
    TriggerEvent("inventory:client:SetCurrentStash", 'BusinessTray_'..Config.Job..'_'..stashID)
end)

RegisterNetEvent('rs-'..Config.Job..':OpenStash', function(stashID)
    print('BusinessStash_'..Config.Job..stashID)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'BusinessStash_'..Config.Job..'_'..stashID, {maxweight = Config.Stashes.MaxWeight, slots = Config.Stashes.MaxSlots})
    TriggerEvent("inventory:client:SetCurrentStash", 'BusinessStash_'..Config.Job..'_'..stashID)
end)

RegisterNetEvent('rs-'..Config.Job..'WashHands', function()
    QBCore.Functions.Progressbar("wash_hands", 'Washing your hands...', (Config.Times.WashHands * 1000), false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mp_arresting",
		anim = "a_uncuff",
		flags = 49,
	}, {}, {}, function()
        QBCore.Functions.Notify('You washed your hands!', 'success', 5000)
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

local function CreateDutyZones()
    for k,v in pairs(Config.Business.BusinessPoly.Zones) do
        local InstallZones = PolyZone:Create(v.zone, {
            name = "Zone" .. Config.Job..k,
            minZ = v.minZ,
            maxZ = v.maxZ,
            debugPoly = Config.DebugPoly
        })
        InstallZones:onPlayerInOut(function(isPointInside)
            if isPointInside then
                if PlayerJob.name == Config.Job then
                    ToggleDuty()
                end
            else
                if PlayerJob.name == Config.Job then
                    ToggleDuty()
                end
            end
        end)
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

RegisterNetEvent('rs-'..Config.Job..':client:MakeItem', function(data)
    local Item = data.item
    local Required = data.required
    local ItemID = data.itemID
    local Emote = data.craftemote

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

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.name == Config.Job and PlayerJob.name ~= Config.Job then
        if JobInfo.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
            onDuty = false
        end
    end
    PlayerJob = JobInfo
end)

-- PLAYER LOAD / UNLOAD --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Player = QBCore.Functions.GetPlayerData()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = PlayerJob.onduty

    CreateBusinessZones()
    CreateBusinessBlip()
    if Config.Business.AutoDuty then
        CreateDutyZones()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
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