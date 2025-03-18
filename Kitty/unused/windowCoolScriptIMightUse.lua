function onCreate()
    -- Not being used so... just in case..
    close()
end

-- Tween Window Size and Centering with Smooth Offset
-- Usage: startWindowSizeTween(1920, 1050, 0, quadOut, 0, -15)
function startWindowSizeTween(targetW, targetH, duration, ease, xOffset, yOffset)
    startWidth = getPropertyFromClass("openfl.Lib", "application.window.width")
    startHeight = getPropertyFromClass("openfl.Lib", "application.window.height")
    targetWidth = targetW
    targetHeight = targetH

    startX = getPropertyFromClass("openfl.Lib", "application.window.x")
    startY = getPropertyFromClass("openfl.Lib", "application.window.y")

    -- Store current offset as the starting point
    startOffsetX = startOffsetX or 0
    startOffsetY = startOffsetY or 0
    targetOffsetX = xOffset or 0
    targetOffsetY = yOffset or 0
    if duration ~= 0 then
        tweenDurationSize = duration
        tweenStartTimeSize = os.clock()
        tweenEaseSize = ease
        isTweeningSize = true

        runTimer('windowSizeTween', 0.01, 0)
    else
        local finalX = startX + (startWidth - targetWidth) / 2 + targetOffsetX
        local finalY = startY + (startHeight - targetHeight) / 2 + targetOffsetY
        setPropertyFromClass("openfl.Lib", "application.window.width", targetWidth)
        setPropertyFromClass("openfl.Lib", "application.window.height", targetHeight)
        setPropertyFromClass("openfl.Lib", "application.window.x", finalX)
        setPropertyFromClass("openfl.Lib", "application.window.y", finalY)
    end
end

-- Tween Window X Position
function startWindowTweenX(target, duration, ease)
    startX = getPropertyFromClass("openfl.Lib", "application.window.x")
    targetX = target

    tweenDurationPos = duration
    tweenStartTimePos = os.clock()
    tweenEasePos = ease
    isTweeningPos = true

    runTimer('windowPosTween', 0.01, 0)
end

function onTimerCompleted(tag, loops, loopsLeft)
    -- Size Tweening
    if tag == 'windowSizeTween' and isTweeningSize then
        local elapsed = os.clock() - tweenStartTimeSize
        if elapsed < tweenDurationSize then
            local progress = elapsed / tweenDurationSize
            -- Ease width and height
            local newWidth = tweenEaseSize(progress, startWidth, targetWidth - startWidth, 1)
            local newHeight = tweenEaseSize(progress, startHeight, targetHeight - startHeight, 1)
            -- Ease offsets
            local newOffsetX = tweenEaseSize(progress, startOffsetX, targetOffsetX - startOffsetX, 1)
            local newOffsetY = tweenEaseSize(progress, startOffsetY, targetOffsetY - startOffsetY, 1)
            -- Center window while resizing + smooth offset transition
            local newX = startX + (startWidth - newWidth) / 2 + newOffsetX
            local newY = startY + (startHeight - newHeight) / 2 + newOffsetY
            -- Apply new size and position
            setPropertyFromClass("openfl.Lib", "application.window.width", newWidth)
            setPropertyFromClass("openfl.Lib", "application.window.height", newHeight)
            setPropertyFromClass("openfl.Lib", "application.window.x", newX)
            setPropertyFromClass("openfl.Lib", "application.window.y", newY)
        else
            -- Final size correction with final offset
            local finalX = startX + (startWidth - targetWidth) / 2 + targetOffsetX
            local finalY = startY + (startHeight - targetHeight) / 2 + targetOffsetY
            setPropertyFromClass("openfl.Lib", "application.window.width", targetWidth)
            setPropertyFromClass("openfl.Lib", "application.window.height", targetHeight)
            setPropertyFromClass("openfl.Lib", "application.window.x", finalX)
            setPropertyFromClass("openfl.Lib", "application.window.y", finalY)
            -- Save final offsets
            startOffsetX = targetOffsetX
            startOffsetY = targetOffsetY
            cancelTimer('windowSizeTween')
            isTweeningSize = false
        end
    end

    -- X Position Tweening
    if tag == 'windowPosTween' and isTweeningPos then
        local elapsed = os.clock() - tweenStartTimePos
        if elapsed < tweenDurationPos then
            local progress = elapsed / tweenDurationPos
            local newX = tweenEasePos(progress, startX, targetX - startX, 1)
            setPropertyFromClass("openfl.Lib", "application.window.x", newX)
        else
            setPropertyFromClass("openfl.Lib", "application.window.x", targetX)
            cancelTimer('windowPosTween')
            isTweeningPos = false
        end
    end
end

-- Easing Functions
function linear(t, b, c, d)
    return c * t / d + b
end

function quadOut(t, b, c, d)
    t = t / d
    return -c * t * (t - 2) + b
end

function expoOut(t, b, c, d)
    return c * (-math.pow(2, -10 * t / d) + 1) + b
end