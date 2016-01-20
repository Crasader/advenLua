module("PhysicsManager", package.seeall)

--创建游戏的边界
function createWall()
	local wall = cc.Node:create()
	wall:setTag(const.WALL)
	local staticMaterial = cc.PhysicsMaterial(1500 ,0.0, 0.0);
	local points = {cc.p(0, 0), 
					cc.p(display.cx, 0),
					cc.p(display.cx, display.cy /2),
					cc.p(display.cx + 200, display.cy/2),
					cc.p(display.cx + 200, 0),
					cc.p(display.width, 0)
	}

	local points2 = {cc.p(display.width * 1.2, 0),
					cc.p(display.width * 1.5, 0),
					cc.p(display.width * 1.5, 200),
					cc.p(display.width * 2.0, 200),
					cc.p(display.width * 2.0, 0),
					cc.p(display.width * 4.0, 0)

	}
	local physicsBody = cc.PhysicsBody:createEdgePolygon(points)
	physicsBody:addShape(cc.PhysicsShapeEdgePolygon:create(points2))
	wall:setPhysicsBody(physicsBody)

	wall:getPhysicsBody():setContactTestBitmask(1)
	return wall
end

--创建死亡碰撞器
function createDeadBox()
	local box = cc.Node:create()
	box:setTag(const.DEAD_BOX)
	local staticMaterial = cc.PhysicsMaterial(cc.PHYSICS_INFINITY,0.0, cc.PHYSICS_INFINITY);
	local points = {cc.p(0, 20), 
					cc.p(display.width * 4, 20)
	}

	box:setPhysicsBody(cc.PhysicsBody:createEdgePolygon(points))
	box:getPhysicsBody():setContactTestBitmask(1)
	return box
end

--解决碰撞
function dealPhyContact(contact)
	
end