local DiffcultPanel = class("DiffcultPanel",function (  )
	return cc.CSLoader:createNode("Scene/DiffcultLayer.csb")
end )

function DiffcultPanel:ctor(  )
	local tbl = {["Button_Easy"] = 1 ,
			["Button_Normal"] = 2,
			["Button_Hard"] = 3,
	}

	for key, value in pairs (tbl) do
		local btn = self:getChildByName(key)

		--添加事件
		local function onTouch( sender, eventType )
			if eventType ~= ccui.TouchEventType.ended then return end
			cc.UserDefault:getInstance():setIntegerForKey("Diffcuity", value)
			self:getToStart()
			
		end

		btn:addTouchEventListener( onTouch )
	end
end

function DiffcultPanel:getToStart(  )
	local scene  = require("app/GameScene/StartScene").new()
	cc.Director:getInstance():replaceScene(scene)
end

return DiffcultPanel