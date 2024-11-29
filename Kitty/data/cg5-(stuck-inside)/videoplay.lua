local offset = 0
function onSongStart()
    offset = getPropertyFromClass('backend.ClientPrefs','data.noteOffset')
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    runTimer('vid',offset/1000)
    
end

function onTimerCompleted(tag)
    if tag == 'vid' then
        debugPrint('START VIDDEEEEOOEOOEOEO')
        callScript('scripts/videoSprite', 'makeVideoSprite', {'stuck', 'stuck', 62, -191, 'game', 0.7404, 0.7408, 1})
    end
end