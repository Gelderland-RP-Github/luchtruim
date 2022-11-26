blip = nil
blips = {}


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsPedInAnyPlane(GetPlayerPed(-1), false)) then
            local ped = GetPlayerPed(-1)
            local x, y, z = table.unpack(GetEntityCoords(ped, false))
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(-1), false)))
            TriggerServerEvent("lwr:updateAircraftBlip", x,y,z,model,ped)
        end

        if (IsPedInAnyHeli(GetPlayerPed(-1), false)) then
            local ped = GetPlayerPed(-1)
            local x, y, z = table.unpack(GetEntityCoords(ped, false))
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(-1), false)))
            TriggerServerEvent("lwr:updateHeliBlip", x,y,z,model,ped)
        end
    end
end)

RegisterNetEvent("lwr:updatingAircraftClient", function(x,y,z,model,ped)
    Citizen.Wait(0)
    if x ~= nil then

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
end)

RegisterNetEvent("lwr:updatingHeliClient", function(x,y,z,model,ped)
    Citizen.Wait(0)
    if x ~= nil then

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
end)