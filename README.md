# GS_BusJob
Fivem ESX.BusJob
1️⃣ Overview
Der BusJob ist ein routenbasierter Job, bei dem Spieler:
Eine Route auswählen
Ein Bus-Fahrzeug spawnen
Haltestellen abfahren
Pro Halt bezahlt werden
Am Ende einen Bonus erhalten
Features:
Mehrere Routen
Dynamische Haltestellen
Automatische Blips
ESX-kompatibel
Erweiterbar für Level / XP / Trinkgeld

2️⃣ Installation
Voraussetzungen
ESX Legacy
OneSync empfohlen
Funktionierendes Job-System
Schritte
Ordner in resources/[jobs]/busjob
In server.cfg:
ensure busjob
Job in Datenbank anlegen:
INSERT INTO jobs (name, label) VALUES ('bus', 'Busfahrer');

3️⃣ File Structure
busjob/
│
├── client/
│   ├── main.lua
│   ├── blips.lua
│   └── routes.lua
│
├── server/
│   └── main.lua
│
├── config.lua
├── fxmanifest.lua
└── README.md

4️⃣ Config Reference (config.lua)
Grundkonfiguration
Config = {}

Config.JobName = "bus"
Config.Locale = "de"
Config.Debug = false
Zahlung
Config.PayPerStop = 120
Config.FinishBonus = 500
Config.PayAccount = "money" -- money | bank

5️⃣ Routes System
Routen definieren
Config.Routes = {
    [1] = {
        label = "Stadtzentrum",
        difficulty = "Einfach",
        stops = {
            vector3(435.1, -645.2, 28.7),
            vector3(210.4, -1020.5, 29.3),
            vector3(-305.7, -890.2, 31.1)
        }
    },

    [2] = {
        label = "Flughafen Express",
        difficulty = "Mittel",
        stops = {
            vector3(-1032.6, -2734.8, 20.1),
            vector3(-1150.4, -2850.2, 13.9)
        }
    }
}
Wichtige Hinweise
Reihenfolge = Fahrreihenfolge
Jeder vector3 ist ein Halt
Beliebig viele Routen möglich

6️⃣ NPC & Spawn Settings
NPC konfigurieren
Config.BusNPC = {
    model = "s_m_m_gentransport",
    coords = vector3(450.2, -630.3, 28.5),
    heading = 90.0
}
Bus Spawn
Config.BusSpawn = {
    coords = vector3(462.3, -620.8, 28.4),
    heading = 180.0,
    model = "bus"
}

7️⃣ Vehicle Handling
Bus spawnen
ESX.Game.SpawnVehicle("bus", Config.BusSpawn.coords, Config.BusSpawn.heading, function(vehicle)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehicleNumberPlateText(vehicle, "BUSJOB")
    SetEntityAsMissionEntity(vehicle, true, true)
end)
Sicherheitsfunktionen
Fahrzeug wird getrackt
Job endet bei Fahrzeugverlust
Nur Bus erlaubt

8️⃣ Payment System
Bezahlung pro Halt
TriggerServerEvent("busjob:payStop")
Server:
RegisterNetEvent("busjob:payStop", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney(Config.PayAccount, Config.PayPerStop)
end)
Bonus am Ende
xPlayer.addAccountMoney(Config.PayAccount, Config.FinishBonus)

9️⃣ Blips & UI
Haltestellen-Blip
local blip = AddBlipForCoord(stopCoords)
SetBlipSprite(blip, 513)
SetBlipColour(blip, 22)
SetBlipRoute(blip, true)
Dauerhafter Job-Blip
SetBlipAsShortRange(blip, false)

🔟 Events & Exports
Client Events
busjob:startRoute
busjob:nextStop
busjob:finishRoute
Server Events
busjob:payStop
busjob:payFinish
Export (optional)
exports("IsBusJobActive", function()
    return isOnRoute
end)

1️⃣1️⃣ Permissions & Job Check
if ESX.PlayerData.job.name ~= Config.JobName then
    ESX.ShowNotification("Du bist kein Busfahrer")
    return
end
Optional:
Dienstsystem
Uniform Pflicht
Level-Abfrage

1️⃣2️⃣ Customization Examples
Trinkgeld-System
local tip = math.random(10, 50)
xPlayer.addMoney(tip)
XP / Level
PlayerXP = PlayerXP + 1
Fahrfehler-Abzug
xPlayer.removeMoney(50)

1️⃣3️⃣ Debugging & Common Errors
NetID Fehler
➡ Fahrzeug vor Nutzung als MissionEntity setzen
Blip verschwindet
➡ Referenz speichern, nicht lokal überschreiben
Spieler kann mehrfach starten
➡ Boolean isOnRoute nutzen
if isOnRoute then return end

✅ Best Practices
✔ Route-Daten nur in config.lua
✔ Kein Hardcoding
✔ Events immer serverseitig absichern
✔ Debug-Prints über Config.Debug

