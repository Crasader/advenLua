module("LevelFactory", package.seeall)

function createLavel1(  )
	local backGround = require("app.views.MainBg").new()
	backGround:setCameraMask(cc.CameraFlag.USER1)
	return backGround
end