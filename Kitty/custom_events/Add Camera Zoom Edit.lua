function getVarr(bu)
   bugged = bu
end

function onEvent(name, value1, value2)
   if name == 'Add Camera Zoom Edit' then
      value1 = tonumber(value1)
      value2 = tonumber(value2)
      v1 = value1
      v2 = value2
      if bugged then
         v1 = (value1/3.9)
         v2 = (value2/3.9)
      end
      fpss = getPropertyFromClass('flixel.FlxG', 'drawFramerate')
      if not bugged then
         v1 = value1
         v2 = value2
      end
      setProperty('camGame.zoom',getProperty("camGame.zoom")+v2)
      setProperty('camHUD.zoom',getProperty("camHUD.zoom")+v1)
   end
end