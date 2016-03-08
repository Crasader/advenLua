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

	local pointsTbl = {[1] = {cc.p(display.width * 1.2, 0),
							cc.p(display.width * 1.5, 0),
							cc.p(display.width * 1.5, 0),
							cc.p(display.width * 2.0, 0),
							cc.p(display.width * 2.0, 0),
							cc.p(display.width * 4.0, 0)
						},
					[2] = {	cc.p(display.width * 4.2, 0),
							cc.p(display.width * 4.5, 0),
							cc.p(display.width * 4.5, 0),
							cc.p(display.width * 5.0, 0),
							cc.p(display.width * 5.0, 0),
							cc.p(display.width * 6.0, 0)
						},
					[3] = { cc.p(display.width * 6.3, 0),
							cc.p(display.width * 6.7, 0),
							cc.p(display.width * 6.7, 200),
							cc.p(display.width * 7.0, 200),
							cc.p(display.width * 7.2, 0),
							cc.p(display.width * 7.5, 0)
						},
					[4] = { cc.p(display.width * 7.7, 0),
							cc.p(display.width * 8.0, 0),
							cc.p(display.width * 8.3, 0),
							cc.p(display.width * 8.3, 200),
							cc.p(display.width * 9.0, 200),
							cc.p(display.width * 9.0, 0),
							cc.p(display.width * 10.0, 0)
						},
					[5] = { cc.p(display.width * 10.2, 200),
							cc.p(display.width * 10.5, 200),
							cc.p(display.width * 10.5, 0),
							cc.p(display.width * 13.0, 0),
							cc.p(display.width * 13.0, 200),
							cc.p(display.width * 13.5, 200),
							cc.p(display.width * 13.5, 0),
							cc.p(display.width * 14.0, 0 )
						},
					[6] = { cc.p(display.width * 14.2, 100),
							cc.p(display.width * 14.5, 100),
							cc.p(display.width * 14.5, 300),
							cc.p(display.width * 15.0, 300),
							cc.p(display.width * 15.0, 0),
							cc.p(display.width * 18.5, 0),
							cc.p(display.width * 18.5, 0),
							cc.p(display.width * 20.0, 0 )
						}
			}


	local physicsBody = cc.PhysicsBody:createEdgeChain(points)
	for idx , points in pairs ( pointsTbl ) do
		physicsBody:addShape(cc.PhysicsShapeEdgeChain:create(points))
	end
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
					cc.p(display.width * 20, 20)
	}

	box:setPhysicsBody(cc.PhysicsBody:createEdgePolygon(points))
	box:getPhysicsBody():setContactTestBitmask(1)
	return box
end

--解决碰撞
function dealPhyContact(contact)
	
end