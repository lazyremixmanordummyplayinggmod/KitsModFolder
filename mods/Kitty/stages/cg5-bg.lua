function onCreate()
	makeLuaSprite('bg', 'cg5/bg/mixroom', -480, -270);
	scaleObject('bg', 0.88, 0.88);
	updateHitbox('bg')
	setScrollFactor('bg', 0.9, 0.9)
	makeLuaSprite('bg1', 'cg5/bg/recordroom', -450, -200);
	scaleObject('bg1', 0.9, 0.9);
	updateHitbox('bg1')
	setScrollFactor('bg1', 0.9, 0.9)
	makeLuaSprite('extra', 'cg5/bg/ploosh', 990, 180);
	scaleObject('extra', 1, 1);
	updateHitbox('extra')
	setScrollFactor('extra', 0.9, 0.9)

	addLuaSprite('bg', false);
	addLuaSprite('extra', false);
	addLuaSprite('bg1', true);

	setObjectOrder("gfGroup", 15)
    setObjectOrder("boyfriendGroup", 17)
    setObjectOrder("dadGroup", 18)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end