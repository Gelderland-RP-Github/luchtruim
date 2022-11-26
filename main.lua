function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local blacklisted = Set {"LAZER", "HYDRA", "STRIKEFORCE", "MILJET", "AKULA", "ANNIHILATOR", "BUZZARD", "HUNTER", "POLMAV", "SAVAGE", "VALKYRIE", "VALKYRIE2", "AVENGER", "AVENGER2", "BESRA", "BOMBUSHKA", "MOLOTOK", "NOKOTA", "MOGUL", "PYRO", "STARLING", "TITAN", "TULA", "VOLATOL"}

blip = nil
blips = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if (IsPedInAnyPlane(GetPlayerPed(-1), false)) and ((GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(-1), -1))) == 0) then

            local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(-1), false)))
            
            if blacklisted[model] then
            else
                local ped = GetPlayerPed(-1)
                local x, y, z = table.unpack(GetEntityCoords(ped, false))
                TriggerServerEvent("lwr:updateAircraftBlip", x,y,z,model,ped)
            end


        elseif (IsPedInAnyHeli(GetPlayerPed(-1), false)) and ((GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(-1), -1))) == 0) then

            local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(-1), false)))
            
            if blacklisted[model] then
            else
                local ped = GetPlayerPed(-1)
                local x, y, z = table.unpack(GetEntityCoords(ped, false))
                TriggerServerEvent("lwr:updateHeliBlip", x,y,z,model,ped)
            end

        else
            local ped = GetPlayerPed(-1)
            TriggerServerEvent("lwr:removeBlip", ped)
        end

    end
end)

RegisterNetEvent("lwr:updatingAircraftClient", function(x,y,z,model,ped)
    Citizen.Wait(0)
    if x ~= nil then

        if GetPlayerPed(-1) == ped then
        else
        local modelText = GetLabelText(model)
        local blipname = "aircraft" .. ped

        RemoveBlip(blips[ped])

        blip = AddBlipForCoord(x, y, z)
        SetBlipScale(blip, 1.0)
        SetBlipSprite(blip, 307)
        SetBlipAlpha(blip, 255)
        SetBlipColour(blip, 11)
        AddTextEntry(blipname, modelText)
        BeginTextCommandSetBlipName(blipname)
        EndTextCommandSetBlipName(blip)
        SetBlipCategory(blip, 7)

        blips[ped] = blip
        end
    end
end)

RegisterNetEvent("lwr:updatingHeliClient", function(x,y,z,model,ped)
    Citizen.Wait(0)
    if x ~= nil then

        if GetPlayerPed(-1) == ped then
        else
        local modelText = GetLabelText(model)
        local blipname = "heli" .. ped

        RemoveBlip(blips[ped])

        blip = AddBlipForCoord(x, y, z)
        SetBlipScale(blip, 1.0)
        SetBlipSprite(blip, 43)
        SetBlipAlpha(blip, 255)
        SetBlipColour(blip, 11)
        AddTextEntry(blipname, modelText)
        BeginTextCommandSetBlipName(blipname)
        EndTextCommandSetBlipName(blip)
        SetBlipCategory(blip, 7)

        blips[ped] = blip
        end
    end
end)

RegisterNetEvent("lwr:removingBlips", function(ped)
    Citizen.Wait(0)
    RemoveBlip(blips[ped])
end)