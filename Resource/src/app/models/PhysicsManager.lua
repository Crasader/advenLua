module("PhysicsManager", package.seeall)

--创建游戏的边界
function createWall()
	local wall = cc.Node:create()
	wall:setTag(const.WALL)
	local staticMaterial = cc.PhysicsMaterial(cc.PHYSICS_INFINITY,0.0, cc.PHYSICS_INFINITY);
	wall:setPhysicsBody(cc.PhysicsBody:createEdgeBox(cc.size(display.width*4,display.height * 2)))
	wall:getPhysicsBody():setContactTestBitmask(1)
	return wall
end