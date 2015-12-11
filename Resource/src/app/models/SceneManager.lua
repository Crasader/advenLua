module( "SceneManager", package.seeall)

function createGameCutScene()
	local scene = require("app.GameScene.GameCutScene").new()
	return scene
end

function createStartScene()
	local scene = require("app.GameScene.StartScene").new()
	return scene
end

function createMainMenuScene()
	local scene = require("app.GameScene.MenuScene").new()
	return scene
end

--载入资源的场景
function createLoadingScene()
	local scene = require("app.GameScene.LoadingAssetScene").new()
	return scene
end

--显示关卡的场景
function createLevelScene()
	local scene = require("app.GameScene.LevelShowScene").new()
	return scene
end