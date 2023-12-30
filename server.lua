ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('policeKeyPressed')
AddEventHandler('policeKeyPressed', function()
    local xPlayers = ESX.GetPlayers()

    for _, player in ipairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(player)

        if xPlayer.job.name == "police" then
            TriggerClientEvent('sendNotificationToPolice', player, 'Ein Spieler hat den Panic Button gedrückt!')
        end
    end
end)

RegisterServerEvent('sendNotificationToPolice')
AddEventHandler('sendNotificationToPolice', function(message)
    TriggerClientEvent('showPoliceNotification', -1, message)
end)
