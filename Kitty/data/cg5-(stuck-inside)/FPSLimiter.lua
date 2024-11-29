local limit = 120

--Edit limit variable to whatever you want

function onCreate()
  fps = getPropertyFromClass('backend.ClientPrefs', 'data.framerate')
  if fps > limit then
    setPropertyFromClass('backend.ClientPrefs', 'data.framerate', limit)
  end
end

function onDestroy()
  setPropertyFromClass('backend.ClientPrefs', 'data.framerate', fps)
end
--This is set based off my performance, change it if you don't want to limit fps