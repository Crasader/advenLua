local MainBg = class("MainBg", function (  )
	return cc.CSLoader:createNode("Level/Level1.csb")
end)

function MainBg:ctor(  )
	local size = cc.Director:getInstance():getVisibleSize()
	local scaleFactorY = size.height / self:getContentSize().height
	self:setScaleY(scaleFactorY)
	local scaleFactorX = size.width / self:getContentSize().width
	self:setScaleX(scaleFactorX)

end


return MainBg