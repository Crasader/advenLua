local RankPanel = class("RankPanel", function (  )
	return cc.CSLoader:createNode("Scene/RankLayer.csb")
end)

function RankPanel:ctor( )
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	--刚开始先设置为不可见，解析完毕才显示
  	for index = 1, 5 do
		local imgName = "Image_Rank"..index
		local panel = self:getChildByName(imgName)
		panel:setVisible(false)
	end
  	self:registerScriptHandler(onNodeEvent)
end

function RankPanel:onEnter(  )
	self:initData()
end
function RankPanel:initData(  )
	--获得其的难度
	local diffculty = UserDataManager.getInstance():getDifficulty()
	self.diffculty = diffculty


	self:createConnect()

end

function RankPanel:createConnect(  )
	local score  = UserDataManager.getInstance():getPlayerScore()
	local name = UserDataManager.getInstance():getPlayerName()

	--生成json字符串
	local tbl = {["Name"] = name, ["Score"] = score}
	local json = require("json")
	local str = string.format("%04d", self.diffculty)..json.encode(tbl)
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
		--socket关闭时候重新开始游戏
		 local scene = require("app.GameScene.MenuScene").new()
		cc.Director:getInstance():replaceScene(scene)
	end

	local function wsError( strData )
		print("socket Error")
		--socket关闭时候重新开始游戏
		local scene = require("app.GameScene.MenuScene").new()
		cc.Director:getInstance():replaceScene(scene)
	end

	wsScocket:registerScriptHandler(wsOpen,cc.WEBSOCKET_OPEN)
    wsScocket:registerScriptHandler(wsMessage,cc.WEBSOCKET_MESSAGE)
    wsScocket:registerScriptHandler(wsClose,cc.WEBSOCKET_CLOSE)
    wsScocket:registerScriptHandler(wsError,cc.WEBSOCKET_ERROR)

    --根据不同的难度显示不同的星星数量
  	local disappearTbl = {
  	[1] = {"Image_10", "Image_10_1", "Image_10_2", "Image_10_3"},
  	[2] = {"Image_10_4", "Image_10_0"},
  	[3] = {},
	  }

  	--获得难度系数
  	local tbl = disappearTbl[self.diffculty]
  	--隐藏对应的星星
  	for key, value in pairs (tbl) do
  		self:getChildByName(value):setVisible(false)
  	end

end

function RankPanel:deCodeMessage( str )
	local json = require("json")
	local scoreTbl = json.decode(str)
	--5个UI
	for index = 1, 5 do
		local imgName = "Image_Rank"..index
		local panel = self:getChildByName(imgName)
		panel:setVisible(true)
		local textName = string.format("Rank%02d", index)
		local textScore = string.format("Score%02d", index)

		local nameTex = panel:getChildByName(textName)

		local scoreTex = panel:getChildByName(textScore)

		nameTex:setString(tostring(scoreTbl[index].Name))

		scoreTex:setString(tostring(scoreTbl[index].Score))
	end

end

return RankPanel