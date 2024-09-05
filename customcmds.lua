local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('duty', Lang:t('command.duty.help'), {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local job = Player.PlayerData.job
        if job.onduty then
            -- Toggle off duty
            Player.Functions.SetJobDuty(false)
            TriggerClientEvent('QBCore:Notify', source, Lang:t('command.duty.off'))
        else
            -- Toggle on duty
            Player.Functions.SetJobDuty(true)
            TriggerClientEvent('QBCore:Notify', source, Lang:t('command.duty.on'))
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.plyrnotfound'), 'error')
    end
end)

QBCore.Commands.Add('tpmzb', Lang:t('command.tpmzb.help'), {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local targetCoords = vector3(-73.9, -819.09, 326.18)
        TriggerClientEvent('QBCore:Command:TeleportToCoords', source, targetCoords.x, targetCoords.y, targetCoords.z)
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.tpmzb.success'), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.plyrnotfound'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('tpmc', Lang:t('command.tpmc.help'), {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local targetCoords = vector3(501.64, 5604.77, 797.91)
        TriggerClientEvent('QBCore:Command:TeleportToCoords', source, targetCoords.x, targetCoords.y, targetCoords.z)
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.tpmc.success'), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.plyrnotfound'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('tptraining', Lang:t('command.tptraining.help'), {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local targetCoords = vector3(-2017.09, 3158.75, 32.81)
        TriggerClientEvent('QBCore:Command:TeleportToCoords', source, targetCoords.x, targetCoords.y, targetCoords.z)
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.tptraining.success'), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.plyrnotfound'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('bring', Lang:t('command.bring.help'), {{name='id', help=Lang:t('command.arg_help')}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local targetId = tonumber(args[1])
        if targetId then
            if targetId == source then
                -- Notify the player that they cannot bring themselves
                TriggerClientEvent('QBCore:Notify', source, Lang:t('command.own_id'), 'error')
                return
            end

            local TargetPlayer = QBCore.Functions.GetPlayer(targetId)
            if TargetPlayer then
                local coords = GetEntityCoords(GetPlayerPed(source))
                
                -- Generate a random offset near the admin's location
                local offsetX = math.random(-1, -1)

                TriggerClientEvent('QBCore:Command:BringPlayer', targetId, coords.x + offsetX, coords.y, coords.z)
                TriggerClientEvent('QBCore:Notify', source, Lang:t('command.bring.success'), 'success')
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t('command.plyrnotfound'), 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('command.invalid_id'), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.invalid_id'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('reviveall', Lang:t('command.reviveall.help'), {}, false, function(source)
    -- Trigger the revive event for all players on the server
    TriggerClientEvent('hospital:client:Revive', -1)

    -- Notify the admin that the command has been executed
    TriggerClientEvent('QBCore:Notify', source, Lang:t('command.reviveall.success'), 'success')
end, 'admin')

QBCore.Commands.Add('defaultinv', Lang:t('command.defaultinv.help'), {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        -- Define the items to give
        local items = {
            { name = 'phone', amount = 1 },
            { name = 'weapon_combatpistol', amount = 1 },
            { name = 'pistol_ammo', amount = 10 },
            { name = 'kurkakola', amount = 10 },
            { name = 'tosti', amount = 10 },
        }

        -- Give the items to the player
        for _, item in pairs(items) do
            Player.Functions.AddItem(item.name, item.amount)
        end

        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.defaultinv.success'), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('command.plyrnotfound'), 'error')
    end
end, 'admin')
