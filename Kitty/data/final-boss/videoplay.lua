local videoName = 'finalboss'

startGame = false
local offset = 0
function onStartCountdown()
    if not startGame then
        runTimer('startGame', 2)
        startVideo(videoName, false, true)
        setObjectCamera('videoCutscene','game')
        setProperty('videoCutscene.alpha', 0.1)
        setProperty('camGame.zoom',zoom)
        return Function_Stop
    elseif startGame then
        return Function_Continue
    end
end
function onSongStart()
    offset = getPropertyFromClass('backend.ClientPrefs','data.noteOffset')

    setProperty('showRating', false);
    setProperty('showComboNum', false);

    runTimer('vid',(offset)/1000)
end

function onTimerCompleted(tag)
    if tag == 'startGame' then
        startGame = true
        startCountdown()
    end
    if tag == 'vid' then
        callScript('scripts/videoSprite', 'makeVideoSprite', {videoName, videoName,'camGame',1})
        close()
    end
end