local HPPanel = class("HPPanel", function()
		return cc.CSLoader:createNode("MainUI/HP.csb")
	end)
function HPPanel:ctor()
	self:setScaleY(2.0)

	self:initData()
end

function HPPanel:initData()

	self.heroHpBar = self:getChildByName("HP")

end

--设置血条值
function HPPanel:setHp( value)
	if not value then return end

	self.heroHpBar:setPercent(value)
end


return HPPanel