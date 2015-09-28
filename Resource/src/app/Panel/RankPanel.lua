local RankPanel = class("RankPanel", function (  )
	return cc.CSLoader:createNode("Scene/RankLayer.csb")
end)

function RankPanel:ctor( )
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

end

function RankPanel:onEnter(  )
	self:initData()
end
function RankPanel:initData(  )
	self:createConnect()

end

function RankPanel:createConnect(  )
	local saveMgr = cc.UserDefault:getInstance()
	local score  = saveMgr:getIntegerForKey("Score", 0)
	local name = saveMgr:getStringForKey("Name", "AAA")

	--生成json字符串
	local tbl = {["Name"] = name, ["Score"] = score}
	local json = require("json")
	local str = json.encode(tbl)
	print(str)
	print("RankPanel:createConnect~~~~~~~~~~~")
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
		if strData ~= "" then 
			self:deCodeMessage(strData)
		end
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

function RankPanel:deCodeMessage( str )
	local json = require("json")
	local scoreTbl = json.decode(str)
	for c, v in pairs (scoreTbl) do
		print(c, v)
	end
	--5个UI
	for index = 1, 5 do
		local imgName = "Image_Rank"..index
		local panel = self:getChildByName(imgName)

		local textName = string.format("Rank%02d", index)
		local textScore = string.format("Score%02d", index)

		local nameTex = panel:getChildByName(textName)

		local scoreTex = panel:getChildByName(textScore)

		nameTex:setString(tostring(scoreTbl[index].Name))

		scoreTex:setString(tostring(scoreTbl[index].Score))
	end

end

return RankPanel