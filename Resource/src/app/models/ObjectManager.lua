module("ObjectManager", package.seeall)

--创建摄像机控制器
function createCameraControl( camera  , pos)
	local control = require("app.models.CameraControler").new(camera, pos)
	return control
end

--创建地图控制器
function createMapControl( map1, map2 )
	local control = require("app.models.MapController").new(map1, map2)
	return control
end
