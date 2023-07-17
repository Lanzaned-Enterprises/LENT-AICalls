Config = {}

Config.GlobalSettings = {
    ['Phone'] = 'qb', -- qb, gks, qs, npwd
    ['Notify'] = 'ps', -- qb, ps, custom
    ['Dispatch'] = 'ps', -- ps, cd, custom 
    ['Waypoint'] = 'custom', -- default, custom
    ['RenewedBanking'] = true, -- false, true
}

function Notify(clsv, text, type, time)
    if clsv == 'cl' or clsv == 'client' then
        if Config.GlobalSettings['Notify'] == 'qb' then
            QBCore.Functions.Notify(text, type, time)
        elseif Config.GlobalSettings['Notify'] == 'ps' then
            TriggerEvent("ps-ui:client:notify", text, type)
        elseif Config.GlobalSettings['Notify'] == 'custom' then
            -- Insert Custom Notify
        end
    elseif clsv == 'sv' or clsv == 'server' then
        local src = source
        if Config.GlobalSettings['Notify'] == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, text, type, time)
        elseif Config.GlobalSettings['Notify'] == 'ps' then
            TriggerClientEvent("ps-ui:client:notify", src, text, type)
        elseif Config.GlobalSettings['Notify'] == 'custom' then
            -- Insert Custom Notify
        end
    else
        print('Invalid CLSV parsed in function notify!')
    end
end