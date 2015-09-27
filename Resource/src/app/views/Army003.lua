local Army003 = class("Army003", function ()
	return cc.CSLoader:createNode("Npc/Npc1003.csb")
end)

function Army003:ctor( )
	self:initData()
	self.body:setFlippedX(true)
	self.act = cc.CSLoader:createTimeline("Npc/Npc1003.csb")
	self:runAction(self.act)

	--设置怪物的大小
	local height = display.height
	local width = display.width
	local scaleFacX = width / CC_DESIGN_RESOLUTION.width
	local scaleFacY = height / CC_DESIGN_RESOLUTION.height

	self.scaleFactor = scaleFacX
	local scaleFactor = 1.5
	self.body:setScaleX(scaleFacX * scaleFactor)
	self.body:setScaleY(scaleFacY* scaleFactor)

end

function Army003:initData(  )
	--设置随机数
	math.randomseed(os.time())
	self.typeId = 3 

	self.body = self:getChildByName("Npc1003")
end

function Army003:Walk(  )
	self.act:play("walk", true)
end

function Army003:Idle(  )
	self.act:play("idle", true)
end

function Army003:Hited(  )
	self.act:play("hit", true)
end

function Army003:playDefeatEffect(  )
	self:Hited()
	self:playHitSound()
	local function dieEffect(  )
		local effect = require ("app.Effect.ArmyDieEffect").new()
		self:addChild(effect)
		effect:playEffect()
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(1.5), cc.CallFunc:create(dieEffect) ))
end

function Army003:playHitSound()
	AudioEngine.playEffect("music/effect/monster_damage.mp3", false)
end

function Army003:setPhysics()
	self:setPhysicsBody(cc.PhysicsBody:createCircle(30 * self.scaleFactor))
	self:getPhysicsBody():setContactTestBitmask(1)
	self:getPhysicsBody():setRotationEnable(false)
	self:getPhysicsBody():getShape(0):setFriction(0)
end

function Army003:setSpeed( speed )
	self:getPhysicsBody():setVelocity(cc.p(speed.x, speed.y))
end

return Army003