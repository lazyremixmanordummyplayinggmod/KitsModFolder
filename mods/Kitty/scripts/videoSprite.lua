function makeVideoSprite(tag, videoPath, x, y, camera, aa, bb, zoom)
    startVideo(videoPath)
    setObjectCamera('videoCutscene',camera)
    screenCenter(videoPath)
    setProperty('canPause', true)
    setProperty('inCutscene', false)
    setProperty('camZooming', true)
    setProperty('camGame.zoom',zoom)
    setProperty('defaultCamZoom',zoom)
    setProperty('camZooming', false)
end

function onDestroy()
    callMethod('remove', {instanceArg('videoCutscene'), true})
end
function onPause()
    callMethod('videoCutscene.pause')
end

function onResume()
    callMethod('videoCutscene.resume')
end