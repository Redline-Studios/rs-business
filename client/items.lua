QBCore = exports['qb-core']:GetCoreObject()
sharedItems = QBCore.Shared.Items
local alcoholCount = 0
local beerCount = 0
local isMaxDrunk = false

-- EFFECTS --
local function DrinkCoffee()
    SetRunSprintMultiplierForPlayer(PlayerId(), Config.Speed.Multiplier)
    Wait(Config.Speed.Length * 1000)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function SetPedDrunk(shake, time)
    local playerPed = PlayerPedId()
    Wait(650)
    SetPedMotionBlur(playerPed, true)
    SetTimecycleModifier("spectator3")
    SetPedMovementClipset(playerPed, "move_m@hobo@a", true)
    SetPedIsDrunk(playerPed, true)
    ShakeGameplayCam("DRUNK_SHAKE", shake)
    Wait(time * 60000)
    alcoholCount = 0
    beerCount = 0
    SetPedMoveRateOverride(playerPed, 1.0)
    SetRunSprintMultiplierForPlayer(playerPed, 1.0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(playerPed)
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end

---------------------------------------------
---------- EATING / DRINKING EVENTS ---------
---------------------------------------------
-- EAT EVENT --
RegisterNetEvent("rs-"..Config.Job..":client:Eat", function(item, emote, time, hunger)
    local hasItem = QBCore.Functions.HasItem(item)
    local Emote = tostring(emote)

    if hasItem then
        TriggerEvent('animations:client:EmoteCommandStart', {Emote})
        QBCore.Functions.Progressbar('eating_something', 'Eating '..sharedItems[item].label, (time * 1000), false, true, {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {'c'})
            QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:UseItem', function(hasEaten)
                if hasEaten then
                    TriggerServerEvent('rs-'..Config.Job..':server:addHunger', QBCore.Functions.GetPlayerData().metadata["hunger"] + hunger)
                    QBCore.Functions.Notify('You ate a '..sharedItems[item].label..'!', 'success', 5000)
                end
            end, item)
        end, function()
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify('Canceled...', 'error', 2000)
        end)
    end
end)

-- DRINK EVENT --
RegisterNetEvent("rs-"..Config.Job..":client:Drink", function(item, emote, time, thirst)
    local hasItem = QBCore.Functions.HasItem(item)

    if hasItem then
        TriggerEvent('animations:client:EmoteCommandStart', {emote})
        QBCore.Functions.Progressbar('drink_something', 'Drinking '..sharedItems[item].label, (time * 1000), false, true, {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {'c'})
            QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:UseItem', function(hasDrank)
                if hasDrank then
                    TriggerServerEvent('rs-'..Config.Job..':server:addThirst', QBCore.Functions.GetPlayerData().metadata["thirst"] + thirst)
                    QBCore.Functions.Notify('You drank a '..sharedItems[item].label..'!', 'success', 5000)
                end
            end, item)
        end, function()
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify('Canceled...', 'error', 2000)
        end)
    end
end)

-- DRINK ALCOHOL --
RegisterNetEvent("rs-"..Config.Job..":client:DrinkAlcohol", function(item, emote, time, thirst)
    local hasItem = QBCore.Functions.HasItem(item)
    local Emote = tostring(emote)

    if hasItem then
        TriggerEvent('animations:client:EmoteCommandStart', {Emote})
        QBCore.Functions.Progressbar('drinking_alcohol', 'Drinking '..sharedItems[item].label, (time * 1000), false, true, {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {'c'})
            QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:UseItem', function(hasDrank)
                if hasDrank then
                    TriggerServerEvent('rs-'..Config.Job..':server:addThirst', QBCore.Functions.GetPlayerData().metadata["thirst"] + thirst)
                    QBCore.Functions.Notify('You drank a '..sharedItems[item].label..'!', 'success', 5000)
                    if item == 'beer' then
                        beerCount = beerCount + 1
                        if beerCount > Config.Drunk.Beer.Min and beerCount < Config.Drunk.Beer.Max then
                            SetPedDrunk(0.5, (Config.Drunk.Beer.Length))
                            QBCore.Functions.Notify('You feel a slight buzz coming on...', 'success', 5000)

                        elseif beerCount >= Config.Drunk.Beer.Max and not isMaxDrunk then
                            SetPedDrunk(1.0, (Config.Drunk.Beer.Length))
                            QBCore.Functions.Notify('Holy shit you\'re wasted!', 'success', 5000)
                            isMaxDrunk = true
                        end
                    else
                        alcoholCount = alcoholCount + 1
                        if alcoholCount > Config.Drunk.Liquor.Min and alcoholCount < Config.Drunk.Liquor.Max then
                            SetPedDrunk(0.5, (Config.Drunk.Liquor.Length))
                            QBCore.Functions.Notify('You feel a slight buzz coming on...', 'success', 5000)

                        elseif alcoholCount >= Config.Drunk.Liquor.Max and not isMaxDrunk then
                            SetPedDrunk(1.0, (Config.Drunk.Liquor.Length))
                            QBCore.Functions.Notify('Holy shit you\'re wasted!', 'success', 5000)
                            isMaxDrunk = true
                        end
                    end
                end
            end, item)
        end, function()
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify('Canceled...', 'error', 2000)
        end)
    end
end)

-- DRINK COFFEE --
RegisterNetEvent("rs-"..Config.Job..":client:DrinkCoffee", function(item, emote, time, thirst)
    local hasItem = QBCore.Functions.HasItem(item)
    local Emote = tostring(emote)

    if hasItem then
        TriggerEvent('animations:client:EmoteCommandStart', {Emote})
        QBCore.Functions.Progressbar('drinking_coffee', 'Drinking '..sharedItems[item].label, (time * 1000), false, true, {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {'c'})
            QBCore.Functions.TriggerCallback('rs-'..Config.Job..':server:UseItem', function(hasDrank)
                if hasDrank then
                    TriggerServerEvent('rs-'..Config.Job..':server:addThirst', QBCore.Functions.GetPlayerData().metadata["thirst"] + thirst)
                    QBCore.Functions.Notify('You drank a '..sharedItems[item].label..'!', 'success', 5000)
                    DrinkCoffee()
                end
            end, item)
        end, function()
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify('Canceled...', 'error', 2000)
        end)
    end
end)