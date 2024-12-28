local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		setProperty('canPause', true)
		startVideo('gunsCutscene');
		setObjectCamera('videoCutscene','other')
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end
function onDestroy()
    callMethod('remove', {instanceArg('videoCutscene'), true})
end