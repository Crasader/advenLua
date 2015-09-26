local Army002 = class("Army002", function ()
	return cc.CSLoader:createNode("Npc/Npc1002.csb")
end)

function Army002:ctor( )
	self:initData()
	self.body:setFlippedX(true)
	self.act = cc.CSLoader:createTimeline("Npc/Npc1002.csb")
	self:runAction(self.act)
end

function Army002:initData(  )
	--设置随机数
	math.randomseed(os.time())
	
	self.typeId = 2

	self.body = self:getChildByName("Npc1002")
end

function Army002:Walk(  )
	self.act:play("walk", true)
end

function Army002:Idle(  )
	self.act:play("idle", true)
end

function Army002:Hited(  )
	self.act:play("hit", true)
end

function Army002:playDefeatEffect(  )
	self:Hited()
	local function dieEffect(  )
		local effect = require ("app.Effect.ArmyDieEffect").new()
		self:addChild(effect)
		effect:playEffect()
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(1.5), cc.CallFunc:create(dieEffect) ))
end

function Army002:setPhysics(  )
	self:setPhysicsBody(cc.PhysicsBody:createCircle(25))
	self:getPhysicsBody():setContactTestBitmask(1)
	self:getPhysicsBody():setRotationEnable(false)
	self:getPhysicsBody():getShape(0):setFriction(0)
end

function Army002:setSpeed( speed )
	self:getPhysicsBody():setVelocity(cc.p(speed.x, speed.y))
end

return Army002