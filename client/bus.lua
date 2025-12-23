


Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        ESX = exports["es_extended"]:getSharedObject()
        startaction()
    end
end)
local ped

Citizen.CreateThread(function()
    local coords = Config.BusNPC.coords
    local heading = Config.BusNPC.heading
    local model = Config.BusNPC.model

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    -- Ped erstellen
    ped = CreatePed(
        0,
        model,
        coords.x, coords.y, coords.z - 1.0,
        heading,
        false,
        true
    )

    -- Ped Settings
    SetEntityInvincible(ped, true)      -- unsterblich
    FreezeEntityPosition(ped, true)     -- bewegt sich nicht
    SetBlockingOfNonTemporaryEvents(ped, true) -- keine Reaktionen
    SetPedDiesWhenInjured(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local npcCoords = Config.BusNPC.coords
        local distance = #(playerCoords - npcCoords)
        if distance < 1.0 then
            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Busfahrer anzusprechen.")
            if IsControlJustReleased(0, 38) then
                openM()
                SetNuiFocus(true, true)

                SendNUIMessage({
                    action = "open"
                })
                    
            end
        end
    end
end)


