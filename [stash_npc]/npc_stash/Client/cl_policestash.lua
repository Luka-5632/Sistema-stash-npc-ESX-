local hasItems = false

Citizen.CreateThread(function()
    print(json.encode(Config.NPCs))
    for _, npc in ipairs(Config.NPCs) do
        local model = lib.requestModel(npc.model)

        if model then
            local ped = CreatePed(0, model, npc.position.xyz, npc.position.w, false, true)
            SetModelAsNoLongerNeeded(model)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)

            exports.ox_target:addBoxZone({
                coords = vector3(npc.position.x, npc.position.y, npc.position.z + 1), -- Adjust z for interaction level
                size = vec3(2, 2, 2),
                rotation = 45,
                debug = drawZones,
                options = {
                    {
                        icon = 'fa-solid fa-folder',
                        label = 'Interagisci con ' .. npc.name,
                        onSelect = function()
                            ESX.TriggerServerCallback('npc:isAuthorizedJob', function(isAuthorized)
                                if isAuthorized then
                                    if hasItems then
                                        for _, item in ipairs(npc.items) do
                                            TriggerServerEvent('npc:removeSpecificItem', item, npc.name)
                                        end
                                        hasItems = false
                                        ESX.ShowNotification("Oggetti restituiti a " .. npc.name .. "!", "success")
                                    else
                                        TriggerServerEvent('npc:checkPlayerItems', npc.name)
                                    end
                                else
                                    ESX.ShowNotification("Non sei autorizzato a interagire con " .. npc.name, "error")
                                end
                            end)
                        end,
                    }
                }
            })
        else
            print("Modello " .. npc.model .. " non trovato.")
        end
    end
end)

RegisterNetEvent('npc:canReceiveItemsResponse')
AddEventHandler('npc:canReceiveItemsResponse', function(canReceive, npcName)
    local npcConfig = nil
    for _, npc in ipairs(Config.NPCs) do
        if npc.name == npcName then
            npcConfig = npc
            break
        end
    end

    if npcConfig then
        if canReceive then
            for _, item in ipairs(npcConfig.items) do
                TriggerServerEvent('npc:giveSpecificItem', item, npcName)
            end
            hasItems = true
            ESX.ShowNotification("Oggetti ricevuti da " .. npcName .. "!", "success")
        else
            ESX.ShowNotification("Hai già ricevuto gli oggetti da " .. npcName .. " e devi restituirli prima di poter interagire nuovamente.", "error")
        end
    end
end)
