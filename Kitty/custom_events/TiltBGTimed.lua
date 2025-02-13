local ran = false
local thing2 = 1
local v1 = false

function onCreatePost()
    if getPropertyFromClass('backend.ClientPrefs', 'data.assetMovement') == false then
        close(true)
    end
end


function onEvent(name, value1, value2)
    if name == "TiltBGTimed" and getPropertyFromClass('backend.ClientPrefs', 'data.assetMovement') then
        value1 = tonumber(value1)
        value2 = tonumber(value2) or (value1 ~= 1234 and value1 ~= 1111 and 0.3 or 0)

        if value1 == 1234 then
            v1 = true
        elseif value1 == 1111 then
            v1 = false
            if value2 < 0.011 then
                setProperty('camGame.angle', 0)
            else
                doTweenAngle("BG9tween", "camGame", 0, value2, "quadInOut")
            end
        elseif value2 < 0.011 then
            setProperty('camGame.angle', ran and value1 or -value1)
            ran = not ran
        elseif value2 > 0.011 then
            local angle
            if value1 == 00 then
                angle = 0
                ran = false
            elseif value1 == 1 then
                angle = ran and 10 or -10
            elseif value1 == 2 then
                angle = ran and 30 or -30
            else
                angle = ran and value1 or -value1
            end
            doTweenAngle('BG' .. tostring(value1) .. 'tween', 'camGame', angle, value2, 'linear')
            ran = not ran
        end
    end
end

function onBeatHit()
    if getPropertyFromClass('backend.ClientPrefs', 'data.assetMovement') and v1 then
        thing2 = -thing2
        doTweenAngle('rotate', 'camGame', thing2 * 5, crochet / 1000, 'quadInOut')
    end
end
