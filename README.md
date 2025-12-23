# 🚌 BusJob – Developer Documentation

Vollständige Entwickler-Dokumentation für den **ESX BusJob**  
Alle Inhalte sind in Dropdowns organisiert, damit die README übersichtlich bleibt.

---

<details>
<summary><strong>📘 Overview</strong></summary>

### Was ist der BusJob?
Der BusJob ist ein ESX-basierter Job, bei dem Spieler als Busfahrer arbeiten und feste Routen mit mehreren Haltestellen abfahren.

### Features
- Mehrere Routen
- Haltestellen-System
- Bezahlung pro Halt
- Abschlussbonus
- Blip-Navigation
- Voll konfigurierbar

### Voraussetzungen
- ESX Legacy
- Empfohlen: OneSync
- Funktionierendes Job-System

</details>

---

<details>
<summary><strong>⚙️ Installation</strong></summary>

### Installation
1. Script in den resources Ordner legen  
2. In `server.cfg` eintragen:
```cfg
ensure busjob
Job in der Datenbank anlegen:

sql
Code kopieren
INSERT INTO jobs (name, label) VALUES ('bus', 'Busfahrer');
</details>
<details> <summary><strong>📁 File Structure</strong></summary>
text
Code kopieren
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
client/
→ Alles was der Spieler sieht (Blips, Routen, UI)

server/
→ Bezahlung, Sicherheit, Checks

</details>
<details> <summary><strong>🛠️ Configuration (config.lua)</strong></summary>
Allgemein
lua
Code kopieren
Config.JobName = "bus"
Config.Locale = "de"
Config.Debug = false
Option	Typ	Beschreibung
JobName	string	ESX Jobname
Locale	string	Sprache
Debug	boolean	Debug-Ausgaben

Payment
lua
Code kopieren
Config.PayPerStop = 120
Config.FinishBonus = 500
Config.PayAccount = "money"
</details>
<details> <summary><strong>🛣️ Routes</strong></summary>
Routen definieren
lua
Code kopieren
Config.Routes = {
    [1] = {
        label = "Stadtzentrum",
        difficulty = "Einfach",
        stops = {
            vector3(435.1, -645.2, 28.7),
            vector3(210.4, -1020.5, 29.3)
        }
    }
}
Hinweise
Reihenfolge der Stops = Fahrreihenfolge

Beliebig viele Routen möglich

Jede Route ist unabhängig

</details>
<details> <summary><strong>👤 NPC & Locations</strong></summary>
lua
Code kopieren
Config.BusNPC = {
    model = "s_m_m_gentransport",
    coords = vector3(450.2, -630.3, 28.5),
    heading = 90.0
}
Bus Spawn
lua
Code kopieren
Config.BusSpawn = {
    coords = vector3(462.3, -620.8, 28.4),
    heading = 180.0,
    model = "bus"
}
</details>
<details> <summary><strong>🚌 Vehicle System</strong></summary>
lua
Code kopieren
ESX.Game.SpawnVehicle("bus", Config.BusSpawn.coords, Config.BusSpawn.heading, function(vehicle)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehicleNumberPlateText(vehicle, "BUSJOB")
    SetEntityAsMissionEntity(vehicle, true, true)
end)
Sicherheit
Nur Job-Fahrzeug erlaubt

Fahrzeug wird getrackt

Despawn bei Job-Ende

</details>
<details> <summary><strong>💰 Payment System</strong></summary>
Pro Halt
lua
Code kopieren
TriggerServerEvent("busjob:payStop")
Server
lua
Code kopieren
RegisterNetEvent("busjob:payStop", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney(Config.PayAccount, Config.PayPerStop)
end)
Abschlussbonus
lua
Code kopieren
xPlayer.addAccountMoney(Config.PayAccount, Config.FinishBonus)
</details>
<details> <summary><strong>🗺️ Blips & UI</strong></summary>
lua
Code kopieren
local blip = AddBlipForCoord(stopCoords)
SetBlipSprite(blip, 513)
SetBlipColour(blip, 22)
SetBlipRoute(blip, true)
SetBlipAsShortRange(blip, false)
</details>
<details> <summary><strong>🔌 Events & Exports</strong></summary>
Client Events
busjob:startRoute

busjob:nextStop

busjob:finishRoute

Server Events
busjob:payStop

busjob:payFinish

Export
lua
Code kopieren
exports("IsBusJobActive", function()
    return isOnRoute
end)
</details>
<details> <summary><strong>🔐 Permissions & Job Checks</strong></summary>
lua
Code kopieren
if ESX.PlayerData.job.name ~= Config.JobName then
    ESX.ShowNotification("Du bist kein Busfahrer")
    return
end
</details>
<details> <summary><strong>🧩 Customization</strong></summary>
Trinkgeld
lua
Code kopieren
local tip = math.random(10, 50)
xPlayer.addMoney(tip)
XP System
lua
Code kopieren
PlayerXP = PlayerXP + 1
Strafen
lua
Code kopieren
xPlayer.removeMoney(50)
</details>
<details> <summary><strong>🛠️ Troubleshooting</strong></summary>
Häufige Fehler
❌ Kein Geld → Server Event fehlt

❌ Blip weg → Referenz überschrieben

❌ Fahrzeug NetID Fehler → MissionEntity fehlt

Debug
lua
Code kopieren
if Config.Debug then
    print("DEBUG: Route gestartet")
end
</details>
<details> <summary><strong>📄 Changelog</strong></summary>
v1.0.0
Initial Release

Routen-System

Payment-System

</details>
<details> <summary><strong>👑 Credits & License</strong></summary>
Author: Dein Name
Framework: ESX
Usage: Free / Private / Commercial (anpassen)

</details>
✅ Ergebnis
✔️ Eine einzige README.md

✔️ Dropdowns (aufklappbar)

✔️ Sauber & professionell

✔️ Perfekt für GitHub / Release

