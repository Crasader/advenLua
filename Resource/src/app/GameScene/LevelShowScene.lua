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
	local str = string.format("第%d关",level)
	local title = cc.Label:createWithSystemFont(str, "Courier", 24)
	title:setVisible(true)
	title:setPosition(cc.p(display.cx, display.cy))
	self:addChild(title,1,"levelName")
	self.title = title
end

function LevelShowScene:onEnter()
	if self.title then 
		local function getInStartScene()
			self:getInStartScene()
		end
		local act = cc.Sequence:create( cc.FadeOut:create(2), cc.CallFunc:create(getInStartScene) )
		self.title:runAction(act)
	end
end

function LevelShowScene:getInStartScene()
	local scene = SceneManager.createStartScene()
	cc.Director:getInstance():replaceScene(scene)
end

return LevelShowScene