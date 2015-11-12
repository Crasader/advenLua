module("LevelFactory", package.seeall)

function createLavel1(  )
	local backGround = require("app.views.MainBg").new()
	return backGround
end