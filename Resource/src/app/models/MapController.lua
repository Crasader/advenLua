local MapController = class("MapController", function (  )
	return cc.Node:create()
end)

function MapController:ctor( map1, map2 )
	if not map1 or not map2 then 
		print("there is not map1 or map2")
		return 
	end

	self.map1 = map1
	self.map2 = map2
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
end

function MapController:initEvent()
	local mapChangeListener = cc.EventListenerCustom:create(EventConst.CHANGE_MAP, handler(self, self.setNextMap))
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(mapChangeListener, self)
end

function MapController:onEnter(  )
	local size = self.map1:getContentSize()
	self.map1:setPosition(cc.p(0, 0))
	self.map2:setPositionX(display.width)
	self.map2:setBgFlipX(true)
	self.nextMap = 1
end

--设置无限地图的下一个地图,tag为下地图是1还是2
function MapController:setNextMap(  )
	local tag = self.nextMap
	if tag == 1 then 
		local posx, posy = self.map2:getPosition()
		local size = self.map2:getContentSize()
		self.map1:setPosition(cc.p( posx + display.width, posy ))
		self.nextMap = 2
		-- self.map2:playBloom()
	elseif tag ==2 then 
		local posx, posy = self.map1:getPosition()
		local size = self.map1:getContentSize()
		self.map2:setPosition(cc.p( posx + display.width , posy ))
		self.nextMap = 1
		-- self.map1:playBloom()
	end
end

return MapController