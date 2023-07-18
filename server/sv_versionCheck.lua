--[[ Version Checker ]] --
local version = '110'

local DISCORD_WEBHOOK = ''
local DISCORD_NAME = 'LENT - AICallouts'
local DISCORD_IMAGE = 'https://cdn.discordapp.com/attachments/1026175982509506650/1026176123928842270/Lanzaned.png'

local RESOURCE_NAME = 'LENT-AICalls'

local GITHUB_LINK = 'https://raw.githubusercontent.com/Lanzaned-Enterprises/' .. RESOURCE_NAME .. '/main/version.txt'

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        checkResourceVersion()
    end
end)

function checkUpdateEmbed(color, name, message, footer)
    local content = { { ['color'] = color, ['title'] = ' ' .. name .. ' ', ['footer'] = { ['text'] = ' ' .. footer .. ' ', }, } }

   PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({ username = DISCORD_NAME, embeds = content, avatar_url = DISCORD_IMAGE }), { ['Content-Type'] = 'application/json '})
end

function checkResourceVersion()
    PerformHttpRequest(GITHUB_LINK, function(err, text, headers)
        if (version > text) then -- Using Dev Branch
            print(' ')
            print('---------- LANZANED ----------')
            print('You are using a development build! Please update to a stable ASAP!')
            print('Your Version: ' .. version .. ' Current Stable Version: ' .. text)
            print('https://github.com/Lanzaned-Enterprises/' .. RESOURCE_NAME)
            print('------------------------------')
            print(' ')
            checkUpdateEmbed(5242880, 'LANZANED Update Checker', 'You are using a development branch! Please update to stable ASAP! Your Version: ' .. version .. ' Current Stable Version: ' .. text .. ' https://github.com/Lanzaned-Enterprises/' .. RESOURCE_NAME .. '', 'Script created by: https://discord.lanzaned.com')
        elseif (text < version) then -- Not updated
            print(' ')
            print('---------- LANZANED ----------')
            print('This resource is not up to date! Please update!')
            print('Curent Version: ' .. version .. ' Latest Version: ' .. text)
            print('https://github.com/Lanzaned-Enterprises/' .. RESOURCE_NAME .. '')
            print('------------------------------')
            print(' ')
            checkUpdateEmbed(5242880, 'LANZANED Update Checker', 'This resource is not up to date! Please update! Curent Version: ' .. version .. ' Latest Version: ' .. text .. ' https://github.com/Lanzaned-Enterprises/' .. RESOURCE_NAME .. '', 'Script created by: https://discord.lanzaned.com')
        else -- resource is fine
            print(' ')
            print('---------- LANZANED ----------')
            print('This resource is up to date and ready to go!')
            print('Running on Version: ' .. version)
            print('https://github.com/Lanzaned-Enterprises/' .. RESOURCE_NAME .. '')
            print('------------------------------')
            print(' ')
            checkUpdateEmbed(20480, 'LANZANED Update Checker', 'You are up to date and ready to go! Running on Version: ' .. version .. ' https://github.com/Lanzaned-Enterprises/' .. RESOURCE_NAME .. '', 'Script created by: https://discord.lanzaned.com')
        end
    end, 'GET', '', {})
end