-- [[ QBCore ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Variables ]] --


-- [[ Resource Metadata ]] --


-- [[ Commands ]] --
QBCore.Commands.Add(PoliceConfig.ResourceSettings['Job']['Commands']['Name'], PoliceConfig.ResourceSettings['Job']['Commands']['description'], { { name='AOP', help='LS, SS, GS, PB, SA' } }, false, function(source, args)
    local aop = string.upper(args[1])

    if aop ~= nil and aop then
        TriggerClientEvent('LENT-AICalls:Client:ChangePoliceAOP', -1, aop)
    else
        Notify('sv', 'Please specify a AOP this resource sets in!', 'error')
    end
end, PoliceConfig.ResourceSettings['Job']['Commands']['Permissions'])

-- [[ Net Events ]] --
RegisterNetEvent('LENT-AICalls:Server:CreateCrimePed', function()
    local citizenid = QBCore.Functions.GetPlayer(source).citizenid
    TriggerClientEvent('LENT-AICalls:Client:CreateCrimePed', -1, citizenid)
end)

RegisterNetEvent('LENT-AICalls:Server:RemovePoliceCallPed', function()
    local citizenid = QBCore.Functions.GetPlayer(source).citizenid
    TriggerClientEvent('LENT-AICalls:Client:RemovePoliceCallPed', -1, citizenid)
end)

-- [[ Functions ]] --


-- [[ Threads ]] --

