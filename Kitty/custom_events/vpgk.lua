local size = 0
local lerpedSize = 0
local firstTime = true
local hiding = true
function onCreate()
    makeLuaSprite("vignet", 'me/popup/vignettepgk',0,0)
    screenCenter("vignet", 'xy')
    setObjectCamera("vignet", 'game')
    setScrollFactor("vignet", 0, 0)
    setObjectOrder("vignet", 100)
    scaleObject("vignet", 1,1)
    setProperty("vignet.alpha", 0)

    makeLuaSprite("blackSc", 'me/popup/blackScreen',0,0)
    screenCenter("blackSc", 'xy')
    setObjectCamera("blackSc", 'other')
    setScrollFactor("blackSc", 0, 0)
    setObjectOrder("blackSc", 120)
    scaleObject("blackSc", 2,2)
    setProperty("blackSc.alpha", 0)
end

function onEvent(name, value1, value2)
    if name == "vpgk" then
        if value2 ~= 'black' or value2 ~= 'blacktween' or value2 ~= 'noblacktween' or value2 ~= 'noblack' then
		    sizea = tonumber(value1)
            cancelTween("stpoo")
        end
        if value1 == 'hide' or value2 == 'hide' then
            hiding = true
            doTweenAlpha("stpoo", "vignet", 0, 1, "circOut")
        end
        if value2 ~= 'first' and value2 ~= 'hide' then
            hiding = false
        end
        if value2 == 'second' then
            hiding = false
            firstTime = false
        end
        if value2 == 'black' then
            setProperty('blackSc.alpha', 1)
        elseif value2 == 'blacktween' then
            doTweenAlpha("blackb", "blackSc", 1, value1, "linear")
        elseif value2 == 'noblack' then
            setProperty('blackSc.alpha', 1)
        elseif value2 == 'noblacktween' then
            doTweenAlpha("blackb", "blackSc", 0, value1, "linear")
        end
    end
end
function lerp(a, b, ratio)
	return a + ratio * (b - a); --the funny lerp
end
function doLerp()
    size = sizea-(getProperty('camGame.zoom')-1)
    lerpedSize = lerp(lerpedSize, size, ee*5)
    scaleObject("vignet", lerpedSize, lerpedSize)
    screenCenter("vignet", 'xy')
end

function onUpdate(elapsed)
    ee = elapsed
    if hiding then
        doLerp()
    end
    if firstTime then
        doLerp()
        setProperty("vignet.alpha", 0)
    end
    if not hiding and not firstTime then
        doLerp()
        setProperty("vignet.alpha", 1)
    end
end