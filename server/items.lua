QBCore = exports['qb-core']:GetCoreObject()
sharedItems = QBCore.Shared.Items

-- USE ITEMS --
QBCore.Functions.CreateCallback('rs-'..Config.Job..':server:UseItem',function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local callback = false

    if Player.Functions.RemoveItem(item, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[item], 'remove', 1)
        callback = true
    end

    cb(callback)
end)

RegisterNetEvent('rs-'..Config.Job..':server:addThirst', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    Player.Functions.SetMetaData('thirst', amount)
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata.thirst, amount)
end)

RegisterNetEvent('rs-'..Config.Job..':server:addHunger', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    Player.Functions.SetMetaData('hunger', amount)
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata.hunger, amount)
end)

-- FOOD ITEMS --
for k,v in pairs(Config.Food) do
    QBCore.Functions.CreateUseableItem(v.Item, function(source)
        local src = source
        print(v.Item, v.UseEmote, v.UseTime, v.Hunger)
        TriggerClientEvent("rs-"..Config.Job..":client:Eat", src, v.Item, v.UseEmote, v.UseTime, v.Hunger)
    end)
end

-- DRINK ITEMS --
for k,v in pairs(Config.Drinks) do
    QBCore.Functions.CreateUseableItem(v.Item, function(source)
        local src = source
        TriggerClientEvent("rs-"..Config.Job..":client:Drink", src, v.Item, v.UseEmote, v.UseTime, v.Thirst)
    end)
end

-- COFFEE ITEMS --
for k,v in pairs(Config.Coffee) do
    QBCore.Functions.CreateUseableItem(v.Item, function(source)
        local src = source
        TriggerClientEvent("rs-"..Config.Job..":client:DrinkCoffee", src, v.Item, v.UseEmote, v.UseTime, v.Thirst)
    end)
end

-- ALCOHOL ITEMS --
for k,v in pairs(Config.Alcohol) do
    QBCore.Functions.CreateUseableItem(v.Item, function(source)
        local src = source
        TriggerClientEvent("rs-"..Config.Job..":client:DrinkAlcohol", src, v.Item, v.UseEmote, v.UseTime, v.Thirst)
    end)
end