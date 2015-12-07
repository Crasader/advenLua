local GameCutScene = class("GameCutScene", function ()
	return cc.Scene:create()
end)

function GameCutScene:ctor(  )
	local panel = require("app.Panel.GameCutPanel").new()
	panel:setPosition(cc.p( display.cx /2, display.height ))
	panel:setVisible(false)
	self:addChild( panel, 1)
	self.panel = panel
	

	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

  	self:addEvent()
end

function GameCutScene:onEnter()
	self.panel:MoveDown()
end

function GameCutScene:addEvent()
	local gameResumeEvent = cc.EventListenerCustom:create( EventConst.GAME_RESUME, handler(self, self.setOutBg) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(gameResumeEvent, self)
end

function GameCutScene:initWithTexture( tex )
	if self.bg then 
		self.bg:initWithTexture(tex)
		self:setBg()
		return 
	end

	
	local bg = cc.Sprite:createWithTexture(tex)
	self.bg = bg
	self:addChild(bg)
	self:setBg()
end

function GameCutScene:setBg()
	self.bg:setPosition(cc.p(display.cx, display.cy))
	self.bg:setFlippedY(true)
	local act = BlurFilter:create(1.0, 4, 5)
	self.bg:runAction(act)
end

function GameCutScene:setOutBg()
	self.bg:runAction(BlurFilter:create(0.2, 5, 0))
end

return GameCutScene