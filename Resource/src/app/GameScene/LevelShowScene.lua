local LevelShowScene = class("LavelShowScene", function (  )
	return cc.Scene:create()
end)

function LevelShowScene:ctor()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
    	end
  	end

  	self:initWidget()
  	self:registerScriptHandler(onNodeEvent)
end

function LevelShowScene:initWidget()
	local level = UserDataManager.getInstance():getMapLevel()
	local life = UserDataManager.getInstance():getLife()
	local widget = cc.CSLoader:createNode("Scene/LevelShowLayer.csb")
	widget:setPosition(cc.p(display.cx/2, display.cy))

	local lifeText = widget:getChildByName("life")
	lifeText:setString(tostring(life))

	local levelText = widget:getChildByName("level")
	local str = string.format("%d - %d", 1, level)
	levelText:setString(str)
	self:addChild( widget )


	self.widget = widget
end

function LevelShowScene:onEnter() 
	local function getInStartScene()
		self:getInStartScene()
	end
	local act = cc.Sequence:create( cc.DelayTime:create(3),cc.FadeOut:create(2), cc.CallFunc:create(getInStartScene) )
	if self.widget then 
		self.widget:runAction(act)
	end
end

function LevelShowScene:getInStartScene()
	SceneManager.getInGameScene()
end

return LevelShowScene