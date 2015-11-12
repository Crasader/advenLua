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
	self.typeId = const.BOSS
	self:setTag(const.BOSS)
	self.body = self:getChildByName("Body")
	self.time = 0
	self.hp = 3
end

function Boss001:commIntoGame(  )
	self:Walk()
	self:runAction(cc.Sequence:create(cc.MoveBy:create(2, cc.p(-display.cx, 0)), cc.CallFunc:create(handler(self, self.Idle) )))
end

function Boss001:Walk(  )
	self.act:play("walk", true)
end

function Boss001:Idle(  )
	self.act:play("idle", true)
end

function Boss001:Hited(  )
	self.act:play("hit", false)
	self.hp = self.hp - 1
	if self.hp <= 0 then 
		self:Died()
	end
end

function Boss001:Died(  )
	self.act:play("die", false)

	--死亡时候关闭调度器
	self:unscheduleUpdate()

	self:runAction(cc.Sequence:create( cc.DelayTime:create(1), cc.RemoveSelf:create(true) ))

	--发送boss死亡的事件
	local event = cc.EventCustom:new(EventConst.BOSS01_DIE)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)	
end

function Boss001:Shoot(  )
	self.act:play("shot", false)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(self.Idle)))

	local event = cc.EventCustom:new(EventConst.BOSS_SHOOT)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent( event )

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