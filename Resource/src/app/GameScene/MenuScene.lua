local MenuScene = class("MenuScene", function (  )
	return cc.Scene:create()
end)

function MenuScene:ctor(  )
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)
end

function MenuScene:onEnter(  )
	local isFirstPlay = self:isFirstPlay()
	--第一次玩就弹出创窗口让其输入姓名
	if isFirstPlay then 
		self:showNamePanel()
	else 
		self:showDifferentSelect()
	end

end

function MenuScene:isFirstPlay(  )
	local name = UserDataManager.getInstance():getPlayerName()
	if name ~= "" then 
		return false

	else return true
	end
end

function MenuScene:showNamePanel(  )
	local panel = PanelManager.createNamePanel()
	panel:setPosition(cc.p(display.cx/2, display.cy * 2))
	self:addChild(panel)
	panel:runAction(cc.MoveBy:create( 0.3, cc.p( 0,  - display.cy)))

	--监听事件,保存人物名字
	local textField = panel:getChildByName("TextField")

	local btn = panel:getChildByName("Button_Ok")
	local function onTouch( sender , eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		local name = textField:getString()

		if name ~= "" then 
			UserDataManager.getInstance():setPlayerName(name)

			local function goToNext(  )
				self:showDifferentSelect()	
			end

			panel:runAction(cc.Sequence:create(cc.MoveBy:create( 0.2, cc.p(0, display.cy)), cc.CallFunc:create( goToNext ) ))
		end
	end
	btn:addTouchEventListener( onTouch )

end

function MenuScene:showDifferentSelect(  )
	self:removeAllChildren()

	local panel = PanelManager.createDiffcutyPanel()
	panel:setPosition(cc.p(display.cx/2, display.cy * 2))
	local size = panel:getContentSize()
	panel:runAction(cc.MoveBy:create(0.3,  cc.p(0, -display.cy * 2 + size.height )))
	self:addChild(panel)
end

return MenuScene