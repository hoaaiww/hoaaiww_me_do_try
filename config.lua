Config = {} -- Do not touch this!


Config.Background           = true -- Enable/Disable the background of the 3D text?
Config.DisplayOnChat        = true -- Display actions in chat?

Config.EnablePlayerName     = true -- Enable player ingame name in the text who executed the command?
Config.UseESXRPName         = false -- Use ESX player names? If true you need to have running ESX (resource es_extended)!

Config.Debug                = true -- print debugs in server console in case either error or information.

Config.LogDiscord           = false -- Enable (true) / Disable (false) logging on Discord?
Config.LogWebhook           = "Your Webhook Url" -- If "LogDiscord" is enabled then replace 'Your Webhook Url' with your Discord Channel Webhook.

Config.checkForUpdates      = true -- Check for updates. /!\ Recommended turned on true
Config.Version              = '2.0'

---------- Advanced options ----------
Config.TextColor_Me         = { r = 255, g = 255, b = 255, a = 255 } -- Adjust the text color (3D and the Chat too)
Config.TextColor_Do         = { r = 255, g = 255, b = 255, a = 255 }
Config.TextColor_Try        = { r = 255, g = 255, b = 255, a = 255 }

Config.BackgroundColor_Me   = { r = 63, g = 153, b = 247, a = 150 } -- Adjust the background color (3D and the Chat too)
Config.BackgroundColor_Do   = { r = 202, g = 37, b = 78, a = 150 }
Config.BackgroundColor_Try  = { r = 22, g = 173, b = 196, a = 150 }

Config.Duration             = 5 -- Text duration (in seconds)
Config.Distance             = 10 -- Who can see my action inside the distance (in meter)
Config.TryChance            = 50 -- Chance of the try action (in %)
Config.DropShadow           = false -- Drop shadow (3D text)
Config.Font                 = 4 -- Font type in number (3D text)
