local isCooldownActive = false
if (GetResourceState("es_extended") == "started") then
  if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
    ESX = exports["es_extended"]:getSharedObject()
  else
    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
  end
end




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local xPlayer = ESX.GetPlayerData()

        if xPlayer.job and xPlayer.job.name == "police" then
            if IsControlJustPressed(0, 38) and not isCooldownActive then
                TriggerServerEvent('policeKeyPressed')
                isCooldownActive = true
                Citizen.Wait(2000)
                isCooldownActive = false
            elseif isCooldownActive then
                TriggerEvent('showPoliceNotification', 'Du musst warten, um wieder den Panic Button drücken zu können!')
            end
        end
    end
end)

RegisterNetEvent('policeKeyPressedClient')
AddEventHandler('policeKeyPressedClient', function()
    local playerPed = PlayerId()

    TriggerServerEvent('sendNotificationToPolice', 'Ein Spieler hat den Panic Button gedrückt!')
    showInfobar('Drücke ~b~[E]~s~, um einen Wegpunkt zu setzen')
    SetNewWaypoint(GetEntityCoords(GetPlayerPed(-1)))

    local blip = AddBlipForCoord(GetEntityCoords(GetPlayerPed(-1)))
    SetBlipSprite(blip, 161)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 1.0)
    Wait(15000)
    RemoveBlip(blip)
end)

RegisterNetEvent('showPoliceNotification')
AddEventHandler('showPoliceNotification', function(message)
    ShowNotification(message)
end)

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

function showInfobar(msg)
    CurrentActionMsg = msg
    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
