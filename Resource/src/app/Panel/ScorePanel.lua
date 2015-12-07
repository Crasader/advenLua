local ScorePanel = class("ScorePanel", function (  )
	return cc.CSLoader:createNode("MainUI/Score.csb")
end)

function ScorePanel:ctor()

	self:initData()
end

function ScorePanel:initData()
	self.score = self:getChildByName("Score")

end

function ScorePanel:setScore( value )
	if not value then return end
	if not self.score then return end
	self.score:setText("Score:"..value)
end

return ScorePanel