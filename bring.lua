RegisterNetEvent('QBCore:Command:BringPlayer')
AddEventHandler('QBCore:Command:BringPlayer', function(x, y, z)
    SetEntityCoords(GetPlayerPed(-1), x, y, z, false, false, false, true)
end)
