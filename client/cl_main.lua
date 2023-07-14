-- [[ QBCore ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Variables ]] --
local CurrentlyOnJob = false
local SetJobCooldown = false
local PedHasSpawned = false
local Ped = nil

local AOP = Config.ResourceSettings['AOP']

-- [[ Resource Metadata ]] --
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        RemoveBlip(WaypointBlip)
    end
end)

-- [[ Net Events ]] --
RegisterNetEvent('LENT-AICalls:Client:StartMedicMission', function()
    if SetJobCooldown == false then
        if CurrentlyOnJob == false then
            CurrentlyOnJob = true
            Wait(500)
            GetRandomLocation()
        else
            Notify('client', 'Job was cancelled!', 'error')
            CurrentlyOnJob, SetJobCooldown, PedHasSpawned = false, false, false
            if Config.GlobalSettings['Waypoint'] == 'default' then
                SetWaypointOff()
            else
                RemoveBlip(WaypointBlip)
            end
            DeletePed(Ped)
        end
    end
end)

RegisterNetEvent('LENT-AICalls:Client:ReviveSelectedPed', function()
    if QBCore.Functions.HasItem(Config.ResourceSettings['ReviveItem']) then
        ExecuteCommand('e medic')
        QBCore.Functions.Progressbar('reviving_ped', 'Checking for Injuries....', 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Play When Done
            ExecuteCommand('e c')
            PedHasSpawned = false
            Wait(500)
            TriggerServerEvent('LENT-AICalls:Server:RemoveItem')
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.ResourceSettings['ReviveItem']], "remove")
            ClearPedTasks(Ped)
            SetPedMovementClipset(Ped, "move_m@injured", 1)
            TaskGoStraightToCoord(Ped, 0, 0, 0, 5, 10000, 0)
            TriggerServerEvent('LENT-AICalls:Server:GiveCash')
            RemoveBlip(WaypointBlip)
        end, function() -- Play When Cancel
            ExecuteCommand('e c')
        end)
    else
        Notify('client', 'You don\'t have ' .. Config.ResourceSettings['ReviveItem'] .. ' on you!', 'error')
    end
end)

RegisterNetEvent('LENT-AICalls:Client:ChangeAOP', function(newAop)
    AOP = newAop
    local AOPText = nil

    if QBCore.Functions.GetPlayerData().job.name == Config.ResourceSettings['Job']['JobName'] then
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
-- function LoadAnimDict(dict)
--     while (not HasAnimDictLoaded(dict)) do
--         RequestAnimDict(dict)
--         Wait(5)
--     end
-- end

function GetRandomLocation()
    PedLocation = Config.ResourceSettings['PedLocations'][math.random(1, 55)]
    Wait(500)
    MedicAlert(PedLocation.x, PedLocation.y, PedLocation.z)
    if Config.GlobalSettings['Waypoint'] == 'default' then
        SetWaypointOff()
    else
        WaypointBlip = AddBlipForCoord(PedLocation.x, PedLocation.y, PedLocation.z)

        SetBlipSprite(WaypointBlip, 621)
        SetBlipColour(WaypointBlip, 23)
        SetBlipScale(WaypointBlip, 0.8)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Downed Local")
        EndTextCommandSetBlipName(WaypointBlip)

        SetBlipRoute(WaypointBlip, true)
        SetBlipRouteColour(WaypointBlip, 23)
    end

    SpawnDowned()
end

function SpawnDowned()
    local selectedPed = math.random(1, #Config.ResourceSettings['PedSelection'])

    RequestModel(Config.ResourceSettings['PedSelection'][selectedPed])

    while not HasModelLoaded(Config.ResourceSettings['PedSelection'][selectedPed]) do
        Wait(0)
    end

    Ped = CreatePed(0, Config.ResourceSettings['PedSelection'][selectedPed], PedLocation.x, PedLocation.y, PedLocation.z, false, false)

    PedHasSpawned = true

    exports['qb-target']:AddTargetEntity(Ped, {
        options = {
            {
                type = 'client',
                event = 'LENT-AICalls:Client:ReviveSelectedPed',
                label = 'Give Meddical Attention',
                icon = 'fa-solid fa-syringe',
                canInteract = function()
                    if PedHasSpawned == true then return true end
                    return false
                end,
            },
        },
        disance = 2.0
    })

    -- while PedHasSpawned == true do
    --     Wait(0)
    --     LoadAnimDict(missarmenian2)
    --     TaskPlayAnim(Ped, 'missarmenian2', 'corpse_search_exit_ped', 8.0, 8.0, -1, 1, 0, 0, 0, 0)
    -- end
    -- [[ Below is sneaky work around.... ]] --

    SetPedToRagdoll(Ped, 1000, 1000, 0, 0, 0, 0)
end

-- [[ Threads ]] --