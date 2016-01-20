local MapController = class("MapController", function (  )
	return cc.Node:create()
end)

function MapController:ctor( map )
	if not map then 
		print("there is no map")
		return 
	end
	self.map_ = map
	self:init()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end
  	self:registerScriptHandler(onNodeEvent)
end

function MapController:init()
	self:initEvent()
	self:initData()
end

function MapController:initData()
	local size = self.map_:getContentSize()
	--测试例子，设置地图大小
	local MapSize = cc.size(size.width * 2, size.height)
	GameDataManager.getInstance():saveMapSize(MapSize)
end

function MapController:initEvent()
end

function MapController:onEnter(  )
	
end

return MapController