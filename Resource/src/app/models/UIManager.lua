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

--创建时间
function createTimePanel()
	local panel = require("app.Panel.TimePanel").new()
	panel:setCameraMask(cc.CameraFlag.USER2)
	return panel
end

--创建控制器
function createGamePad()
	local panel = require("app.Panel.GamePadPanel").new()
	panel:setCameraMask(cc.CameraFlag.USER2)
	return panel
end

--创建技能栏
function createSkillPanel()
	local panel = require("app.Panel.SkillPanel").new()
	panel:setCameraMask(cc.CameraFlag.USER2)
	return panel
end