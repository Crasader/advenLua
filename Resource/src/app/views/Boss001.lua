local Boss001 = class("Boss001", function ()
	return cc.CSLoader:createNode("Npc/Boss001.csb")
end)

function Boss001:ctor( )
	self:initData()
	self:getChildByName("Body"):setFlippedX(true)
	self.act = cc.CSLoader:createTimeline("Npc/Boss001.csb")
	self:runAction(self.act)

	--设置怪物的大小
	local height = display.height
	local width = display.width
	local scaleFacX = width / CC_DESIGN_RESOLUTION.width
	local scaleFacY = height / CC_DESIGN_RESOLUTION.height
	--游戏是横屏的有限考虑横屏
	self.scaleFactor = scaleFacX
	local scaleFactor = 1.5
	self:setScaleX(scaleFacX  * scaleFactor)
	self:setScaleY(scaleFacY * scaleFactor)

	self:scheduleUpdateWithPriorityLua(handler(self, self.scheduleAct), 1)
end

function Boss001:initData(  )
	--设置随机数
	math.randomseed(os.time())
	self.typeId = 1
	self:setTag(10)
	self.body = self:getChildByName("Body")
	self.time = 0
end

function Boss001:Walk(  )
	self.act:play("walk", true)

	self:runAction(cc.Sequence:create(cc.MoveBy:create(2, cc.p(-display.cx, 0)), cc.CallFunc:create(handler(self, self.Idle) )))
end

function Boss001:Idle(  )
	self.act:play("idle", true)
end

function Boss001:Hited(  )
	self.act:play("hit", true)
end

function Boss001:Died(  )
	self.act:play("die", false)
end

function Boss001:Shoot(  )
	self.act:play("shot", false)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(self.Idle)))
end

function Boss001:scheduleAct( dt )
	--设置状态机处理boss
	self.time = self.time + dt
	--一秒发射一个
	if self.time >= 2 then 
		self:Shoot()
		self.time = 0
	end
end

function Boss001:playDefeatEffect(  )
	self:Hited()
	self:playHitSound()
	local function dieEffect(  )
		local effect = require ("app.Effect.ArmyDieEffect").new()
		self:addChild(effect)
		effect:playEffect()
	end

	local act = cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(dieEffect) )
	self:runAction(act)
end

function Boss001:playHitSound(  )
	AudioEngine.playEffect("music/effect/monster_damage.mp3", false)
end

function Boss001:setPhysics(  )
	self:setPhysicsBody(cc.PhysicsBody:createCircle(180* self.scaleFactor))
	self:getPhysicsBody():setPositionOffset(cc.p(100, 0))
	self:getPhysicsBody():setContactTestBitmask(1)
	self:getPhysicsBody():setRotationEnable(false)
	self:getPhysicsBody():getShape(0):setFriction(0)
end

function Boss001:setSpeed( speed )
	self:getPhysicsBody():setVelocity(cc.p(speed.x, speed.y))
end

return Boss001