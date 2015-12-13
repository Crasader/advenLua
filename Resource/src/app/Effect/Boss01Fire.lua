local  Boss01Fire = class("Boss01Fire", function ( fileName )
	return cc.CSLoader:createNode( fileName )
end)

function Boss01Fire:ctor( fileName )
	self:initData( fileName )
	self:setPhysics()
end

function Boss01Fire:initData( fileName )
	local act = cc.CSLoader:createTimeline( fileName )
	self.act = act
	self.body = self:getChildByName("Fire")
	self:runAction(act)

	--子弹
	self.typeId = const.BULLET
	self:setTag(const.BULLET)
	self.dir = const.DIRECTTOR_LEFT
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

function Boss01Fire:setPhysics(  )
	self:setPhysicsBody(cc.PhysicsBody:createCircle(30 * self.scaleFactor))
	local phyBody = self:getPhysicsBody()
	phyBody:setContactTestBitmask(1)
	phyBody:setRotationEnable(false)
	phyBody:getShape(0):setFriction(0)
	phyBody:setGravityEnable(false)
	self:setNormalOffset()
end

function Boss01Fire:setNormalOffset()
	local phyBody = self:getPhysicsBody()
	-- phyBody:setPositionOffset(cc.p( -280, 0 ))
end
function Boss01Fire:setSpeed( speed )
	self:getPhysicsBody():setVelocity(cc.p(speed.x, speed.y))
end

function Boss01Fire:getSpeed()
	return self:getPhysicsBody():getVelocity()
end

function Boss01Fire:reverseSpeed(  )
	local speed = self:getSpeed()
	self:getPhysicsBody():setVelocity( cc.p( -speed.x, speed.y ) )
	self.body:runAction(cc.RotateBy:create(0.1, cc.vec3(180, 0, 0)))
	--设置相反方向的偏移
	self:setReverseOffset()
	self.dir = const.DIRECTTOR_RIGHT
end

function Boss01Fire:setReverseOffset()
	local phyBody = self:getPhysicsBody()
	-- phyBody:setPositionOffset(cc.p( -280 - 70, 0 ))
end

function Boss01Fire:Fire(  )
	self.act:play( "Fly", true )
	self:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.RemoveSelf:create(true)))
end

return Boss01Fire