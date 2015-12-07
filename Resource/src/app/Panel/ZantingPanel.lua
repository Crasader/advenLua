local ZantingPanel = class("ZantingPanel", function()
		return cc.CSLoader:createNode("MainUI/ZanTingBTN.csb")
	end)
function ZantingPanel:ctor()
	self:setScale(2)

	--得到按钮并且设置监听
	local btn = self:getChildByName("Button")
	local function onTouch( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		local event = cc.EventCustom:new(EventConst.GAME_CUT)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
	end
	btn:addTouchEventListener( onTouch )
end


return ZantingPanel