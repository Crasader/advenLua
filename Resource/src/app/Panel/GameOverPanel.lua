local GameOverPanel = class("GameOverPanel", function (  )
	return cc.CSLoader:createNode("Scene/GameOverLayer.csb")
end)

function GameOverPanel:ctor(  )
	self:initData()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)
end

function GameOverPanel:initData(  )
	local saveMgr = cc.UserDefault:getInstance()
	local highScore = saveMgr:getIntegerForKey("HighestScore", 0)
	local score  = saveMgr:getIntegerForKey("Score", 0)

	self.highScore = highScore
	self.score = score
end

function GameOverPanel:onEnter(  )
	--得到最高分数的text
	local highScoreTxt = self:getChildByName("highestPanel"):getChildByName("hightScore")
	highScoreTxt:setString(tostring(self.highScore))

	--得到自己分数的text
	local scoreTxt = self:getChildByName("scorePanel"):getChildByName("Score")
	scoreTxt:setString(tostring( self.score ))

	--得到三个按钮并且注册监听对应事件
	local btnFight = self:getChildByName("Button_Fight")
	local btnReturn = self:getChildByName("Button_Return")

	local btnRank = self:getChildByName("Button_Rank")

	--获取网络排名
	local function getRank( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		GameFuc.dispatchEvent( EventConst.IN_RANK )
	end

	btnRank:addTouchEventListener( getRank )
	
	local function goFight( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		local scene = require("app.GameScene.MenuScene").new()	
		cc.Director:getInstance():replaceScene(scene)
	end

	btnFight:addTouchEventListener( goFight )

	local function goReturn( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		cc.Director:getInstance():endToLua()
	end

	btnReturn:addTouchEventListener( goReturn )
	
	local ifno = cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
	print("ifno", ifno)
end

return GameOverPanel