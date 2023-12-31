-- gets framework
if (GetResourceState("es_extended") == "started") then
  if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
    ESX = exports["es_extended"]:getSharedObject()
  else
    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
  end
end
-- this happens wen a player presses a key,
RegisterServerEvent('policeKeyPressed')
AddEventHandler('policeKeyPressed', function()
    -- local xPlayers = ESX.GetPlayers() -- gets all players

    -- for _, player in ipairs(xPlayers) do
    --     local xPlayer = ESX.GetPlayerFromId(player)

    --     if xPlayer.job.name == "police" then
    --         TriggerClientEvent('sendNotificationToPolice', player, 'Ein Spieler hat den Panic Button gedrückt!')
    --     end
    -- end

    local xPlayers = ESX.GetExtendedPlayers("job", "police") -- Returns all xPlayers with the job police, but doesnt work on esx version before 1.2
  for _, xPlayer in pairs(xPlayers) do
    TriggerClientEvent('showPoliceNotification', xPlayer.source, 'Ein Spieler hat den Panic Button gedrückt!') -- this event was wrong in the old code
  end
end)

-- RegisterServerEvent('sendNotificationToPolice')
-- AddEventHandler('sendNotificationToPolice', function(message)
--     -- this event sends a message to "everyone" thats what -1 stands for. (all ids)

--     -- i woould rewrite it like this:


--     --TriggerClientEvent('showPoliceNotification', -1, message)
-- end)
