RegisterNetEvent("busjob:payFinish", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    xPlayer.addMoney(amount)
end)
