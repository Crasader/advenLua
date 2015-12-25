local MainMenuPanel = class("MainMenuPanel", function()
	return cc.CSLoader:createNode("Scene/MainMenu.csb")
	end)

function MainMenuPanel:ctor()
	--添加菜单按钮
	local itemSingle = cc.MenuItemFont:create("单人游戏")

	local function singleCallback( sender )
		self:EnterSingle()
	end

	itemSingle:registerScriptTapHandler( singleCallback )

	local itemMutiply = cc.MenuItemFont:create("多人游戏")
	local function mutiplyCallback( sender )
		self:EnterMutiply()
	end

	itemMutiply:registerScriptTapHandler(mutiplyCallback  )

	local itemSetting = cc.MenuItemFont:create("设置")
	local function settingCallback( sender )
		self:EnterSetting()
	end

	itemSetting:registerScriptTapHandler( settingCallback )

	local menu = cc.Menu:create()
	menu:addChild(itemSingle)
	menu:addChild(itemMutiply)
	menu:addChild( itemSetting )
	menu:setPosition(cc.p( display.cx/4, display.cy * 1.2  ))
	menu:alignItemsVerticallyWithPadding(50)
	menu:setAnchorPoint(cc.p(0.5, 0.0))
	menu:setOpacity(0)
	self:addChild(menu)
	self:setOpacity(0)
	local function runMenuAct()
		menu:runAction(cc.FadeIn:create(0.7))
	end
	local act = cc.Sequence:create( cc.FadeIn:create(1.3), cc.CallFunc:create( runMenuAct ) )
	self:runAction(act)

end

function MainMenuPanel:EnterSingle()
	SceneManager.getInMenuScene()
end

function MainMenuPanel:EnterMutiply()
	SceneManager.getInMenuScene()
end

function MainMenuPanel:EnterSetting()
	SceneManager.getInSettingScene()
end


return MainMenuPanel