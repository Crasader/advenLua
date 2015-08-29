local StartScene = class("StartScene", function (  )
	return cc.Scene:createWithPhysics()
end)

function StartScene:ctor(  )

	self:setPhysicsCondition()

	--添加物理世界框
	local wall = cc.Node:create()
	wall:setPosition(cc.p(display.cx, display.cy))
	self:addChild(wall)
	wall:setPhysicsBody(cc.PhysicsBody:createEdgeBox(cc.size(display.width,display.height)))


	local hero = require("app.views.Hero").new()
	hero:setPosition(cc.p(display.cx, display.cy))
	self:addChild(hero)
	--给英雄设置物理边框
	hero:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(200,275)))


  	local army = Army001:create()
  	army:Walk()
  	army:setPosition(cc.p(display.cx*3/2, display.cy))
  	self:addChild(army)
  	army:setPhysicsBody(cc.PhysicsBody:createCircle(25))


end

function StartScene:setPhysicsCondition(  )
	local physicsWorld = self:getPhysicsWorld()
	physicsWorld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
end
return StartScene

