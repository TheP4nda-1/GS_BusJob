Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        ESX = exports["es_extended"]:getSharedObject()
    end
end)

function getRouteById(routeId)
    for _, route in pairs(Config.Routes) do
        if route.id == routeId then
            return route
        end
    end
    return nil
end


local currentRoute = nil
local currentStopIndex = 1
local currentBlip = nil
local currentVehicle = nil
local currentBus = 0
function setRouteBlip(coords)
    if currentBlip then
        RemoveBlip(currentBlip)
    end

    currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(currentBlip, 1)
    SetBlipColour(currentBlip, 5)
    SetBlipScale(currentBlip, 0.9)
    SetBlipRoute(currentBlip, true)
    SetBlipRouteColour(currentBlip, 5)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bus Haltestelle")
    EndTextCommandSetBlipName(currentBlip)
end


function startRoute(routeId)
    currentRoute = getRouteById(routeId)
    if not currentRoute then
        
        return
    end

    currentStopIndex = 1

    ESX.Game.SpawnVehicle(
        currentRoute.bus,
        Config.BusSpawn.coords,
        Config.BusSpawn.heading,
        function(vehicle)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            SetVehicleEngineOn(vehicle, true, true, false)
            SetVehicleNumberPlateText(vehicle, "BUSJOB")
            SetVehicleDirtLevel(vehicle, 0.0)
            SetEntityAsMissionEntity(vehicle, true, true)
            currentVehicle = vehicle
            currentBus = currentRoute.bus
        end
    )

    -- ERSTER BLIP
    setRouteBlip(currentRoute.stops[currentStopIndex])
end

CreateThread(function()
    while true do
        Wait(0)

        if currentRoute and currentRoute.stops[currentStopIndex] then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local stopCoords = currentRoute.stops[currentStopIndex]

            local dist = #(coords - stopCoords)

            if dist < 25.0 then
                DrawMarker(
                    1,
                    stopCoords.x, stopCoords.y, stopCoords.z - 1.0,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    5.0, 5.0, 1.0,
                    100, 136, 255, 120,
                    false, true, 2, false
                )

                if dist < 3.0 then
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um Passagiere aufzunehmen")

                    if IsControlJustPressed(0, 38) then -- E
                        handleStopReached()
                    end
                end
            end
        end
    end
end)
function handleStopReached()
    controlsLocked = true
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    


    if GetEntityModel(vehicle) == GetHashKey(currentBus) then
        
        
        ESX.ShowNotification("Passagiere ein-/ausgestiegen 🚍")
        SetVehicleHandbrake(vehicle, true)
        FreezeEntityPosition(vehicle, true)
        exports['esx_progressbar']:Progressbar("Passagiere steigen ein...", 3000)
        Wait(3000)
        FreezeEntityPosition(vehicle, false)
        SetVehicleHandbrake(vehicle, false)
        controlsLocked = false
        currentStopIndex = currentStopIndex + 1

        if currentRoute.stops[currentStopIndex] then
            setRouteBlip(currentRoute.stops[currentStopIndex])
        else
            finishRoute()
        end
    else
        ESX.ShowNotification("Du bist nicht in deinem Bus! 🚍")
    end
end


function finishRoute()
    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end
    local price = math.random(currentRoute.pricemin, currentRoute.pricemax)

    TriggerServerEvent("busjob:payFinish", price)
    ESX.ShowNotification("Route abgeschlossen 💰 Du hast" .. price .. "€ bekommen")
    ESX.Game.DeleteVehicle(currentVehicle)
    -- Finale Auszahlung

    

    currentRoute = nil
    currentStopIndex = 1
end




