ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while true do 
	   Citizen.Wait(400)
	   if CouleurRandom == "~b~" then CouleurRandom = "~r~" else CouleurRandom = "~b~" end 
   end 
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end


-- Menu --
local open = false
local MenuMain = RageUI.CreateMenu("Menu Météo", "Interaction")
local Heure = RageUI.CreateSubMenu(MenuMain, "Heure", "Interaction")
local Temps = RageUI.CreateSubMenu(MenuMain, "Temps", "Interaction")
local Freeze = RageUI.CreateSubMenu(MenuMain, "Frezze", "Interaction")
MenuMain.Display.Header = true
MenuMain.Closed = function()
    open = false
end

function OpenMeteoMenu()    
    if open then 
        open = false
        RageUI.Visible(MenuMain, false)
        return
    else
        open = true
        RageUI.Visible(MenuMain, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuMain, function()

                    RageUI.Separator("↓     ~g~Temps / Heures     ~s~↓" )
                    RageUI.Button("Heure", "Gestion Heure", {RightLabel = "→→→"}, true, {}, Heure)
                    RageUI.Button("Temps", "Gestion du Temps", {RightLabel = "→→→"}, true, {}, Temps)

                    RageUI.Separator("↓     ~g~Freeze     ~s~↓")

                    RageUI.Button("Mode Frezze", "Gestion des Frezze", {RightLabel = "→→→"}, true, {}, Freeze)

                    RageUI.Separator("↓     ~g~Lumière de la ville     ~s~↓")
                    RageUI.Button("Blackout", "Éteindre les lumières de la ville", {RightLabel = "~g~ON~s~/~r~OFF"}, true, {
                        onSelected = function()
                            ExecuteCommand('blackout')
                        end
                    })

                    RageUI.Separator("~h~Vous êtes l'ID~s~ : "..CouleurRandom.."" ..GetPlayerServerId(PlayerId()))

                end)

                RageUI.IsVisible(Temps, function()
                    RageUI.Separator("↓     ~g~Personalisée     ~s~↓")
                    RageUI.Button("Changer le temps", "~r~ Exemple : wather extrasunny", {RightLabel = "→→"}, true, {
                        onSelected = function()
                            local AvailableWeatherTypes = KeyboardInput('Entrer le temps que vous souhaitez', '', 45)
							ExecuteCommand("weather "..AvailableWeatherTypes)
                        end
                    })
                    RageUI.Separator("↓     ~g~Temps au Choix     ~s~↓")
                    RageUI.Button("~r~Normal", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather neutral') end})
                    RageUI.Separator("↓     ~g~ETE     ~s~↓")
                    RageUI.Button("Ensoleillé", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather extrasunny') end})
                    RageUI.Button("Dégager", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather clear') end})
                    RageUI.Separator("↓     ~g~HIVERS     ~s~↓")
                    RageUI.Button("Faible Neige", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather snowlight') end})
                    RageUI.Button("Neige", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather snow') end})
                    RageUI.Button("Enneiger", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather xmas') end})
                    RageUI.Separator("↓     ~g~AUTRES     ~s~↓")
                    RageUI.Button("Nuageux", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather clouds') end})
                    RageUI.Button("Brouillard", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather smog') end})
                    RageUI.Button("Nuageux ", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather overcast') end})
                    RageUI.Button("Pluie", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather rain') end})
                    RageUI.Button("Tempête", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather blizzard') end})
                    RageUI.Button("Halloween", nil, {RightLabel = "→"}, true, {onSelected = function() ExecuteCommand('weather halloween') end})

                end)

                RageUI.IsVisible(Heure, function()
                    RageUI.Separator("↓     ~g~Personalisée     ~s~↓")
                    RageUI.Button("Changer d'heure", "~r~ Exemple : 12 00", {RightLabel = "→→"}, true, {
                        onSelected = function()
                            local heure = KeyboardInput('Entrer l\'heure que vous souhaitez', '', 45)
							ExecuteCommand("time "..heure)
                        end
                    })
                    RageUI.Separator("↓     ~g~Heure au Choix     ~s~↓")
                    RageUI.Button("06:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 06 00') end})
                    RageUI.Button("08:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 08 00') end})
                    RageUI.Button("10:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 10 00') end})
                    RageUI.Button("12:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 12 00') end})
                    RageUI.Button("14:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 14 00') end})
                    RageUI.Button("16:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 16 00') end})
                    RageUI.Button("18:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 18 00') end})
                    RageUI.Button("20:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 20 00') end})
                    RageUI.Button("22:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 22 00') end})
                    RageUI.Button("00:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 00 00') end})
                    RageUI.Button("02:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 02 00') end})
                    RageUI.Button("04:00", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('time 04 00') end})

                end)

                RageUI.IsVisible(Freeze, function()
                    RageUI.Separator("↓     ~g~Frezze     ~s~↓")
                    RageUI.Button("Freeze Heure", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('freezetime') end})
                    RageUI.Button("Freeze Temps", nil, {RightLabel = "→"}, true, { onSelected = function() ExecuteCommand('freezeweather') end})

                end)
            Wait(0)
            end
        end)
    end
end

RegisterCommand("meteo", function(source, args)
    OpenMeteoMenu()
end)
