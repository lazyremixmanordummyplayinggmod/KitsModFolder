local ran = false
local thing2 = 1
local v1 = false

function onCreatePost()
    if getPropertyFromClass('backend.ClientPrefs', 'data.assetMovement') == false then
        close(true)
    end
end


function onEvent(name, value1, value2)
    if name == "TiltHudTimed" and getPropertyFromClass('backend.ClientPrefs', 'data.assetMovement') then
        value1 = tonumber(value1)
        value2 = tonumber(value2)

        if value1 == 1234 then
            v1 = true
        elseif value1 == 1111 then
            v1 = false
            if value2 > 0.011 then
                doTweenAngle("GUIBruhtween", "camHUD", 0, value2, "quadInOut")
            else
                setProperty('camHUD.angle', 0)
            end
        elseif value2 < 0.011 then
            if value1 == newV then
                setProperty('camHUD.angle', -value1)
            else
                setProperty('camHUD.angle', value1)
            end
            ran = not ran
            newV = value1
        elseif value2 > 0.011 then
            if value1 == 0 then
                angle = 0
                newV = 0
                cV = 0
                ran = false
            elseif value1 == 1 then
                if value1 == cV then
                    angle = -10
                else
                    angle = 10
                end
            elseif value1 == 2 then
                if value1 == cV then
                    angle = -30
                else
                    angle = 30
                end
            elseif value1 == angle then
                angle = -value1
            else
                angle = value1
            end
            cV = value1
            doTweenAngle('GUI' .. tostring(value1) .. 'tween', 'camHUD', angle, value2, 'linear')
            ran = not ran
        end
    end
end

function onBeatHit()
    if getPropertyFromClass('backend.ClientPrefs', 'data.assetMovement') and v1 then
        thing2 = -thing2
        doTweenAngle('rotate', 'camHUD', thing2 * 5, crochet / 1000, 'quadInOut')
    end
end
