local menuOpen = false

function openM()
    menuOpen = true
end


RegisterCommand("open", function()
    if menuOpen then return end

    menuOpen = true
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = "open"
    })
end, false)

RegisterNUICallback("close", function(_, cb)
    if not menuOpen then
        cb("ok")
        return
    end

    menuOpen = false
    SetNuiFocus(false, false)

    cb("ok")
end)

RegisterNUICallback("startRoute", function(data, cb)
    
    SendNUIMessage({
        action = "close"
    })
    menuOpen = false
    SetNuiFocus(false, false)
    cb("ok")
    startRoute(data.routeId)
end)
