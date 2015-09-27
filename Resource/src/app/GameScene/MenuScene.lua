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
	local name = cc.UserDefault:getInstance():getStringForKey("Name", "")
	if name ~= "" then 
		return false
	else return true
	end
end

function MenuScene:showNamePanel(  )
	local panel = require("app.Panel.NamePanel").new()
	panel:setOpacity(0)
	panel:setPosition(cc.p(display.cx/2, display.cy))
	self:addChild(panel)
	panel:runAction(cc.FadeIn:create(1))

	--监听事件,保存人物名字
	local textField = panel:getChildByName("TextField")

	local btn = panel:getChildByName("Button_Ok")
	local function onTouch( sender , eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		local name = textField:getString()

		if name ~= "" then 
			cc.UserDefault:getInstance():setStringForKey("Name", name)

			local function goToNext(  )
				
				self:showDifferentSelect()	
			end

			textField:runAction(cc.Sequence:create(cc.FadeOut:create(1), cc.CallFunc:create( goToNext ) ))
		end
	end
	btn:addTouchEventListener( onTouch )
end

function MenuScene:showDifferentSelect(  )
	self:removeAllChildren()

	local panel = require("app.Panel.DiffcultPanel").new()
	panel:setPosition(cc.p(display.cx/2, display.cy))
	self:addChild(panel)
end

return MenuScene