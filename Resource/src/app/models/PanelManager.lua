module("PanelManager", package.seeall)

--显示姓名
function createNamePanel()
	local panel = require("app.Panel.NamePanel").new()
	return panel
end

--主菜单
function createMainMenuPanel()
	local panel = require("app.Panel.MainMenuPanel").new()
	return panel
end

--选角
function createSelectRolePanel()
	local panel = require("app.Panel.SelectRolePanel").new()
	return panel
end

--难度选择
function createDiffcutyPanel()
	local panel = require("app.Panel.DiffcultPanel").new()
	return panel
end

--排名界面
function createRankPanel()
	local panel = require("app.Panel.RankPanel").new()
	return panel 
end

--游戏结束界面
function createOverPanel()
	local panel = require("app.Panel.GameOverPanel").new()
	return panel
end

--游戏暂停
function createGameCutPanel()
	local panel = require("app.Panel.GameCutPanel").new()
	return panel
end

