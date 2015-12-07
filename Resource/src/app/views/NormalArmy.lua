local NormalArmy = class("NormalArmy", function ( fileTbl )
	return cc.CSLoader:createNode(fileTbl.fileName)
end)

function NormalArmy:ctor( fileTbl )
	if not fileTbl then return end

	self.fileTbl = fileTbl
	local fileName = fileTbl.fileName
	--因为没有添加到场景，其会被自动移除，所以可以直接指定 
	self.act = cc.CSLoader:createTimeline(fileName)
	self:runAction(self.act)

	self:initWidget()
	self:initData()

end
--数据有关
function NormalArmy:initData()
	--设置随机数
	math.randomseed(os.time())
	local id = self.fileTbl.id
	self.typeId = id
	self:setTag(const.NORMAL_ARMY)
end
--视图有关
function NormalArmy:initWidget()
	local bodyName = self.fileTbl.mainBody
	self.body = self:getChildByName( bodyName )
	self:getChildByName(bodyName):setFlippedX(true)

	local act =  BloomUp:create(1, 0.0, 0.3)
	self.body:runAction(cc.RepeatForever:create(cc.Sequence:create(act, act:reverse())))
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
end

--模型相关
function NormalArmy:Walk(  )
	self.act:play("walk", true)
end

function NormalArmy:Idle(  )
	self.act:play("idle", true)
end

function NormalArmy:Hited(  )
	self.act:play("hit", true)
end

function NormalArmy:playDefeatEffect(  )
	self:Hited()
	self:playHitSound()
	local function dieEffect(  )
		local effect = EffectFactory.createNorDieEffect()
		self:addChild(effect)
		effect:playEffect()
	end

	local act = cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(dieEffect) )
	self:runAction(act)
end

function NormalArmy:playHitSound(  )
	AudioManager.playArmyHitEffect()
end

function NormalArmy:setPhysics(  )
	self:setPhysicsBody(cc.PhysicsBody:createCircle(30 * self.scaleFactor))
	self:getPhysicsBody():setContactTestBitmask(1)
	self:getPhysicsBody():setRotationEnable(false)
	self:getPhysicsBody():getShape(0):setFriction(0)
end


function NormalArmy:setSpeed( speed )
	self:getPhysicsBody():setVelocity(cc.p(speed.x, speed.y))
end

return NormalArmy