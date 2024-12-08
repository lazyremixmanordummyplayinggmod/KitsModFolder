local camzoom = false;
local v1 = 0
local v2 = 0

function getVarr(bu)
   bugged = bu
end

function onEvent(name, value1, value2)
   if name == 'CustomZoom Up' then
      value1 = tonumber(value1)
      value2 = tonumber(value2)
      v1 = value1
      v2 = value2
      if camzoom == false then
         camzoom = true
         runTimer("zoomCam", 0.025)
      elseif camzoom == true then
         camzoom = false
      end
      if bugged then
         v1 = (v1/2)
         v2 = (v2/2)
      end
      fpss = getPropertyFromClass('flixel.FlxG', 'drawFramerate')
      if not bugged then
         v1 = value1
         v2 = value2
      end
   end
end

function onTimerCompleted(tag)
   if tag == 'zoomCam' then
      setProperty('camGame.zoom',getProperty("camGame.zoom")+v2)
      setProperty('camHUD.zoom',getProperty("camHUD.zoom")+v1)
      if camzoom then
         runTimer("zoomCam", 0.025)
      end
   end
end