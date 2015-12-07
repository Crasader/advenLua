local DiffcultPanel = class("DiffcultPanel",function (  )
	return cc.CSLoader:createNode("Scene/DiffcultLayer.csb")
end )

function DiffcultPanel:ctor(  )
	--得到文本框
	local text = self:getChildByName("Text_1")
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
	local panel = PanelManager.createSelectRolePanel()

	panel:setPosition(cc.p(display.cx/2, display.cy * 2 ))
	local size = panel:getContentSize()
	panel:runAction(cc.MoveBy:create(0.3,  cc.p(0, -display.cy * 2 + size.height )))
	self:getParent():addChild(panel)

end



return DiffcultPanel