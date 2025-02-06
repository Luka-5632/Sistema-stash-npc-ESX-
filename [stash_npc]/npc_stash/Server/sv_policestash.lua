ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('npc:isAuthorizedJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerJob = xPlayer.job.name

    if xPlayer and Config.allowedJobs[playerJob] then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('npc:checkPlayerItems')
AddEventHandler('npc:checkPlayerItems', function(npcName)
    local playerId = source
    MySQL.Async.fetchAll(
        'SELECT COUNT(*) as count FROM saved_items WHERE player_id = @playerId AND npc_name = @npcName',
        { ['@playerId'] = playerId, ['@npcName'] = npcName },
        function(result)
            if result[1].count > 0 then
                TriggerClientEvent('npc:canReceiveItemsResponse', playerId, false, npcName)
            else
                TriggerClientEvent('npc:canReceiveItemsResponse', playerId, true, npcName)
            end
        end
    )
end)

RegisterServerEvent('npc:giveSpecificItem')
AddEventHandler('npc:giveSpecificItem', function(item, npcName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    xPlayer.addInventoryItem(item, 1)

    MySQL.Async.execute(
        'INSERT INTO saved_items (player_id, item_name, item_count, npc_name) VALUES (@playerId, @itemName, 1, @npcName) ON DUPLICATE KEY UPDATE item_count = item_count + 1',
        {
            ['@playerId'] = playerId,
            ['@itemName'] = item,
            ['@npcName'] = npcName
        }
    )

    TriggerClientEvent('npc:itemGiven', playerId, item)
end)

RegisterServerEvent('npc:removeSpecificItem')
AddEventHandler('npc:removeSpecificItem', function(item, npcName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    xPlayer.removeInventoryItem(item, 1)

    MySQL.Async.execute(
        'DELETE FROM saved_items WHERE player_id = @playerId AND item_name = @itemName AND npc_name = @npcName',
        {
            ['@playerId'] = playerId,
            ['@itemName'] = item,
            ['@npcName'] = npcName
        }
    )
end)
