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
            [2] = vector4(-568.86, -1044.47, 22.18, 9.5),
            [3] = vector4(-823.22, -1222.76, 7.37, 103.27),
            [4] = vector4(-1086.43, -1041.1, 2.12, 233.95),
            [5] = vector4(-1363.02, -578.23, 29.73, 123.21),
            [6] = vector4(-1664.85, -545.8, 34.58, 56.51),
            [7] = vector4(-1777.63, -427.86, 41.45, 196.65),
            [8] = vector4(-1593.45, -278.52, 52.66, 133.89),
            [9] = vector4(-929.15, -8.67, 43.59, 28.47),
            [10] = vector4(-432.15, 257.05, 83.0, 316.72),
            [11] = vector4(-79.15, 240.75, 101.11, 319.17),
            [12] = vector4(150.68, 235.88, 106.83, 235.62),
            [13] = vector4(274.04, 188.89, 104.67, 258.93),
            [14] = vector4(237.1, -35.14, 69.71, 69.24),
            [15] = vector4(180.56, -152.26, 56.54, 239.4),
            [16] = vector4(999.61, -444.04, 63.97, 318.62),
            [17] = vector4(1149.63, -429.45, 67.02, 18.32),
            [18] = vector4(1157.83, -596.0, 63.57, 211.95),
            [19] = vector4(987.12, -704.02, 57.46, 235.69),
            [20] = vector4(975.24, -1481.78, 31.22, 335.52),
            [21] = vector4(773.33, -1757.32, 29.5, 233.06),
            [22] = vector4(404.61, -1922.97, 24.76, 60.46),
            [23] = vector4(175.08, -2029.44, 18.33, 82.66),
            [24] = vector4(93.66, -1849.96, 24.87, 130.45),
            [25] = vector4(-59.43, -1757.55, 29.11, 64.08),
            [26] = vector4(-132.59, -1554.06, 34.21, 328.41),
            [27] = vector4(-13.07, -1394.87, 29.38, 6.91),
            [28] = vector4(77.26, -1114.08, 29.29, 5.35),
            [29] = vector4(184.54, -847.6, 31.05, 329.63),
            [30] = vector4(379.78, -658.79, 29.2, 164.06),
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
            [2] = { ['HARD_KEY'] = 'DOMESTICATED_DISPUTE',      ['DispatchCode'] = '10-25', ['Label'] = 'Domestic Dispute',     },
            -- [[ THE BELOW ARE NOT INTERGRATED!!! DO NOT!!! ENABLE!!! ]] --
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