-- [[ QBCore ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Variables ]] --

-- [[ Resource Metadata ]] --

-- [[ Net Events ]] --
RegisterNetEvent('LENT-AICalls:Server:GiveCash', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local paycheck = Config.ResourceSettings['Payment']

    if Config.ResourceSettings['PayCash'] == true then
        if Player.Functions.AddMoney('cash', paycheck) then
            Notify('server', 'You received $' ..paycheck.. ' for helping. Wait for your next call!', 'success', 7500)
        end
    else
        if Player.Functions.AddMoney('bank', paycheck) then
            if Config.GlobalSettings['RenewedBanking'] then
                local cid = Player.PlayerData.citizenid
                local title = 'Hospital Salary'
                local name = ('%s %s'):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname)
                local txt = 'Received Commission for helping local'
                local issuer = 'Alexander Fenton @ Medical Response San Andreas'
                local reciver = name
                local type = 'deposit'
                exports['Renewed-Banking']:handleTransaction(cid, title, paycheck, txt, issuer, reciver, type)
            end

            Notify('server', 'You received $' ..paycheck.. ' for helping. Wait for your next call!', 'success', 7500)
        end
    end

end)

RegisterNetEvent('LENT-AICalls:Server:RemoveItem', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    Player.Functions.RemoveItem(Config.ResourceSettings['ReviveItem'], 1)
end)

QBCore.Commands.Add(Config.ResourceSettings['Job']['Commands']['Name'], Config.ResourceSettings['Job']['Commands']['description'], { { name='AOP', help='LS, SS, GS, PB, SA' } }, false, function(source, args)
    local aop = string.upper(args[1])

    if aop ~= nil and aop then
        TriggerClientEvent('LENT-AICalls:Client:ChangeAOP', -1, aop)
    else
        Notify('sv', 'Please specify a AOP this resource sets in!', 'error')
    end
end, Config.ResourceSettings['Job']['Commands']['Permissions'])

-- [[ Functions ]] --

-- [[ Threads ]] --