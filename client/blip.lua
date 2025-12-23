CreateThread(function()
    local blip = AddBlipForCoord(Config.BusNPC.coords.x, Config.BusNPC.coords.y, Config.BusNPC.coords.z)

    SetBlipSprite(blip, 513)
    SetBlipColour(blip, 22)
    SetBlipScale(blip, 0.9)
    SetBlipAsShortRange(true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bus Job")
    EndTextCommandSetBlipName(blip)
end)