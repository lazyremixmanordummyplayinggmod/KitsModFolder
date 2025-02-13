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
end

function onEvent(name, value1, value2)
    if name == "vpgk" then
		sizea = tonumber(value1)
        cancelTween("stpoo")
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