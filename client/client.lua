RegisterNetEvent('hoaaiww_medotry:showText')
AddEventHandler('hoaaiww_medotry:showText', function(source, tab)
    local textEnabled = true
    local currentPlayer = GetPlayerFromServerId(source)
    local text = (tab.name ~= nil and tab.name..': ') .. tab.text

    if tab.success ~= nil then 
        if tab.success then 
            text = text .. " (Successful)" 
        else 
            text = text .. " (Unsuccessful)" 
        end 
    end

    if Config.DisplayOnChat then
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(currentPlayer)))
        local OtherCoords = GetEntityCoords(GetPlayerPed(-1))
        local distance = GetDistanceBetweenCoords(x, y, z, OtherCoords, true)

        if distance < Config.Distance then
            local actionColor, backgroundColor, actionText = nil, nil, ''

            if tab.type == "me" then
                actionColor = Config.TextColor_Me
                backgroundColor = Config.BackgroundColor_Me
                actionText = "Action"
            elseif tab.type == "do" then
                actionColor = Config.TextColor_Do
                backgroundColor = Config.BackgroundColor_Do
                actionText = "Happening"
            elseif tab.type == "try" then
                actionColor = Config.TextColor_Try
                backgroundColor = Config.BackgroundColor_Try
                actionText = "Trying"
            end

            local chatBackground = "rgba("..backgroundColor.r..", "..backgroundColor.g..", "..backgroundColor.b..", 50)"

            TriggerEvent('chat:addMessage', {
                color = { actionColor.r, actionColor.g, actionColor.b }, 
                multiline = true,
                template = '<div style="padding: 0.4vw; margin: 0.5vw; width: 400px; position: relative; right: 24px; background-color: '..chatBackground..'; border-radius: 5px;"><i style="position: relative; left: 50px;" class="fab fa-artstation"> [{0}]<i><div>{1}</div></i></div>',
                args = { actionText, text }
            })
        end
    end

    Citizen.CreateThread(function()
        while textEnabled do
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(currentPlayer)))
            local OtherCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(x, y, z, OtherCoords, true)

            if distance < Config.Distance then
                DrawText3D(x, y, z+1.1, text, tab.type)
            end
            Wait(0)
        end
    end)

    Citizen.CreateThread(function()
        Wait(Config.Duration * 1000)
        textEnabled = false
    end)
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/me', 'Make an action',{{name="Text", help="The action you wish"}})
    TriggerEvent('chat:addSuggestion', '/do', 'Make a happening',{{name="Text", help="The happening you wish"}})
    TriggerEvent('chat:addSuggestion', '/try', 'Make a try action for chance',{{name="Text", help="The try you wish"}})
end)

function DrawText3D(x,y,z, text, action)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*120

    local actionColor = nil
    local backgroundColor = nil
        
    if action == "me" then
        actionColor = Config.TextColor_Me
        backgroundColor = Config.BackgroundColor_Me
    elseif action == "do" then
        actionColor = Config.TextColor_Do
        backgroundColor = Config.BackgroundColor_Do
    elseif action == "try" then
        actionColor = Config.TextColor_Try
        backgroundColor = Config.BackgroundColor_Try
    end

    if onScreen then
        SetTextColour(actionColor.r, actionColor.g, actionColor.b, actionColor.a)
        SetTextScale(0.0*scale, 0.4*scale)
        SetTextFont(Config.Font)
        SetTextProportional(1)
        SetTextCentre(true)
        if Config.DropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.45*scale, font)
        local width = EndTextCommandGetWidth(font)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if Config.Background then
            DrawRect(_x, _y+scale/73, width, height, backgroundColor.r, backgroundColor.g, backgroundColor.b , backgroundColor.a)
        end
    end
end
