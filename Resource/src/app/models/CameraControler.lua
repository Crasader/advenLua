local CameraControler = class("CameraControler" , function()
		return cc.Node:create()
	end)

function CameraControler:ctor( camera , heroPosition)
	self.mainCamera = camera or cc.Director:getInstance():getRunningScene():getDefaultCamera()
	self.heroPosition = heroPosition
	local x,y = self.mainCamera:getPosition()
	self.originPosition = cc.p(x,y)
	self:init()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end
  	self:registerScriptHandler(onNodeEvent)
end


function CameraControler:init()
	self.mainCamera:initPerspective( 45, display.width/display.height, 10, 10000 )
	self.mainCamera:setPositionZ(0.1)
	self.mainCamera:setPosition(self.heroPosition)
	self:addMapCamera()
	--添加控制UI的Camera
	self:addUICamera()
	self:runAllCameraInAction()
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
	local mapAct2 = cc.MoveBy:create(5, cc.p(display.width, 0))
	self.mapCamera:runAction( mapAct1 )

	local function dispatchMapEvent()
		local event = cc.EventCustom:new(EventConst.CHANGE_MAP)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
	end

	local mapAct3 = cc.Sequence:create(cc.DelayTime:create(40), mapAct2, cc.CallFunc:create(dispatchMapEvent))
	self.mapCamera:runAction(cc.RepeatForever:create(mapAct3))
	self.uiCamera:setPositionZ(display.height * 1.2)
end


return CameraControler