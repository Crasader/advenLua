local GameCutPanel = class("GameCutPanel", function()  
	return cc.CSLoader:createNode("Scene/ResumeMenuLayer.csb")
	end)
function GameCutPanel:ctor()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)
end

function GameCutPanel:onEnter()
	--继续游戏
	local function continueGame(sender, eventType)
		if eventType ~= ccui.TouchEventType.ended then return end
		self:GoBack()
	end

	local continueBtn = self:getChildByName("Button_Fight")
	continueBtn:addTouchEventListener( continueGame )

	--退出游戏
	local function endGame(sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		self:EndGame()
	end

	local endBtn = self:getChildByName("Button_Quit")
	endBtn:addTouchEventListener( endGame )
end

function GameCutPanel:MoveDown()
	UIFunc.MoveDown( self , display.cy, 0.2)
end

function GameCutPanel:EndGame()
	cc.Director:getInstance():endToLua()
end

function GameCutPanel:GoBack()
	local function resume()
		cc.Director:getInstance():popScene()
	end

	local function dispatchEve()
		local event = cc.EventCustom:new(EventConst.GAME_RESUME)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
	end

	local act = cc.Sequence:create( cc.CallFunc:create(dispatchEve),cc.MoveBy:create(0.2, cc.p(0 , display.cy)) , cc.CallFunc:create(resume)  )
	self:runAction(act)
	
end




return GameCutPanel