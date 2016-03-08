module("LevelFactory", package.seeall)

function createLevel_1(  )
	local backGround = require("app.views.MainBg").new(MAP_DATA[1])
	backGround:setCameraMask(cc.CameraFlag.USER1)
	return backGround
end

function createLevel_2()
	local backGround = require("app.views.MainBg").new(MAP_DATA[2])
	backGround:setCameraMask(cc.CameraFlag.USER1)
	return backGround
end

function createLevel_3()
	local backGround = require("app.views.MainBg").new(MAP_DATA[3])
	backGround:setCameraMask(cc.CameraFlag.USER1)
	return backGround
end

function createLevel( id )
	local backGround = require("app.views.MainBg").new(MAP_DATA[id])
	backGround:setCameraMask(cc.CameraFlag.USER1)
	return backGround
end

--根据索引获取地图
function createLevelByIndex(index)
	if not index then return end
	if index == 1 then 
		return createLevel_1()
	elseif index == 2 then 
		return createLevel_2()
	elseif index == 3 then 
		return createLevel_3()
	else
		return createLevel(index)
	end

	return createLevel_1()
end
