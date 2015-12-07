local NormalAttackEffect = class("NormalAttackEffect", function (  )
	return cc.CSLoader:createNode("Effect/attackEffect.csb")
end)

function NormalAttackEffect:ctor()

	self:initData()

	self:addEvent()

	self:runAction(self.effectTimeLine)
end

function NormalAttackEffect:initData()
	self.effectTimeLine = cc.CSLoader:createTimeline("Effect/attackEffect.csb")

end

function NormalAttackEffect:addEvent()
	local function onFrameEvent( frame )
		if nil == frame then
			return 
		end

		local str = frame:getEvent()
		if str == "end" then
			self:setVisible(false)
		end

		if str == "start" then
			self:setVisible(true)
		end
	end
	self.effectTimeLine:setFrameEventCallFunc(onFrameEvent)
end

function NormalAttackEffect:setSpeed( speed )
	if not speed then return end
	self.effectTimeLine:setTimeSpeed(3)
end

function NormalAttackEffect:Strike()
	self.effectTimeLine:play("Strike", false)
end

return NormalAttackEffect