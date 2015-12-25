module( "SceneManager", package.seeall)

function createGameCutScene()
	local scene = require("app.GameScene.GameCutScene").new()
	return scene
end

function createStartScene()
	local scene = require("app.GameScene.StartScene").new()
	return scene
end

--游戏失败界面
function createGameOverScene()
	local scene = require("app.GameScene.GameOverScene").new()
	return scene
end

--游戏成功，下一个关卡前界面
function createReadtNextLevelScene()
	local scene = SceneManager.createLevelScene()
	return scene
	-- SceneManager.getInLevelScene()
end

function createMainMenuScene()
	local scene = require("app.GameScene.MainMenuScene").new()
	return scene
end

--进入设置场景
function createSettingScene()
	local scene = require("app.GameScene.MenuScene").new()
	return scene
end

--进入游戏场景
function createMenuScene()
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

--进入游戏场景
function getInMenuScene()
	local scene = SceneManager.createMenuScene()
	cc.Director:getInstance():replaceScene(scene)
end

--进入设置场景
function getInSettingScene()
	local scene = SceneManager.createSettingScene()
	cc.Director:getInstance():replaceScene(scene)
end

--进入关卡场景
function getInLevelScene()
	local scene = SceneManager.createLevelScene()
	cc.Director:getInstance():replaceScene(scene)
end

--进入游戏场景
function getInGameScene()
	local scene = SceneManager.createStartScene()
	cc.Director:getInstance():replaceScene(scene)
end

--进入下一关场景
function getInNextLevelScene()
	AudioManager.stop()
	local scene = SceneManager.createReadtNextLevelScene()
	local wrapScene = cc.TransitionFade:create(1, scene, cc.c3b(0, 0, 0))
	cc.Director:getInstance():replaceScene(wrapScene)
end

--进入游戏结束结算界面
function getInOverScene()
	AudioManager.stop()
	local scene = SceneManager.createGameOverScene()
	local wrapScene = cc.TransitionFade:create(1, scene, cc.c3b(255, 0, 0))
	cc.Director:getInstance():replaceScene(wrapScene)
end