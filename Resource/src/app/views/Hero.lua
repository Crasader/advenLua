local Hero = class("Hero", function()
	return sp.SkeletonAnimation:create("skeleton.json", "skeleton.atlas", 0.8)
	end)

function Hero:ctor()

	self:setMix("idle", "attack", 0.2)
	self:setMix("attack", "idle", 0.2)

	self:setAnimation(0 ,"idle", true)
	self.state_ = "IDLE"

	local function onNodeEvent(event)
    if event == "enter" then
        self:init()
    end
  	end

  self:registerScriptHandler(onNodeEvent)
end

function Hero:init()
	self:initData()
	self:addEvent()
	
end

function Hero:initData(  )
	self:setTag(100)
end

function Hero:addEvent()
	local eventDispatcher_ = cc.Director:getInstance():getEventDispatcher()

	--注册刚开始播放动画的监听器
	self:registerSpineEventHandler(function (event)
      
  end, sp.EventType.ANIMATION_START)

	--注册自定义事件
	self:registerSpineEventHandler(handler(self, self.setAnimationEvent), sp.EventType.ANIMATION_EVENT)

	--注册添加触摸监听器
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(handler(self, self.dealTouch), cc.Handler.EVENT_TOUCH_BEGAN)

	eventDispatcher_:addEventListenerWithSceneGraphPriority(listener, self)

end

function Hero:setAnimationEvent(event)
		 print(string.format("[spine] %d event: %s, %d, %f, %s", 
                              event.trackIndex,
                              event.eventData.name,
                              event.eventData.intValue,
                              event.eventData.floatValue,
                              event.eventData.stringValue)) 

		 if event.eventData.name == "attack_end" then 
		 	print("attack End")
		 	self:Idle()
		end
end

function Hero:dealTouch()
	self:Attack()
	return true
end

function Hero:Attack()
	if self.state_ ~= "ATTACK" then
		self:setAnimation(0, "attack", false)
		self.state_ = "ATTACK"
	end
	
end

function Hero:Idle()
	self:setAnimation(0, "idle", true)
	self.state_ = "IDLE"
end

function Hero:getState(  )
	return self.state_
end


return Hero