offset = 100
local newOff = 0
local c = true -- set to True to use custom offsets

function onCreate()
    if not c then
        offset = getPropertyFromClass('backend.ClientPrefs','data.noteOffset')
    elseif c then
        setPropertyFromClass('backend.ClientPrefs','data.noteOffset',offset) --Number is YOUR Song Offset
    end
    for _, curS in pairs({'marshmallow-(alone)','alan-becker-(sea-shanty-edit)','alan-becker-(sea-shanty)'}) do
        if songName == curS then
            newOff = -25 --Number is YOUR Song Offset
        elseif songName == 'sandstorm' or songName == 'the-living-tombstone-(FNaF1)' then
            newOff = 0 --Number is YOUR Song Offset
        elseif songName == 'TON-GD-Level' or songName == 'alan-becker-(rush-e)' or songName == 'run-run' then
            newOff = -45 --Number is YOUR Song Offset
        elseif songName == 'cg5-(stuck-inside)' then
            newOff = -70 --Number is YOUR Song Offset
        elseif songName == 'Ugh' then
            newOff = 75 --Number is YOUR Song Offset
        elseif songName == 'electroman-adventures' or songName == 'everytime-we-touch' then
            newOff = 35 --Number is YOUR Song Offset
        elseif songName == 'Stress' then
            newOff = 60
        elseif songName == 'Octagon of Destiny' then
            newOff = -10 --Number is YOUR Song Offset
        end
    end
    if newOff ~= 0 then
        setPropertyFromClass('backend.ClientPrefs','data.noteOffset',offset+newOff)
    end
end

function onCreatePost()
    if newOff ~= 0 then
        callScript("scripts/script", "offnewch", {newOff})
    else
        callScript("scripts/script", "offnewch", {0})
    end
end

function onDestroy()
    if c then
        setPropertyFromClass('backend.ClientPrefs','data.noteOffset',offset)
    end
end