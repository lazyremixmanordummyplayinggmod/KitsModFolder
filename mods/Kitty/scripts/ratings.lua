local sks = 0
local gds = 0
local bds = 0
local brs = 0
local health = 0
local nr = 0
local comb = 0
local sizeee = 40
local letter = '?'

local died = 0

function luatxt(tag,txt,w,x,y,cam,ts,tc,sc,ali,f) -- set certain values to '.' for default or no value
    makeLuaText(tag,txt,w,x,y)
    setObjectCamera(tag,cam)
    setTextSize(tag, ts)
    if tc == '.' then
        tc = 'FFFFFF'
    end
    setTextColor(tag, tc)
    if sc ~= '.' then
        screenCenter(tag, sc)
    end
    if ali == '.' then
        ali = 'center'
    end
    setTextAlignment(tag, ali)
    if f == '.' then
        f = false
    end
    addLuaText(tag,f)
end

function onCreate()
    health = (getProperty('health')*50)
    nr = (math.floor(rating*10000)/100)
    --Text Basics!

    luatxt("mainP", ("Perfects: "..pfs), 0, 0, 0,"other",20,'00FFFF','y','left','.')
    luatxt("mainS", ("Sicks: "..sks), 0, 0, 0,"other",20,'FF00FF','y','left','.')
    luatxt("mainG", ("Goods: "..gds), 0, 0, 0,"other",20,'00FF00','y','left','.')
    luatxt("mainB", ("Bads: "..bds), 0, 0, 0,"other",20,'FFFF00','y','left','.')
    luatxt("mainVB", ("Bruh: "..brs), 0, 0, 0,"other",20,'FF7500','y','left','.')
    luatxt("mainMss", ("Misses: "..misses), 0, 0, 0,"other",20,'FF0000','y','left','.')
    luatxt("mainhp", ("Health: "..health), 0, 0, 0,"other",20,'0000FF','y','left','.')
    luatxt("mainacc", (letter..' - '..nr.."%"), 1280, 0, 0,"other",30,'.','.','right','.')
    luatxt("mainsc", score, 1280, 0, 0,"other",20,'.','.','right','.')
    luatxt("maincom", comb, 0, 0, screenHeight-28,"other",30,'.','.','left','.')

    --Text Positioning
    setProperty('mainP.y',getProperty('mainP.y')-80)
    setProperty('mainS.y',getProperty('mainS.y')-60)
    setProperty('mainG.y',getProperty('mainG.y')-40)
    setProperty('mainB.y',getProperty('mainB.y')-20)
    setProperty('mainMss.y',getProperty('mainMss.y')+20)
    setProperty('mainhp.y',getProperty('mainhp.y')+40)
    setProperty('mainacc.y',0)
    setProperty('mainsc.y',30)
    setProperty('maincom.y',screenHeight-28)

    makeLuaSprite('mainbeat', 'me/popup/beatthing',20,getProperty('mainS.y')-70)
    setObjectCamera("mainbeat", 'other')
    scaleObject("mainbeat", 0.15, 0.15)
    addLuaSprite("mainbeat")
end

function onBeatHit()
    if raa then
        doTweenColor("mainbcst", "mainbeat", "FF0000", 0.1, "linear")
        raa = false
    else
        doTweenColor("mainbcst", "mainbeat", "FFFFFF", 0.1, "linear")
        raa = true
    end
    setProperty('mainbeat.scale.x',0.3)
    setProperty('mainbeat.scale.y',0.3)
    doTweenX('mainbtsx','mainbeat.scale',0.15,0.4,'expoOut')
    doTweenY('mainbtsy','mainbeat.scale',0.15,0.4,'expoOut')
end

--This moves the rating text forward based on when the credits text show up, positions vary for the length of the credit names
function onCountdownTick(counter)
    if counter == 2 then
        doTweenX('mainxP','mainP',600,0.5,'expoOut')
        doTweenX('mainxS','mainS',600,0.5,'expoOut')
        doTweenX('mainxG','mainG',600,0.5,'expoOut')
        doTweenX('mainxB','mainB',600,0.5,'expoOut')
        doTweenX('mainxVB','mainVB',600,0.5,'expoOut')
        doTweenX('mainxMss','mainMss',600,0.5,'expoOut')
        doTweenX('mainxhp','mainhp',600,0.5,'expoOut')
    elseif counter == 3 then
        runTimer('mainend4', 1.2, 1)
    end
end

function customRatingThing(m)
    if m then
        comb = 0
    else
        comb = comb+1
    end
    nr = (math.floor(rating*10000)/100)
    if nr == 100 then
        setTextColor("mainacc", "00FFFF")
        letter = 'P'
    elseif nr >= 95 and nr < 100 then
        setTextColor("mainacc", "FF00FF")
        letter = 'S'
    elseif nr >= 90 and nr < 95 then
        setTextColor("mainacc", "00FF00")
        letter = 'A'
    elseif nr < 90 and nr >= 80 then
        setTextColor("mainacc", "0075FF")
        letter = 'B'
    elseif nr < 80 and nr >= 70 then
        setTextColor("mainacc", "FFFF00")
        letter = 'C'
    elseif nr < 70 and nr >= 60 then
        setTextColor("mainacc", "FF7500")
        letter = 'D'
    elseif nr < 60 then
        setTextColor("mainacc", "FF0000")
        letter = 'F'
    end
    setTextString("mainacc", (letter..' - '..nr.."%"))
    setTextString("mainsc", score)
    setTextString("maincom", comb)
    setTextString("mainMss", ("Misses: "..misses))
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if getPropertyFromGroup('notes',id,'rating') == 'perfect' then
        pfs = pfs+1
    end
    if getPropertyFromGroup('notes',id,'rating') == 'sick' then
        sks = sks+1
    end
    if getPropertyFromGroup('notes',id,'rating') == 'good' then
        gds = gds+1
    end
    if getPropertyFromGroup('notes',id,'rating') == 'bad' then
        bds = bds+1
    end
    if getPropertyFromGroup('notes',id,'rating') == 'shit' then
        brs = brs+1
    end
    setTextString("mainP", ("Perfects: "..pfs))
    setTextString("mainS", ("Sicks: "..sks))
    setTextString("mainG", ("Goods: "..gds))
    setTextString("mainB", ("Bads: "..bds))
    setTextString("mainVB", ("Bruh: "..brs))
    if not isSustainNote then
        customRatingThing(false)
        for _, value in pairs({'mainmtxtsx','mainmtxtsy','mainmtxtx','mainmtxty','maintxtsx','maintxtsy','maintxtx','maintxty'}) do
            cancelTween(value)
        end
        if comb < 10 then
            setProperty('maincom.scale.x', 3.6)
            setProperty('maincom.scale.y', 2)
            setProperty('maincom.x', 43)
            setProperty('maincom.y', screenHeight-39)
            doTweenX("maintxtsx", "maincom.scale", 1, 0.4, "expoOut")
            doTweenY("maintxtsy", "maincom.scale", 1, 0.4, "expoOut")
            doTweenX("maintxtx", "maincom", 0, 0.4, "expoOut")
            doTweenY("maintxty", "maincom", screenHeight-28, 0.4, "expoOut")
        elseif comb >= 10 and comb < 100 then
            setProperty('maincom.scale.x', 3.4)
            setProperty('maincom.scale.y', 2)
            setProperty('maincom.x', 40)
            setProperty('maincom.y', screenHeight-39)
            doTweenX("maintxtsx", "maincom.scale", 1, 0.4, "expoOut")
            doTweenY("maintxtsy", "maincom.scale", 1, 0.4, "expoOut")
            doTweenX("maintxtx", "maincom", 0, 0.4, "expoOut")
            doTweenY("maintxty", "maincom", screenHeight-28, 0.4, "expoOut")
        elseif comb >= 100 and comb < 1000 then
            setProperty('maincom.scale.x', 3)
            setProperty('maincom.scale.y', 2)
            setProperty('maincom.x', 52)
            setProperty('maincom.y', screenHeight-39)
            doTweenX("maintxtsx", "maincom.scale", 1, 0.4, "expoOut")
            doTweenY("maintxtsy", "maincom.scale", 1, 0.4, "expoOut")
            doTweenX("maintxtx", "maincom", 0, 0.4, "expoOut")
            doTweenY("maintxty", "maincom", screenHeight-28, 0.4, "expoOut")
        elseif comb >= 1000 and comb < 10000 then
            setProperty('maincom.scale.x', 2.6)
            setProperty('maincom.scale.y', 2)
            setProperty('maincom.x', 56)
            setProperty('maincom.y', screenHeight-39)
            doTweenX("maintxtsx", "maincom.scale", 1, 0.4, "expoOut")
            doTweenY("maintxtsy", "maincom.scale", 1, 0.4, "expoOut")
            doTweenX("maintxtx", "maincom", 0, 0.4, "expoOut")
            doTweenY("maintxty", "maincom", screenHeight-28, 0.4, "expoOut") 
        elseif comb >= 10000 and comb < 100000 then
            setProperty('maincom.scale.x', 2.2)
            setProperty('maincom.scale.y', 2)
            setProperty('maincom.x', 56)
            setProperty('maincom.y', screenHeight-39)
            doTweenX("maintxtsx", "maincom.scale", 1, 0.4, "expoOut")
            doTweenY("maintxtsy", "maincom.scale", 1, 0.4, "expoOut")
            doTweenX("maintxtx", "maincom", 0, 0.4, "expoOut")
            doTweenY("maintxty", "maincom", screenHeight-28, 0.4, "expoOut")
        elseif comb >= 100000 and comb < 1000000 then
            setProperty('maincom.scale.x', 2)
            setProperty('maincom.scale.y', 2)
            setProperty('maincom.x', 56)
            setProperty('maincom.y', screenHeight-39)
            doTweenX("maintxtsx", "maincom.scale", 1, 0.4, "expoOut")
            doTweenY("maintxtsy", "maincom.scale", 1, 0.4, "expoOut")
            doTweenX("maintxtx", "maincom", 0, 0.4, "expoOut")
            doTweenY("maintxty", "maincom", screenHeight-28, 0.4, "expoOut") 
        end
        if comb >= 1000000 then
            setTextColor("maincom", "FF00FF")
        elseif comb < 1000000 then
            setTextColor("maincom", "FFFFFF")
        end
    end
    health = (getProperty('health')*50)
    if health >= 100 then
        health = 100
    end
    if health <= 100 then
        setTextString("mainhp", ("Health: "..health))
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    customRatingThing(true)
    for _, value in pairs({'mainmtxtsx','mainmtxtsy','mainmtxtx','mainmtxty','maintxtsx','maintxtsy','maintxtx','maintxty'}) do
        cancelTween(value)
    end
    setProperty('maincom.scale.x', 0.25)
    setProperty('maincom.scale.y', 0.5)
    setProperty('maincom.x', -5)
    setProperty('maincom.y', screenHeight-25)
    doTweenX("mainmtxtsx", "maincom.scale", 1, 0.5, "expoOut")
    doTweenY("mainmtxtsy", "maincom.scale", 1, 0.5, "expoOut")
    doTweenX("mainmtxtx", "maincom", 0, 0.5, "expoOut")
    doTweenY("mainmtxty", "maincom", screenHeight-28, 0.5, "expoOut")
    health = (getProperty('health')*50)
    setTextString("mainhp", ("Health: "..health))
end

--When using credits, This makes the text go back after the credits.lua normal time length.
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'mainlol' then
        doTweenX('mainxP','mainP',0,0.5,'expoOut')
        doTweenX('mainxS','mainS',0,0.5,'expoOut')
        doTweenX('mainxG','mainG',0,0.5,'expoOut')
        doTweenX('mainxB','mainB',0,0.5,'expoOut')
        doTweenX('mainxVB','mainVB',0,0.5,'expoOut')
        doTweenX('mainxMss','mainMss',0,0.5,'expoOut')
        doTweenX('mainxhp','mainhp',0,0.5,'expoOut')
    end
    if tag == 'mainend4' then
        runTimer("mainlol", 0.2)
    end
end

--@PringleKitten's Very Simple Custom Ratings!