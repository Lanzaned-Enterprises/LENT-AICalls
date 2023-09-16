PoliceConfig = {}

PoliceConfig.ResourceSettings = {
    ['Job'] = {
        ['AOP'] = 'SA', -- LS, SS, GS, PB, SA
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
    ['Duty'] = {
        ['DutyType'] = false, -- Command | false
        ['DutyCommand'] = {
            ['Name'] = "triggerpdcallout",
            ['Description'] = "Triggers a callout for Law Enforcement to see",
        },
    },
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
            [1] = vector4(1124.63, 2643.66, 38.14, 5.72),
            [2] = vector4(969.33, 2711.01, 39.48, 163.42),
            [3] = vector4(590.32, 2742.72, 42.05, 190.48),
            [4] = vector4(340.56, 2579.77, 43.53, 84.82),
            [5] = vector4(203.1, 3086.79, 42.62, 198.28),
            [6] = vector4(1394.87, 3597.93, 34.98, 185.96),
            [7] = vector4(1502.03, 3702.29, 39.06, 32.91),
            [8] = vector4(1543.81, 3785.13, 34.22, 197.46),
            [9] = vector4(1668.43, 3814.54, 34.9, 290.65),
            [10] = vector4(1756.68, 3871.46, 34.87, 323.02),
            [11] = vector4(1890.88, 3868.33, 32.53, 210.32),
            [12] = vector4(1853.43, 3758.14, 33.08, 158.76),
            [13] = vector4(2487.11, 4098.82, 38.03, 76.18),
            [14] = vector4(2168.65, 3333.38, 46.4, 352.86),
            [15] = vector4(2165.97, 3374.8, 45.25, 255.88),
            [16] = vector4(2002.11, 3052.92, 47.21, 33.68),
            [17] = vector4(1591.43, 2900.5, 57.12, 127.0),
            [18] = vector4(886.42, 2857.69, 56.53, 113.99),
            [19] = vector4(866.43, 2871.56, 57.21, 180.73),
            [20] = vector4(512.04, 3083.84, 40.42, 109.97),
        },
        ['GS'] = {
            [1] = vector4(1686.71, 4695.55, 42.8, 317.37),
            [2] = vector4(1681.19, 4838.89, 42.13, 114.88),
            [3] = vector4(2426.75, 4971.59, 45.88, 3.44),
            [4] = vector4(2461.33, 4966.41, 45.32, 221.71),
            [5] = vector4(1965.72, 4636.16, 40.81, 48.24),
            [6] = vector4(1347.78, 4362.32, 44.26, 245.05),
            [7] = vector4(1668.63, 4764.03, 41.92, 340.6),
            [8] = vector4(1658.48, 4850.25, 41.97, 267.93),
            [9] = vector4(1945.04, 5169.03, 46.72, 105.56),
            [10] = vector4(2563.94, 5081.77, 44.51, 313.98),
        },
        ['PB'] = {
            [1] = vector4(-249.87, 6162.11, 31.51, 296.51),
            [2] = vector4(-271.34, 6280.35, 31.47, 294.12),
            [3] = vector4(-210.35, 6437.06, 31.4, 262.06),
            [4] = vector4(-304.5, 6330.04, 32.49, 39.06),
            [5] = vector4(-390.45, 6301.2, 29.51, 189.36),
            [6] = vector4(-378.86, 6185.75, 31.49, 229.52),
            [7] = vector4(-146.76, 6437.95, 31.44, 310.05),
            [8] = vector4(8.86, 6526.13, 31.38, 14.75),
            [9] = vector4(-90.15, 6356.19, 35.5, 246.42),
            [10] = vector4(-266.15, 6083.71, 31.4, 130.31),
            [11] = vector4(-697.1, 5802.68, 17.33, 30.47),
            [12] = vector4(-702.82, 5778.4, 17.33, 17.03),
            [13] = vector4(-760.54, 5563.32, 36.71, 180.71),
            [14] = vector4(-511.09, 5302.94, 80.24, 178.03),
            [15] = vector4(25.01, 6657.09, 31.58, 191.0),
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
            -- [0] = { ['HARD_KEY'] = 'DO_NOT_CHANGE_THESE',    ['DispatchCode'] = '10-00',     ['Label'] = 'Call Description',     },
            [2] = { ['HARD_KEY'] = 'DOMESTICATED_DISPUTE',      ['DispatchCode'] = '10-25',         ['Label'] = 'Domestic Dispute',     },
            -- [[ THE BELOW ARE NOT INTERGRATED!!! DO NOT!!! ENABLE!!! ]] --
            -- [1] = { ['HARD_KEY'] = 'GUNSHOT_REPORTED',          ['DispatchCode'] = '10-13',         ['Label'] = 'Gunshots Reported',    },
            -- [3] = { ['HARD_KEY'] = 'MUGGING',                   ['DispatchCode'] = '10-17', ['Label'] = 'Suspicious Person',    },
            -- [4] = { ['HARD_KEY'] = 'SIGNAL100',                 ['DispatchCode'] = 'SIGNAL-100',    ['Label'] = 'Officer Down'          },
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
                sprite = 0,
                scale = 0,
                colour = 0,
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