@echo off
color 0a
cd ..
@echo on
echo Installing dependencies...
echo This might take a few moments depending on your internet speed.
haxelib setup
git config --global --add safe.directory E:/folders/FNF/FNF-PsychEngine-Mobile-devbuild-13d5c08/.haxelib/flxanimate/git
git config --global --add safe.directory E:/folders/FNF/FNF-PsychEngine-Mobile-devbuild-13d5c08/.haxelib/lime/git
git config --global --add safe.directory E:/folders/FNF/FNF-PsychEngine-Mobile-devbuild-13d5c08/.haxelib/hxcpp/git
git config --global --add safe.directory E:/folders/FNF/FNF-PsychEngine-Mobile-devbuild-13d5c08/.haxelib/extension-androidtools/git
git config --global --add safe.directory E:/folders/FNF/FNF-PsychEngine-Mobile-devbuild-13d5c08/.haxelib/flixel/git
git config --global --add safe.directory E:\folders\FNF\FNF-PsychEngine-Mobile-devbuild-13d5c08\.haxelib\funkin,vis\git
git config --global --add safe.directory E:\folders\FNF\FNF-PsychEngine-Mobile-devbuild-13d5c08\.haxelib\grig,audio\git
haxelib git lime https://github.com/mcagabe19-stuff/lime
haxelib remove flixel
haxelib git flixel https://github.com/MobilePorting/flixel 5.6.1
haxelib install openfl 9.3.3
haxelib install flixel-addons 3.2.2
haxelib install flixel-tools 1.5.1
haxelib install hscript-iris 1.1.0
haxelib install tjson 1.4.0
haxelib install hxdiscord_rpc 1.2.4 --skip-dependencies
haxelib install hxvlc 1.9.2 --quiet --skip-dependencies
haxelib remove hxcpp
haxelib git hxcpp https://github.com/mcagabe19-stuff/hxcpp
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e
haxelib remove linc_luajit
haxelib git linc_luajit https://github.com/MobilePorting/linc_luajit-0.7plus
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90 --skip-dependencies
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666
haxelib git extension-androidtools https://github.com/MAJigsaw77/extension-androidtools --skip-dependencies
echo Finished!
pause
