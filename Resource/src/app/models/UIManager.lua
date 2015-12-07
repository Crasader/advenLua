module("UIManager", package.seeall)

--创建暂停按钮
function createCutBtn()
	local panel  = require("app.Panel.ZantingPanel").new()
	panel:setCameraMask(cc.CameraFlag.USER2)
	return panel
end

--创建血条
function createHpBar()
	local panel = require("app.Panel.HPPanel").new()
	panel:setCameraMask(cc.CameraFlag.USER2)
	return panel
end

--创建分数
function createScorePanel()
	local panel = require("app.Panel.ScorePanel").new()
	panel:setCameraMask(cc.CameraFlag.USER2)
	return panel
end