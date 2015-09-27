local GameOverScene = class("GameOverScene", function (  )
	return cc.Scene:create()
end)

function GameOverScene:ctor(  )
	local layer = cc.LayerColor:create( cc.c4b(255, 255, 255, 255))
	self:addChild(layer)
	self.Layer = layer 
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

end

function GameOverScene:onEnter(  )
	if self.scorePanel then return end
	local panel = require("app.Panel.ScorePanel").new()
	panel:setPosition( cc.p( display.cx/ 2, display.cy * 2))
	panel:runAction(cc.MoveBy:create(0.3, cc.p(0, -display.cy)))
	self.Layer:addChild(panel)
	self.scorePanel = panel 

	local btnRank = panel:getChildByName("Button_Rank")

	--获取网络排名
	local function getRank( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		local function goNext(  )
			self:showRank()
		end
		if self.rankPanel then return end
		panel:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, -display.cy)), cc.CallFunc:create( goNext) ))
	end

	btnRank:addTouchEventListener( getRank )
end

function GameOverScene:showRank(  )
	if not self.rankPanel then 
		local panel = require("app.Panel.RankPanel").new()
		panel:setPosition(cc.p(display.cx/2, display.cy  ))
		self.Layer:addChild(panel)
		self.rankPanel = panel
	end
end

return GameOverScene