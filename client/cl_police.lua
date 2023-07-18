-- [[ QBCore ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Variables ]] --
local CurrentlyOnJob = false
local SetJobCoolDown = false
local PedHasBeenSpawned = false

local AreaOfRoleplay = PoliceConfig.ResourceSettings['Job']['AOP']

-- [[ Resource Metadata ]] --
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        local citizenid = QBCore.Functions.GetPlayerData().citizenid
        DeletePed(citizenid)
        RemoveBlip(LEOCallblip)
    end
end)

-- [[ Net Events ]] --
RegisterNetEvent('LENT-AICalls:Client:PoliceGenerateCallout', function()
    if CurrentlyOnJob then
        Notify('cl', 'Job has been cancelled', 'error')
        CurrentlyOnJob, SetJobCoolDown, PedHasBeenSpawned = false, false, false
        if Config.GlobalSettings['Waypoint'] == 'default' then
            SetWaypointOff()
        else
            TriggerServerEvent('LENT-AICalls:Server:RemovePoliceCallPed')
            RemoveBlip(LEOCallblip)
        end
    else
        CurrentlyOnJob = true
        Wait(500)
        GetRandomCallLocation()
    end
end)

RegisterNetEvent('LENT-AICalls:Client:ChangePoliceAOP', function(newAOP)
    AreaOfRoleplay = newAOP
    local AOPText = nil

    local PlayerData = QBCore.Functions.GetPlayerData()

    if IsAllowedLEOJob(PlayerData.job.name) then
        if newAop == 'LS' or newAop == 'ls' then
            AOPText = 'Los Santos'
        elseif newAop == 'SS' or newAop == 'ss' then
            AOPText = 'Sandy Shores'
        elseif newAop == 'GS' or newAop == 'gs' then
            AOPText = 'Grapeseed'
        elseif newAop == 'PB' or newAop == 'pb' then
            AOPText = 'Paleto Bay'
        elseif newAop == 'SA' or newAop == 'sa' then
            AOPText = 'State Wide'
        end
        Notify('cl', 'The AOP has been switched to: ' .. AOPText)
    end
end)

-- [[ Functions ]] --
function IsAllowedLEOJob(job)
    for _, v in pairs(PoliceConfig.ResourceSettings['Job']['AllowedJobs']) do
        if job == v then
            return true
        end
    end
    return false
end

function GetRandomCallLocation()
    GetPedConfig = PoliceConfig.ResourceSettings['PedLocations'][AreaOfRoleplay]
    SetPedLocation = (GetPedConfig[math.random(#GetPedConfig)])

    Wait(500)

    ChooseCrime = math.random(#PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'])

    PoliceAlert(SetPedLocation.x, SetPedLocation.y, SetPedLocation.z, PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][ChooseCrime]['DispatchCode'], PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][ChooseCrime]['Label'])

    if Config.GlobalSettings['Waypoint'] == 'default' then
        SetNewWaypoint(SetPedLocation.x, SetPedLocation.y)
    else
        LEOCallblip = AddBlipForCoord(SetPedLocation.x, SetPedLocation.y, SetPedLocation.z)

        SetBlipSprite(LEOCallblip, 58)
        SetBlipColour(LEOCallblip, 3)
        SetBlipScale(LEOCallblip, 0.8)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][ChooseCrime]['Label'])
        EndTextCommandSetBlipName(LEOCallblip)

        SetBlipRoute(LEOCallblip, true)
        SetBlipRouteColour(LEOCallblip, 0)

        LEOBlipEnabled = true
    end

    local CrimeKey = PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][ChooseCrime]['HARD_KEY']
    local CrimeCode = PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][ChooseCrime]['DispatchCode']
    local CrimeLabel = PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][ChooseCrime]['Label']

    SpawnCrime(CrimeKey)
end

function SpawnCrime(CrimeKey)
    if CrimeKey == 'GUNSHOT_REPORTED' then
        TriggerServerEvent('LENT-AICalls:Server:CreateCrimePed')
    elseif CrimeKey == 'DOMESTICATED_DISPUTE' then
        TriggerServerEvent('LENT-AICalls:Server:CreateDomesticDispute')
    elseif CrimeKey == 'MUGGING' then
        TriggerServerEvent('LENT-AICalls:Server:CreateMugging')
    else
        Notify('cl', 'You created a setting with a invalid HARD_KEY!', 'error')
    end
end

RegisterNetEvent('LENT-AICalls:Client:CreateCrimePed', function(citizenid)
    local SelectCrimePed = math.random(1, #PoliceConfig.ResourceSettings['PedSelection'])

    RequestModel(PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed])

    while not HasModelLoaded(PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed]) do
        Wait(0)
    end

    citizenid = CreatePed(0, PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed], SetPedLocation.x, SetPedLocation.y, SetPedLocation.z - 1, SetPedLocation.w, false, false)

    SetPedRelationshipGroupHash(citizenid, GetHashKey('PLAYER'))
    AddRelationshipGroup('LENTAICallsHostile')

    NetworkRegisterEntityAsNetworked(citizenid)
    NetworkID = NetworkGetNetworkIdFromEntity(citizenid)
    SetNetworkIdCanMigrate(NetworkID, true)

    GiveWeaponToPed(citizenid, 'WEAPON_PISTOLXM3', 255, false, false)

    SetNetworkIdExistsOnAllMachines(networkID, true)
    SetEntityAsMissionEntity(citizenid)
    SetPedDropsWeaponsWhenDead(citizenid, false)
    SetPedRelationshipGroupHash(citizenid, GetHashKey("LENTAICallsHostile"))
    SetEntityVisible(citizenid, true)
    SetPedRandomComponentVariation(citizenid, 0)
    SetPedRandomProps(citizenid)

    SetRelationshipBetweenGroups(0, GetHashKey("LENTAICallsHostile"), GetHashKey("LENTAICallsHostile"))
    SetRelationshipBetweenGroups(5, GetHashKey("LENTAICallsHostile"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("LENTAICallsHostile"))

    PedHasBeenSpawned = true

    if PedHasBeenSpawned then
        -- TriggerEvent('LENT-AICalls:Client:StartCleanUp')
        exports['qb-target']:AddTargetEntity(citizenid, {
            options = {
                {
                    type = 'client',
                    -- event = 'LENT-AICalls:Client:StartCleanUp',
                    label = 'Call Coroners Office...',
                    icon = 'fa-solid fa-phone',
                    canInteract = function()
                        if PedHasBeenSpawned and IsEntityDead(citizenid) then
                            return true
                        end

                        return false
                    end,
                    action = function()
                        ExecuteCommand('e phonecall')
                        QBCore.Functions.Progressbar('lentcallcoroner', 'Calling Coroners...', 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = false,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Play When Done
                            ExecuteCommand('e c')
                            PedHasSpawned = false
                            Wait(500)
                            TriggerServerEvent('LENT-AICalls:Server:RemovePoliceCallPed', citizenid)
                            RemoveBlip(LEOCallblip)
                            CurrentlyOnJob = false
                            Notify('client', 'Coroner came and picked up the body!', 'success')
                        end, function() -- Play When Cancel
                            ExecuteCommand('e c')
                            Notify('client', 'You stopped calling for coroners...', 'error')
                        end)
                    end,
                },
            },
            disance = 2.0
        })
    end
end)

RegisterNetEvent('LENT-AICalls:Client:CreateDomesticDispute', function(citizenid)
    local SelectCrimePed = math.random(1, #PoliceConfig.ResourceSettings['PedSelection'])

    RequestModel(PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed])

    while not HasModelLoaded(PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed]) do
        Wait(0)
    end

    citizenid = CreatePed(0, PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed], SetPedLocation.x, SetPedLocation.y, SetPedLocation.z - 1, SetPedLocation.w, false, false)

    SetPedRelationshipGroupHash(citizenid, GetHashKey('PLAYER'))
    AddRelationshipGroup('LENTAICallsHostile')

    NetworkRegisterEntityAsNetworked(citizenid)
    NetworkID = NetworkGetNetworkIdFromEntity(citizenid)
    SetNetworkIdCanMigrate(NetworkID, true)

    GiveWeaponToPed(citizenid, 'WEAPON_KNIFE', 255, true, true)

    SetNetworkIdExistsOnAllMachines(networkID, true)
    SetEntityAsMissionEntity(citizenid)
    SetPedDropsWeaponsWhenDead(citizenid, false)
    SetPedRelationshipGroupHash(citizenid, GetHashKey("LENTAICallsHostile"))
    SetEntityVisible(citizenid, true)
    SetPedRandomComponentVariation(citizenid, 0)
    SetPedRandomProps(citizenid)

    SetPedAlertness(citizenid, 3)
    SetPedCombatMovement(citizenid, 3)

    SetRelationshipBetweenGroups(0, GetHashKey("LENTAICallsHostile"), GetHashKey("LENTAICallsHostile"))
    SetRelationshipBetweenGroups(5, GetHashKey("LENTAICallsHostile"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("LENTAICallsHostile"))

    PedHasBeenSpawned = true

    if PedHasBeenSpawned then
        exports['qb-target']:AddTargetEntity(citizenid, {
            options = {
                {
                    type = 'client',
                    label = 'Calling for D.O.C.',
                    icon = 'fa-solid fa-phone',
                    canInteract = function()
                        if PedHasBeenSpawned and IsEntityDead(citizenid) then
                            return true
                        end

                        return false
                    end,
                    action = function()
                        ExecuteCommand('e phonecall')
                        QBCore.Functions.Progressbar('lentcalldoc', 'Calling D.O.C.', 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = false,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Play When Done
                            ExecuteCommand('e c')
                            PedHasSpawned = false
                            Wait(500)
                            TriggerServerEvent('LENT-AICalls:Server:RemovePoliceCallPed', citizenid)
                            RemoveBlip(LEOCallblip)
                            CurrentlyOnJob = false
                            Notify('client', 'D.O.C. came and picked up a suspect!', 'success')
                        end, function() -- Play When Cancel
                            ExecuteCommand('e c')
                            Notify('client', 'You stopped calling for D.O.C.', 'error')
                        end)
                    end,
                },
            },
            disance = 2.0
        })
    end
end)

RegisterNetEvent('LENT-AICalls:Client:CreateMugging', function(citizenid)
end)

RegisterNetEvent('LENT-AICalls:Client:RemovePoliceCallPed', function(citizenid)
    DeletePed(citizenid)
end)

-- [[ Threads ]] --
CreateThread(function()
    while true do
        Wait(0)
        if LEOBlipEnabled then
            SetBlipColour(LEOCallblip, 1)
            Wait(200)
            SetBlipColour(LEOCallblip, 3)
            Wait(200)
        end
    end
end)