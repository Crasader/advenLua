local CameraControler = class("CameraControler" , function()
		return cc.Node:create()
	end)

function CameraControler:ctor( camera , heroPosition)
	self.mainCamera = camera or cc.Director:getInstance():getRunningScene():getDefaultCamera()
	self.heroPosition = heroPosition
	local x,y = self.mainCamera:getPosition()
	self.originPosition = cc.p(x,y)
	self:init()
	self:addEvent()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end
  	self:registerScriptHandler(onNodeEvent)
end

function CameraControler:addEvent()
	local eventListener = cc.EventListenerCustom:create(EventConst.SCROLL_VIEW, handler(self, self.playMoveAction))
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(eventListener, self)

	local eventListenerArmyDie = cc.EventListenerCustom:create(EventConst.ALL_DIE, handler(self, self.MoveBgView))
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(eventListenerArmyDie, self)
end

--移动摄像机
function CameraControler:MoveBgView()
	--发送事件移动摄像机
	GameFuc.dispatchEvent( EventConst.SCROLL_VIEW)
end

function CameraControler:init()
	self.mainCamera:initPerspective( 45, display.width/display.height, 10, 10000 )
	self.mainCamera:setPositionZ(0.1)
	self.mainCamera:setPosition(self.heroPosition)
	self:addMapCamera()
	--添加控制UI的Camera
	self:addUICamera()
	self:runAllCameraInAction()

	self:setIsCanMove( true)
end

function CameraControler:addMapCamera()
	local mapCamera = self:createCamera(cc.CameraFlag.USER1)
	self.mapCamera = mapCamera
	self:addChild(mapCamera)
end

function CameraControler:addUICamera()
	local uiCamera = self:createCamera( cc.CameraFlag.USER2)
	self.uiCamera = uiCamera
	self:addChild(uiCamera)
end

function CameraControler:createCamera( cameraFlag )
	local camera = cc.Camera:create()
	camera:setCameraFlag(cameraFlag)
	camera:initPerspective( 45, display.width/display.height, 10, 10000 )
	camera:setPositionZ(display.height * 0.2)
	camera:setDepth(-1)
	return camera
end

function CameraControler:onEnter()

end

function CameraControler:runAllCameraInAction()
	local deltaPoint = cc.p(self.originPosition.x - self.heroPosition.x, self.originPosition.y - self.heroPosition.y)
	local winSize = cc.Director:getInstance():getWinSize()
	local act1 = cc.MoveBy:create(0.8, cc.vec3(0, 0, winSize.height * 1.2 ))
	local act2 = cc.MoveBy:create(0.8, deltaPoint)
	self.mainCamera:runAction( cc.Spawn:create( act1, act2 )) 

	local mapAct1 = cc.MoveBy:create(0.8, cc.vec3(0, 0, display.height)) 
	
	self.mapCamera:runAction( mapAct1 )

	
	self.uiCamera:setPositionZ(display.height * 1.2)
end

function CameraControler:playMoveAction()

	--派发设置下个背景的事件
	local function dispatchMapEvent()
		local event = cc.EventCustom:new(EventConst.CHANGE_MAP)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
		self:setIsCanMove( true)
	end

	--派发继续创建怪物的事件
	local function dispatchContinuePKEvent()
		local event = cc.EventCustom:new(EventConst.NEXT_ROUND)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
	end

	local mapAct2 = cc.MoveBy:create(5, cc.p(display.width, 0))
	local act = cc.Sequence:create( mapAct2, cc.CallFunc:create(dispatchMapEvent), cc.CallFunc:create(dispatchContinuePKEvent))
	if self:isCanMoveView() then
		self:setIsCanMove( false)
		self.mapCamera:runAction(act)
	end
end

function CameraControler:setIsCanMove( isMove )
	self.isCanMoveCamera_  = isMove
end

function CameraControler:isCanMoveView()
	return self.isCanMoveCamera_ 
end

return CameraControler