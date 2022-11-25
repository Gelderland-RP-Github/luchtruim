RegisterServerEvent("lwr:updateAircraftBlip", function(x,y,z,model,ped)
    TriggerClientEvent("lwr:updatingAircraftClient", -1, x,y,z,model,ped)
end)

RegisterServerEvent("lwr:updateHeliBlip", function(x,y,z,model,ped)
    TriggerClientEvent("lwr:updatingHeliClient", -1, x,y,z,model,ped)
end)