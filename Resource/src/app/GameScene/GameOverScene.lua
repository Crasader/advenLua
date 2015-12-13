local GameOverScene = class("GameOverScene", function (  )
	return cc.Scene:create()
end)

function GameOverScene:ctor(  )
	local layer = cc.LayerColor:create( cc.c4b(255, 255, 255, 255))
	self:addChild(layer)
	self.Layer = layer 
	self:addEvent()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

end

function GameOverScene:initData(  )
	UserDataManager.getInstance():initDefault()
end

function GameOverScene:addEvent()
	--添加排名界面回调事件
	local rankListener = cc.EventListenerCustom:create( EventConst.IN_RANK, handler(self, self.InRank) )
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(rankListener, self)
end

function GameOverScene:InRank()
	local function goNext(  )
		self:showRank()
	end
	if self.rankPanel then return end
	local panel = self.scorePanel
	if not panel then return end
	panel:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, -display.cy)), cc.CallFunc:create( goNext) ))
end

function GameOverScene:onEnter(  )
	if self.scorePanel then return end
	local panel = PanelManager.createOverPanel()
	panel:setPosition( cc.p( display.cx/ 2, display.cy * 2))
	panel:runAction(cc.MoveBy:create(0.3, cc.p(0, -display.cy)))
	self.Layer:addChild(panel)
	self.scorePanel = panel 
	self:initData()
end

function GameOverScene:showRank(  )
	if not self.rankPanel then 
		local panel = PanelManager.createRankPanel()
		panel:retain()
		panel:setPosition(cc.p(display.cx/2, display.cy  ))
		self.Layer:addChild(panel)
		self.rankPanel = panel
	end
end
return GameOverScene