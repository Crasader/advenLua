local MutiplayerScene = class("MutiplayerScene", function (  )
	return cc.Scene:create()
end)
local JSON = require("json")
function MutiplayerScene:ctor(  )
	self:connectTheServer()

	self:addMainObj()

	self:addTouchEvent()

end

function MutiplayerScene:connectTheServer(  )
	local wss = cc.WebSocket:create("ws://112.74.214.142:3000")


	local function wsSendTextOpen( strData )
	end

	local function wsSendTextMessage( strData )
		local strInfo = "response text msg:"..strData
		local pos = JSON.decode(strData)
		self.hero:setPosition(cc.p(pos.x, pos.y))
		self.hero:Attack()
	end

	local function wsSendTextClose( strData )
		if self.wss then
			self.wss = nil
			self:connectTheServer()
		end
	end

	local function wsSendTextError( strData )
		cc.Director:getInstance():endToLua()
	end

	wss:registerScriptHandler(wsSendTextOpen, cc.WEBSOCKET_OPEN)
	wss:registerScriptHandler(wsSendTextMessage, cc.WEBSOCKET_MESSAGE)
	wss:registerScriptHandler(wsSendTextError, cc.WEBSOCKET_CLOSE)
	wss:registerScriptHandler(wsSendTextError, cc.WEBSOCKET_ERROR)

	self.wss = wss

	
end

function MutiplayerScene:addMainObj(  )
	self.hero = require("app.views.Hero").new()
	self.hero:setPosition(cc.p(display.cx/2, display.cy))
	self:addChild(self.hero,10)
end

function MutiplayerScene:addTouchEvent(  )
	local listener = cc.EventListenerTouchOneByOne:create()

	local function touch_began( touch, event )
		local  pos = touch:getLocation()
		if self.wss then
			local json_pos = JSON.encode(pos)
			self.wss:sendString(json_pos)
		end
		return true
	end



	listener:registerScriptHandler( touch_began, cc.Handler.EVENT_TOUCH_BEGAN)

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end


return MutiplayerScene