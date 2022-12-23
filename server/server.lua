ESX = nil

function debug(info, debugMsg)
    if Config.Debug then
        print((info and '[^3INFO^7]' or '[^1ERROR^7]') .. ' ^7[^3'..GetCurrentResourceName()..'^7] | ' .. debugMsg)
    end
end

function executeCommand(source, tab)
    if Config.EnablePlayerName then
        local playerName = GetPlayerName(source)

        if Config.UseESXRPName and ESX ~= nil then
            local xPlayer = ESX.GetPlayerFromId(source)
            playerName = xPlayer.getName()
        end
        tab['name'] = playerName
    end
    TriggerClientEvent('hoaaiww_medotryhave:showText', -1, source, tab)

    if Config.LogDiscord then
        DiscordLog(tab.type, '**'..GetPlayerName(source)..'** executed a */'..tab.type..'* command.\n\n`Content:` ' .. tab.text .. (tab.type == 'try' and ('\n`Result:`' .. (tab.success and ' Successful' or ' Unsuccessful'))))
    end
end

function DiscordLog(type, text)
    local type, color = '**/Me** command executed', 4168183

    if type == 'do' then
        type, color = '**/Do** command executed', 13247822
    elseif type == 'try' then
        type, color = '**/Try** command executed', 1486276
    end

    if Config.LogWebhook ~= "" or Config.LogWebhook ~= "Your Webhook Url" then
        local connect = {{
            ["color"] = color,
            ["title"] = type,
            ["description"] = text:gsub("%^%d",""),
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            ["footer"] = { ["text"] = "/Me, /Do, /Try & /Have by: hoaaiww" },
        }}
        PerformHttpRequest(Config.LogWebhook, function(err, text, headers) end, 'POST', json.encode({embeds = connect}), { ['Content-Type'] = 'application/json' })
    else
        debug(false, 'Discord logging is enabled, but you have not set your discord channel webhook yet!')
    end
end

if Config.EnablePlayerName and Config.UseESXRPName then
    if GetResourceState('es_extended') == 'started' then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        debug(true, 'ESX player names are successfully enabled!')
    else
        debug(false, 'Resource ^2es_extended^7 is not running or not working. Please make sure resource ^2es_extended^7 is working properly!')
    end
end

RegisterCommand("me", function(source, args, rawCommand)
    if source ~= 0 then
        if args[1] then
            executeCommand(source, { ['type'] = 'me', ['text'] = args[1] })
        else
            TriggerClientEvent('esx:showNotification', source, 'You did ~r~not~s~ give any action')
        end
    else
        debug(false, 'This command can only be used as a player on the server!')
    end
end)

RegisterCommand("do", function(source, args, rawCommand)
    if source ~= 0 then
        local text = "There was an error processing the text!"
        if args[1] then
            executeCommand(source, { ['type'] = 'do', ['text'] = args[1] })
        else
            TriggerClientEvent('esx:showNotification', source, 'You did ~r~not~s~ give any action')
        end
    else
        debug(false, 'This command can only be used as a player on the server!')
    end
end)

RegisterCommand('try', function(source, args, rawCommand)
    if source ~= 0 then
        if args[1] then
            local success = false
            if math.random(0, 100) <= Config.TryChance then success = true end

            executeCommand(source, { ['type'] = 'try', ['text'] = args[1], ['success'] = success })
        else
            TriggerClientEvent('esx:showNotification', source, 'You did ~r~not~s~ give any action')
        end
    else
        debug(false, 'This command can only be used as a player on the server!')
    end
end)

if Config.checkForUpdates then
	local version = Config.Version
	local resourceName = GetCurrentResourceName()
	
	Citizen.CreateThread(function()
		function checkVersion(err, response, headers)
			if err == 200 then
				local data = json.decode(response)
				if version ~= data.medotryVersion and tonumber(version) < tonumber(data.medotryVersion) then
					print("Resource [^2"..resourceName.."^7] is ^1outdated^7.\nLatest version: ^3"..data.medotryVersion.."\n^7Installed version: ^1"..version.."\n^2Update ^7you resource here: ^5https://github.com/hoaaiww/hoaaiww_me_do_try/releases ^7")
				elseif tonumber(version) > tonumber(data.medotryVersion) then
					print("Resource [^2"..resourceName.."^7] is on ^1higher^7 version then the current up to date version! Please check to update: ^5https://github.com/hoaaiww/hoaaiww_me_do_try/releases ^7")
				else
					print("Resource [^2"..resourceName.."^7] is ^2up to date^7! Version: ^2" .. version .."^7")
				end
			else
				print("^1Version Check failed!^7 HTTP Error Code: "..err)
			end
			
			SetTimeout(7200000, checkVersionHTTPRequest)
		end
		function checkVersionHTTPRequest()
			PerformHttpRequest("https://raw.githubusercontent.com/hoaaiww/version/main/versions.json", checkVersion, "GET")
		end
		checkVersionHTTPRequest()
	end)
end
