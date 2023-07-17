PoliceConfig = {}

PoliceConfig.ResourceSettings = {
    ['Job'] = {
        ['AOP'] = 'LS', -- LS, SS, GS, PB, SA
        -- LS: Los Santos | SS: Sandy Shores | GS: Grapeseed | PB: Paleto Bay | SA: San Andreas
        ['Commands'] = {
            ['Name'] = 'pdcalls',
            ['description'] = 'Change the AOP in which AI Calls generate',
            ['Permissions'] = 'directors',
        },
        ['AllowedJobs'] = {
            ['fib'] = true,
            ['iaa'] = true,
            ['upd'] = true,
            ['sasp'] = true,
            ['police'] = true,
            ['bcso'] = true,
            ['doc'] = true,
        },
    },
    ['Payment'] = math.random(150, 200),
    ['PayCash'] = false, -- true = cash | false = bank
    ['PedLocations'] = {
        ['LS'] = {
            [1] = vector4(-656.8, -677.85, 31.49, 305.78),
        },
        ['SS'] = {
            -- Coming Soon!
        },
        ['GS'] = {
            -- Coming Soon!
        },
        ['PB'] = {
            -- Coming Soon!
        },
        ['SA'] = {
            -- Coming Soon!
        },
    },
    ['PedSelection'] = {
        [1] = `a_f_m_beach_01`,
        [2] = `a_f_m_bevhills_01`,
        [3] = `a_f_m_bevhills_02`,
        [4] = `a_f_m_bodybuild_01`,
        [5] = `a_f_m_business_02`,
        [6] = `a_f_m_downtown_01`,
        [7] = `a_m_m_afriamer_01`,
        [8] = `a_m_m_beach_01`,
        [9] = `a_m_m_beach_02`,
        [10] = `a_m_m_bevhills_01`,
        [11] = `g_m_importexport_01`,
        [12] = `g_m_m_mexboss_01`,
        [13] = `g_m_y_salvagoon_02`,
        [14] = `mp_f_cardesign_01`,
        [15] = `a_m_y_hiker_01`,
        [16] = `a_m_m_hasjew_01`,
        [17] = `a_m_m_fatlatin_01`,
        [18] = `a_m_y_musclbeac_01`,
        [19] = `a_m_y_vinewood_01`,
        [20] = `cs_amandatownley`,
    },
    ['Crimes'] = {
        ['CrimeTypes'] = {
            -- [0] = { ['HARD_KEY'] = 'DO_NOT_CHANGE_THESE',    ['DispatchCode'] = '10-00', ['Label'] = 'Call Description',     },
            [1] = { ['HARD_KEY'] = 'GUNSHOT_REPORTED',          ['DispatchCode'] = '10-13', ['Label'] = 'Gunshots Reported',    },
            -- [[ THE BELOW ARE NOT INTERGRATED!!! DO NOT!!! ENABLE!!! ]] --
            -- [2] = { ['HARD_KEY'] = 'DOMESTICATED_DISPUTE',      ['DispatchCode'] = '10-25', ['Label'] = 'Domestic Dispute',     },
            -- [3] = { ['HARD_KEY'] = 'MUGGING',                   ['DispatchCode'] = '10-17', ['Label'] = 'Suspicious Person',    },
        },
    },
}

function PoliceAlert(x, y, z, DispatchCode, Label)
    if Config.GlobalSettings['Dispatch'] == 'ps' then
        exports["ps-dispatch"]:CustomAlert({
            coords = vector3(x, y, z),
            message = Label,
            dispatchCode = DispatchCode,
            description = Label,
            radius = 0,
            sprite = 0,
            color = 0,
            scale = 0.0,
            length = 3,
            job = { 'fib', 'iaa', 'upd', 'sasp', 'police', 'bcso', 'doc' }
        })
    elseif Config.GlobalSettings['Dispatch'] == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = { 'fib', 'iaa', 'upd', 'sasp', 'police', 'bcso', 'doc' },
            coords = vector3(x, y, z),
            title = DispatchCode,
            message = Label,
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 280,
                scale = 1.0,
                colour = 23,
                flashes = false,
                text = Label,
                time = 5,
                radius = 0,
            }
        })
    elseif Config.GlobalSettings['Dispatch'] == 'custom' then
        -- Create your event here!
    end
end