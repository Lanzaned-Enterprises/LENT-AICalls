Config = {}

Config.GlobalSettings = {
    ['Phone'] = 'qb', -- qb, gks, qs, npwd
    ['Notify'] = 'ps', -- qb, ps, custom
    ['Dispatch'] = 'ps', -- ps, cd, custom 
    ['Waypoint'] = 'custom', -- default, custom
    ['RenewedBanking'] = true, -- false, true
}

Config.ResourceSettings = {
    ['Job'] = {
        ['JobName'] = 'ambulance',
        ['AOP'] = 'LS', -- LS, SS, GS, PB, SA
        -- LS: Los Santos | SS: Sandy Shores | GS: Grapeseed | PB: Paleto Bay | SA: San Andreas
        ['Commands'] = {
            ['Name'] = 'aicalls',
            ['description'] = 'Change the AOP in which AI Calls generate',
            ['Permissions'] = 'directors',
        },
    },
    ['ReviveItem'] = 'firstaid', -- Should be in Items.lua
    ['Payment'] = math.random(75, 150),
    ['PayCash'] = false, -- true = cash / false = bank
    ['PedLocations'] = {
        ['LS'] = {
            [1] = vector4(2013.97, 3782.31, 32.18, 287.11),
            [2] = vector4(1716.1, 3322.31, 41.22, 207.51),
            [3] = vector4(2008.67, 3048.98, 47.21, 124.98),
            [4] = vector4(1851.25, 2585.84, 45.67, 90.89),
            [5] = vector4(1234.43, 330.03, 81.99, 222.82),
            [6] = vector4(-27.2, -193.39, 52.36, 105.79),
            [7] = vector4(321.1, -1003.65, 29.3, 94.53),
            [8] = vector4(893.53, -892.33, 27.06, 256.97),
            [9] = vector4(941.13, -2167.45, 30.54, 336.23),
            [10] = vector4(-234.91, -2655.18, 6.0, 141.78),
            [11] = vector4(-262.26, -972.52, 31.21, 231.23),
            [12] = vector4(-1259.37, -1356.75, 4.08, 93.45),
            [13] = vector4(432.70, 29.98, 90.40, 192.59),
            [14] = vector4(363.35, -1981.34, 24.20, 330.18),
            [15] = vector4(-229.20, -1378.58, 31.25, 166.06),
            [16] = vector4(1225.99, -726.10, 60.60, 141.40),
            [17] = vector4(-724.16, -685.08, 30.31, 93.17),
            [18] = vector4(131.40, -1460.97, 29.35, 27.53),
            [19] = vector4(-1045.16, -1006.57, 2.15, 300.53),
            [20] = vector4(-693.79, 80.12, 55.85, 18.48),
            [21] = vector4(230.24, 164.72, 105.23, 352.59),
            [22] = vector4(-1212.75, -181.67, 39.32, 151.33),
            [23] = vector4(769.22, -152.23, 74.43, 153.82),
            [24] = vector4(1202.77, -563.88, 69.07, 84.77),
            [25] = vector4(-136.94, -1659.32, 32.56, 293.80),
            [26] = vector4(-1042.06, -1353.84, 5.53, 54.74),
            [27] = vector4(21.32, -1506.29, 31.85, 298.47),
            [28] = vector4(877.13, -2256.04, 30.57, 353.59),
            [29] = vector4(86.56, -1955.22, 20.74, 339.14),
            [30] = vector4(13.95, -1852.83, 23.97, 209.01),
            [31] = vector4(-835.41, -705.07, 27.27, 52.39),
            [32] = vector4(-1331.35, -613.24, 27.94, 156.77),
            [33] = vector4(351.14, -2037.63, 22.01, 101.34),
            [34] = vector4(315.15, 197.07, 104.24, 107.59),
            [35] = vector4(-1547.16, -438.60, 35.88, 282.90),
            [36] = vector4(194.09, -1760.84, 29.15, 61.37),
            [37] = vector4(-1190.07, -1531.89, 4.39, 55.34),
            [38] = vector4(-765.80, -913.00, 18.24, 280.66),
            [39] = vector4(946.99, -1780.91, 31.27, 315.95),
            [40] = vector4(-1199.33, -792.09, 16.35, 132.36),
            [41] = vector4(-162.86, 287.72, 97.83, 187.64),
            [42] = vector4(222.12, -1515.59, 29.29, 215.02),
            [43] = vector4(-334.91, -1313.58, 31.40, 128.58),
            [44] = vector4(-1107.88, -1634.14, 4.61, 309.70),
            [45] = vector4(-1038.09, -1132.39, 2.15, 227.56),
            [46] = vector4(-811.38, -1402.44, 5.00, 212.21),
            [47] = vector4(-1249.81, -1141.61, 7.72, 291.62),
            [48] = vector4(989.58, -436.08, 63.73, 269.22),
            [49] = vector4(1141.60, -464.51, 66.85, 257.61),
            [50] = vector4(-1530.11, -579.86, 33.58, 29.06),
            [51] = vector4(-13.69, 241.89, 109.55, 8.51),
            [52] = vector4(-157.64, -988.02, 21.27, 171.85),
            [53] = vector4(-544.05, -1254.22, 16.56, 90.35),
            [54] = vector4(805.12, -1074.65, 28.66, 127.26),
            [55] = vector4(-1035.57, -1571.42, 5.12, 35.96),
        },
        ['SS'] = {
            -- Coming Soon!
        },
        ['GS'] = {
            [1] = vector4(2034.48, 4982.56, 41.09, 276.26),
            [2] = vector4(1863.58, 5007.13, 52.75, 105.39),
            [3] = vector4(1904.89, 4923.09, 48.87, 148.07),
            [4] = vector4(1801.63, 4777.41, 39.86, 90.0),
            [5] = vector4(1718.56, 4791.93, 41.98, 83.52),
            [6] = vector4(1656.45, 4874.75, 42.04, 73.83),
            [7] = vector4(1714.11, 4694.27, 42.77, 267.35),
            [8] = vector4(1938.46, 4629.47, 40.42, 166.71),
            [9] = vector4(1966.96, 4636.83, 40.78, 285.91),
            [10] = vector4(1952.09, 4653.22, 40.62, 60.4),
            [11] = vector4(2117.28, 4770.73, 41.1, 293.46),
            [12] = vector4(2157.48, 4783.46, 41.08, 154.84),
            [13] = vector4(2307.52, 4858.74, 41.81, 300.1),
            [14] = vector4(2227.69, 5156.95, 57.25, 35.69),
            [15] = vector4(2548.39, 5137.57, 48.37, 284.59),
            [16] = vector4(2581.46, 5064.46, 44.92, 225.99),
            [17] = vector4(2656.55, 4867.44, 33.57, 335.17),
            [18] = vector4(2557.38, 4671.28, 34.03, 308.29),
            [19] = vector4(2431.35, 4623.13, 32.37, 114.06),
            [20] = vector4(2300.56, 4881.47, 41.81, 196.8),
        },
        ['PB'] = {
            -- Coming Soon!
        },
        ['SA'] = {
            -- Coming Soon!
            -- This is automatically fetched from previous entries
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
    ['Injuries'] = { -- [ TO BE INTEGRATED ]
        ['InjuriesEnabled'] = true,
        ['InjuryTypes'] = {
            -- ['KEY'] = { ['Label'] = '', ['Item'] = '', },
            [1] = { ['Label'] = 'Small Cut', ['Item'] = 'bandage' },
            [2] = { ['Label'] = 'Large Cut', ['Item'] = 'bandage' },
            [3] = { ['Label'] = 'Headache', ['Item'] = 'painkillers' },
            [4] = { ['Label'] = 'Passed Out', ['Item'] = 'firstaid', },
            [5] = { ['Label'] = 'Gunshot', ['Item'] = 'firstaid' },
        },
    }
}

function MedicAlert(x, y, z)
    if Config.GlobalSettings['Dispatch'] == 'ps' then
        exports["ps-dispatch"]:CustomAlert({
            coords = vector3(x, y, z),
            message = "Local In Need of Help!",
            dispatchCode = "10-68",
            description = "Local In Need of Help!",
            radius = 0,
            sprite = 280,
            color = 23,
            scale = 0.0,
            length = 3,
            job = { 'ambulance' }
        })
    elseif Config.GlobalSettings['Dispatch'] == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = { 'ambulance' },
            coords = vector3(x, y, z),
            title = '10-52',
            message = 'A local has been downed!',
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 280,
                scale = 1.0,
                colour = 23,
                flashes = false,
                text = 'Downed Local',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.GlobalSettings['Dispatch'] == 'custom' then
        -- Create your event here!
    end
end

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