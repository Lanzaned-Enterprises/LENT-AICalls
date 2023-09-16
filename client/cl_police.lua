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

    if IsPlayerLaw(PlayerData.job.name) then
        if newAOP == 'LS' or newAOP == 'ls' then
            AOPText = 'Los Santos'
        elseif newAOP == 'SS' or newAOP == 'ss' then
            AOPText = 'Sandy Shores'
        elseif newAOP == 'GS' or newAOP == 'gs' then
            AOPText = 'Grapeseed'
        elseif newAOP == 'PB' or newAOP == 'pb' then
            AOPText = 'Paleto Bay'
        elseif newAOP == 'SA' or newAOP == 'sa' then
            AOPText = 'State Wide'
        end
        Notify('cl', 'The AOP has been switched to: ' .. AOPText)
    end
end)

-- [[ Functions ]] --
function IsHostileByDefault()
    local hostile = math.random(1, 100)
    if hostile <= 50 then
        return true
    elseif hostile >= 51 then
        return false
    end
    -- If the number is between 1 and 50 or 50 then the AI WILL be hostile
    -- If the number is between 51 and 100 then the AI will NOT be hostile
    
    return false
end

function IsPlayerLaw(job)
    for k, _ in pairs(PoliceConfig.ResourceSettings['Job']['AllowedJobs']) do
        if job == k then
            return true
        end
    end

    return fals
end

function GetRandomCallLocation()
    if AreaOfRoleplay == "SA" then
        local field = math.random(1, 4)
        if field == 1 then
            SetLosSantosLocation = PoliceConfig.ResourceSettings['PedLocations']['LS']
            SetPedLocation = (SetLosSantosLocation[math.random(#SetLosSantosLocation)])
        elseif field == 2 then
            SetBlaineCountyLocation = PoliceConfig.ResourceSettings['PedLocations']['SS']
            SetPedLocation = (SetBlaineCountyLocation[math.random(#SetBlaineCountyLocation)])
        elseif field == 3 then
            SetGrapseedLocation = PoliceConfig.ResourceSettings['PedLocations']['GS']
            SetPedLocation = (SetGrapseedLocation[math.random(#SetGrapseedLocation)])
        elseif field == 4 then
            SetPaletoBayLocation = PoliceConfig.ResourceSettings['PedLocations']['PB']
            SetPedLocation = (SetPaletoBayLocation[math.random(#SetPaletoBayLocation)])
        end
    else
        GetPedConfig = PoliceConfig.ResourceSettings['PedLocations'][AreaOfRoleplay]
        SetPedLocation = (GetPedConfig[math.random(#GetPedConfig)])
    end

    Wait(500)

    -- ChooseCrime = math.random(#PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'])
    ChooseCrime = PoliceConfig.ResourceSettings['Crimes']['CrimeTypes'][2]

    TriggerServerEvent('LENT-AICalls:Server:SyncPdCall', SetPedLocation, ChooseCrime['DispatchCode'], ChooseCrime['Label'])
    -- PoliceAlert(SetPedLocation.x, SetPedLocation.y, SetPedLocation.z, ChooseCrime['DispatchCode'], ChooseCrime['Label'])

    if Config.GlobalSettings['Waypoint'] == 'default' then
        SetNewWaypoint(SetPedLocation.x, SetPedLocation.y)
    else
        LEOCallblip = AddBlipForCoord(SetPedLocation.x, SetPedLocation.y, SetPedLocation.z)

        SetBlipSprite(LEOCallblip, 58)
        SetBlipColour(LEOCallblip, 3)
        SetBlipScale(LEOCallblip, 0.8)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ChooseCrime['Label'])
        EndTextCommandSetBlipName(LEOCallblip)

        SetBlipRoute(LEOCallblip, true)
        SetBlipRouteColour(LEOCallblip, 0)

        LEOBlipEnabled = true
    end

    local CrimeKey = ChooseCrime['HARD_KEY']
    local CrimeCode = ChooseCrime['DispatchCode']
    local CrimeLabel = ChooseCrime['Label']

    SpawnCrime(CrimeKey, CrimeCode, CrimeLabel)
end

function SpawnCrime(CrimeKey, CrimeCode, CrimeLabel)
    if CrimeKey == 'GUNSHOT_REPORTED' then
        TriggerServerEvent('LENT-AICalls:Server:CreateCrimePed')
    elseif CrimeKey == 'DOMESTICATED_DISPUTE' then
        TriggerServerEvent('LENT-AICalls:Server:CreateDomesticDispute')
    elseif CrimeKey == 'MUGGING' then
        TriggerServerEvent('LENT-AICalls:Server:CreateMugging')
    elseif CrimeKey == 'SIGNAL100' then
        TriggerServerEvent('LENT-AICalls:Server:CreateOfficerDown')
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

    SetPedAlertness(citizenid, 3)
    SetPedCombatMovement(citizenid, 3)
    SetPedCombatRange(citizenid, 2)
    SetPedCombatAbility(citizenid, 2)
    SetPedCombatAttributes(citizenid, 46, true)

    TaskCombatPed(citizenid, player, 0, 16)

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
    local player = PlayerPedId()
    local SelectCrimePed = math.random(1, #PoliceConfig.ResourceSettings['PedSelection'])

    RequestModel(PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed])

    while not HasModelLoaded(PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed]) do
        Wait(0)
    end

    citizenid = CreatePed(0, PoliceConfig.ResourceSettings['PedSelection'][SelectCrimePed], SetPedLocation.x, SetPedLocation.y, SetPedLocation.z - 1, SetPedLocation.w, false, false)

    NetworkRegisterEntityAsNetworked(citizenid)
    NetworkID = NetworkGetNetworkIdFromEntity(citizenid)
    SetNetworkIdCanMigrate(NetworkID, true)

    SetNetworkIdExistsOnAllMachines(networkID, true)
    SetEntityAsMissionEntity(citizenid)
    SetPedDropsWeaponsWhenDead(citizenid, false)
    SetEntityVisible(citizenid, true)
    SetPedRandomComponentVariation(citizenid, 0)
    SetPedRandomProps(citizenid)

    FreezeEntityPosition(citizenid, true)

    if IsHostileByDefault() then
        AddRelationshipGroup('LENTAICallsHostile')
        SetPedRelationshipGroupHash(citizenid, GetHashKey('PLAYER'))

        SetPedRelationshipGroupHash(citizenid, GetHashKey("LENTAICallsHostile"))

        FreezeEntityPosition(citizenid, false)

        GiveWeaponToPed(citizenid, 'WEAPON_KNIFE', 255, true, true)

        SetPedAlertness(citizenid, 3)
        SetPedCombatMovement(citizenid, 3)
        SetPedCombatRange(citizenid, 2)
        SetPedCombatAbility(citizenid, 2)
        SetPedCombatAttributes(citizenid, 46, true)

        TaskCombatPed(citizenid, player, 0, 16)
    end

    SetRelationshipBetweenGroups(0, GetHashKey("LENTAICallsHostile"), GetHashKey("LENTAICallsHostile"))
    SetRelationshipBetweenGroups(5, GetHashKey("LENTAICallsHostile"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("LENTAICallsHostile"))

    PedHasBeenSpawned = true

    if PedHasBeenSpawned then
        exports['qb-target']:AddTargetEntity(citizenid, {
            options = {
                {
                    type = 'client',
                    label = 'Talking to Person...',
                    icon = 'fa-solid fa-phone',
                    canInteract = function()
                        if PedHasBeenSpawned and not IsEntityDead(citizenid) then
                            return true
                        end

                        return false
                    end,
                    action = function()
                        ExecuteCommand('e argue4')
                        QBCore.Functions.Progressbar('lentdocargue', 'Asking person to end peacefully...', math.random(5000, 7500), false, true, { -- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Play When Done
                            local argueSuccess = math.random(1, 2)
                            if argueSuccess == 1 then
                                ExecuteCommand('e c')
                                PedHasSpawned = false
                                Wait(500)
                                TriggerServerEvent('LENT-AICalls:Server:RemovePoliceCallPed', citizenid)
                                RemoveBlip(LEOCallblip)
                                CurrentlyOnJob = false
                                Notify('client', 'D.O.C. came and picked up a suspect!', 'success')
                            elseif argueSuccess == 2 then
                                ExecuteCommand('e c')
                                Wait(200)

                                FreezeEntityPosition(citizenid, false)

                                GiveWeaponToPed(citizenid, 'WEAPON_KNIFE', 255, true, true)

                                SetPedAlertness(citizenid, 3)
                                SetPedCombatMovement(citizenid, 3)
                                SetPedCombatRange(citizenid, 2)
                                SetPedCombatAbility(citizenid, 2)
                                SetPedCombatAttributes(citizenid, 46, true)

                                TaskCombatPed(citizenid, player, 0, 16)
                            end
                        end, function() -- Play When Cancel
                            ExecuteCommand('e c')
                            Wait(200)

                            FreezeEntityPosition(citizenid, false)

                            GiveWeaponToPed(citizenid, 'WEAPON_KNIFE', 255, true, true)

                            SetPedAlertness(citizenid, 3)
                            SetPedCombatMovement(citizenid, 3)
                            SetPedCombatRange(citizenid, 2)
                            SetPedCombatAbility(citizenid, 2)
                            SetPedCombatAttributes(citizenid, 46, true)

                            TaskCombatPed(citizenid, player, 0, 16)
                        end)
                    end,
                },
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

RegisterNetEvent('LENT-AICalls:Client:CreateOfficerDown', function(citizenid)

end)

RegisterNetEvent('LENT-AICalls:Client:RemovePoliceCallPed', function(citizenid)
    DeletePed(citizenid)
end)

RegisterNetEvent('LENT-AICalls:Client:SyncPdCall', function(coords, id, label)
    PoliceAlert(coords.x, coords.y, coords.z, id, label)
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