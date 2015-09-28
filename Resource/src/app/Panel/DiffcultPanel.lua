local DiffcultPanel = class("DiffcultPanel",function (  )
	return cc.CSLoader:createNode("Scene/DiffcultLayer.csb")
end )

function DiffcultPanel:ctor(  )
	--得到文本框
	local text = self:getChildByName("Text_1")
	text:setVisible(false)
	text:setFontSize(32)
	text:runAction(cc.MoveBy:create(0.05, cc.p(0, -50)))

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

			local function GoToNext(  )
				self:getToStart()
				
			end
			self:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, display.cy)), cc.CallFunc:create(GoToNext)))
			
		end

		btn:addTouchEventListener( onTouch )
	end
end

function DiffcultPanel:getToStart(  )
	local scene  = require("app/GameScene/StartScene").new()
	cc.Director:getInstance():replaceScene(scene)
end

return DiffcultPanel