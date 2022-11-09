QBCore = exports['qb-core']:GetCoreObject()
local sharedItems = QBCore.Shared.Items

-- Get Item
QBCore.Functions.CreateCallback('rs-'..Config.Job..':server:GetItem',function(source, cb, item, required)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local callback = false
    local idk = 0

    for k, v in pairs(required) do
        if Player.Functions.RemoveItem(v.item, v.amount) then
            idk = idk + 1
            TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[v.item], 'remove', v.amount)
            if idk >= #required then
                if Player.Functions.AddItem(item, 1) then
                    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[item], 'add', 1)
                    callback = true
                end
            end
        else
            callback = false
            return
        end

        if Config.Debug then
            print("Item: "..v.item, "Amount: "..v.amount)
        end
    end

    cb(callback)
end)

-- Check for Required Items
QBCore.Functions.CreateCallback('rs-'..Config.Job..':server:HasItems',function(source, cb, required)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local callback = false
    local idk = 0

    for k, v in pairs(required) do
        if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.amount then -- Check for materials
            idk = idk + 1
            if idk == #required then
                callback = true
            end
        end

        if Config.Debug then
            print("Item: "..v.item, "Amount: "..v.amount)
        end
    end

    cb(callback)
end)