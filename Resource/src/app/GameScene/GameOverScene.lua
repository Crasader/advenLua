local GameOverScene = class("GameOverScene", function (  )
	return cc.Scene:create()
end)

function GameOverScene:ctor(  )
	local layer = cc.LayerColor:create( cc.c4b(255, 255, 255, 255))
	self:addChild(layer)
	self.Layer = layer 
	self:initData()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

end

function GameOverScene:initData(  )
	
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
		panel:retain()
		panel:setPosition(cc.p(display.cx/2, display.cy  ))
		self.Layer:addChild(panel)
		self.rankPanel = panel
		-- self:connectTheSocket()
	end
end

function GameOverScene:connectTheSocket(  )
	local saveMgr = cc.UserDefault:getInstance()
	local score  = saveMgr:getIntegerForKey("Score", 0)
	local name = saveMgr:getStringForKey("Name", "AAA")

	--生成json字符串
	local tbl = {["Name"] = name, ["Score"] = score}
	local json = require("json")
	--获得带难度的字符串
	local str = json.encode(tbl)

	--创建socket连接
	local wsScocket =  cc.WebSocket:create("ws://112.74.214.142:4000")
	self.wsSocket = wsScocket
	local function wsOpen( strData )
		print("socket open")
		if cc.WEBSOCKET_STATE_OPEN == wsScocket:getReadyState() then
			self.wsSocket:sendString(str);
		end
	end

	local function wsMessage( strData )
		print("socket message"..strData)
	end

	local function wsClose( StrData )
		print("socket Close")
	end

	local function wsError( strData )
		print("socket Error")
	end

	wsScocket:registerScriptHandler(wsOpen,cc.WEBSOCKET_OPEN)
    wsScocket:registerScriptHandler(wsMessage,cc.WEBSOCKET_MESSAGE)
    wsScocket:registerScriptHandler(wsClose,cc.WEBSOCKET_CLOSE)
    wsScocket:registerScriptHandler(wsError,cc.WEBSOCKET_ERROR)
end

return GameOverScene