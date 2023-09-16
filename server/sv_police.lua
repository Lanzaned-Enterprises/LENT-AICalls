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

if PoliceConfig.ResourceSettings['Duty']['DutyType'] == "Command" or PoliceConfig.ResourceSettings['Duty']['DutyType'] == "command" then
    QBCore.Commands.Add(PoliceConfig.ResourceSettings['Duty']['DutyCommand']['Name'], PoliceConfig.ResourceSettings['Duty']['DutyCommand']['Description'], {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        if IsPlayerJobLEOJob(Player.PlayerData.job.name) then
            TriggerClientEvent('LENT-AICalls:Client:PoliceGenerateCallout', src)
        end
    end)
end

-- [[ Net Events ]] --
RegisterNetEvent('LENT-AICalls:Server:RemovePoliceCallPed', function(citizenid)
    TriggerClientEvent('LENT-AICalls:Client:RemovePoliceCallPed', -1, citizenid)
end)

RegisterNetEvent('LENT-AICalls:Server:CreateCrimePed', function()
    local citizenid = QBCore.Functions.GetPlayer(source).citizenid
    TriggerClientEvent('LENT-AICalls:Client:CreateCrimePed', -1, citizenid)
end)

RegisterNetEvent('LENT-AICalls:Server:CreateDomesticDispute', function()
    local citizenid = QBCore.Functions.GetPlayer(source).citizenid
    TriggerClientEvent('LENT-AICalls:Client:CreateDomesticDispute', -1, citizenid)
end)

RegisterNetEvent('LENT-AICalls:Server:CreateMugging', function()
    local citizenid = QBCore.Functions.GetPlayer(source).citizenid
    TriggerClientEvent('LENT-AICalls:Client:CreateMugging', -1, citizenid)
end)

RegisterNetEvent('LENT-AICalls:Server:CreateOfficerDown', function()
    local citizenid = QBCore.Functions.GetPlayer(source).citizenid
    TriggerClientEvent('LENT-AICalls:Client:CreateOfficerDown', -1, citizenid)
end)

RegisterNetEvent('LENT-AICalls:Server:SyncPdCall', function(coords, id, label)
    TriggerClientEvent('LENT-AICalls:Client:SyncPdCall', -1, coords, id, label)
end)

-- [[ Functions ]] --
function IsPlayerJobLEOJob(job)
    for _, v in pairs(PoliceConfig.ResourceSettings['Job']['AllowedJobs']) do
        if job == v then
            return true
        end
    end
    return false
end

-- [[ Threads ]] --

