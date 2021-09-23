ESX = nil
local success = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterCommand("me", function(source, args, rawCommand)
    if source ~= 0 then
        local text = "There was an error processing the text!"
        if args[1] then
            text = rawCommand:sub(3)
            if Config.EnablePlayerName then
                local xPlayer = ESX.GetPlayerFromId(source)
                local playerName = xPlayer.getName()
                TriggerClientEvent('arp_medotry:showText', -1, playerName..": "..text, source, "me", success)
            else
                TriggerClientEvent('arp_medotry:showText', -1, text, source, "me", success)
            end
            if Config.Log then
                logMe(("**%s** executed a */me* command.\n\n`Content:` %s"):format(GetPlayerName(source), text))
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'You did ~r~not~s~ give any action')
        end
    end
end)

RegisterCommand("do", function(source, args, rawCommand)
    if source ~= 0 then
        local text = "There was an error processing the text!"
        if args[1] then
            text = rawCommand:sub(3)
            if Config.EnablePlayerName then
                local xPlayer = ESX.GetPlayerFromId(source)
                local playerName = xPlayer.getName()
                TriggerClientEvent('arp_medotry:showText', -1, playerName..": "..text, source, "do", success)
            else
                TriggerClientEvent('arp_medotry:showText', -1, text, source, "do", success)
            end
            if Config.Log then
                logDo(("**%s** executed a */do* command.\n\n`Content:` %s"):format(GetPlayerName(source), text))
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'You did ~r~not~s~ give any action')
        end
    end
end)

RegisterCommand("try", function(source, args, rawCommand)
    if source ~= 0 then
        local text = "There was an error processing the text!"
        success = false
        if args[1] then
            if math.random(0, 100) <= Config.TryChance then
                success = true
            end
            text = rawCommand:sub(4)
            if Config.EnablePlayerName then
                local xPlayer = ESX.GetPlayerFromId(source)
                local playerName = xPlayer.getName()
                TriggerClientEvent('arp_medotry:showText', -1, playerName..": "..text, source, "try", success)
            else
                TriggerClientEvent('arp_medotry:showText', -1, text, source, "try", success)
            end
            if Config.Log then
                logTry(("**%s** executed a */try* command.\n\n`Content:` %s\n`Result:`" ..(success and " Successful" or " Unsuccessful")):format(GetPlayerName(source), text))
            end
            success = nil
        else
            TriggerClientEvent('esx:showNotification', source, 'You did ~r~not~s~ give any action')
        end
    end
end)

function logMe(msg)
    if Config.Logwebhook ~= "" then
        local connect = {
            {
                ["color"] = 4168183,
                ["title"] = "**/Me**",
                ["description"] = msg:gsub("%^%d",""),
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                ["footer"] = {
                    ["text"] = "Made by: hoaaiww",
                },
            }
        }
        PerformHttpRequest(Config.Logwebhook, function(err, text, headers) end, 'POST', json.encode({embeds = connect}), { ['Content-Type'] = 'application/json' })
    end
end

function logDo(msg)
    if Config.Logwebhook ~= "" then
        local connect = {
            {
                ["color"] = 13247822,
                ["title"] = "**/Do**",
                ["description"] = msg:gsub("%^%d",""),
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                ["footer"] = {
                    ["text"] = "Made by: hoaaiww",
                },
            }
        }
        PerformHttpRequest(Config.Logwebhook, function(err, text, headers) end, 'POST', json.encode({embeds = connect}), { ['Content-Type'] = 'application/json' })
    end
end

function logTry(msg)
    if Config.Logwebhook ~= "" then
        local connect = {
            {
                ["color"] = 1486276,
                ["title"] = "**/Try**",
                ["description"] = msg:gsub("%^%d",""),
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                ["footer"] = {
                    ["text"] = "Made by: hoaaiww",
                },
            }
        }
        PerformHttpRequest(Config.Logwebhook, function(err, text, headers) end, 'POST', json.encode({embeds = connect}), { ['Content-Type'] = 'application/json' })
    end
end
