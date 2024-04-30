local display = true
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000)
--         if display then
--             TriggerServerEvent("vD:updateHud")
--         end
--     end
-- end)
-- RegisterNetEvent("vD:updateHudClient", function(cash,bank,coins)
--     SendNUIMessage({type="updateHud",cash=cash,bank=bank,coins=coins})
-- end)
RegisterNetEvent("vD:updateHudCash", function(cash)
    SendNUIMessage({type="updateHud",v="cash",cash=cash})
end)
RegisterNetEvent("vD:updateHudBank", function(bank)
    SendNUIMessage({type="updateHud",v="bank",b=bank})
end)
RegisterNetEvent("vD:updateHudCoins", function(coins)
    SendNUIMessage({type="updateHud",v="coins",c=coins})
end)
RegisterCommand("-MoneyNervos", function()
    SendNUIMessage({type="toggleMoney",vazelina=true})
    Citizen.Wait(2000)
    SendNUIMessage({type="toggleMoney",vazelina=false})
end)
RegisterKeyMapping("-MoneyNervos", "Arata bani", "keyboard", "f3")

-- Tickets
RegisterNetEvent("vD:updateTickete", function(tickets)
    SendNUIMessage({type="updateTickets", tickets=tickets})
end)
-- Tickets
RegisterNetEvent("vD:toggleHud", function()
    display = not display
    SendNUIMessage({type="toggle",d=display})
end)
-- Speedometer
local open = false
Citizen.CreateThread(function()
    while true do
        if open then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local speed = (GetEntitySpeed(vehicle))
            local speed_show = math.ceil(speed * 3.6)
            local lockStatus = GetVehicleDoorLockStatus(vehicle)
            local engine = GetIsVehicleEngineRunning(vehicle)
            local fuel = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false))

            SendNUIMessage({
                ["type"] = "update",
                ["speed"] = speed_show,
                ["speedrpm"] = speed,
                ["fuel"] = math.floor(fuel),
                ["locked"] = lockStatus ~= 1,
                ["engine"] = engine
            })
        end

        if open and not IsPedInAnyVehicle(PlayerPedId(), true) then
            open = false
            SendNUIMessage({
                ["type"] = "close"
            })
        elseif not open and IsPedInAnyVehicle(PlayerPedId(), true) then
            open = true
            SendNUIMessage({
                ["type"] = "open"
            })    
        end
        -- SendNUIMessage({type="updateViataArmura",viata=GetEntityHealth(PlayerPedId()) - 100, armour = GetPedArmour(PlayerPedId())})
        

        Citizen.Wait(120)
    end
end)
-- Speedometer