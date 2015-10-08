local FemaleHero = class("FemaleHero", function()
	return sp.SkeletonAnimation:create("Spine/femaleHero.json", "Spine/femaleHero.atlas", 0.8)
	end)

function FemaleHero:ctor()

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

function FemaleHero:init()
	self:initData()
	self:addEvent()
	
end

function FemaleHero:initData(  )
	self:setTag(100)
	self:setPosition(cc.p(display.cx/2, 225 ))
	--给英雄设置物理边框
	self:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(175,175)))
	--设置碰撞和接触掩码
	-- self.hero:getPhysicsBody():setCollisionBitmask(0)
	self:getPhysicsBody():setContactTestBitmask(1)
	

end

function FemaleHero:addEvent()
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

function FemaleHero:setAnimationEvent(event)
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

function FemaleHero:dealTouch()
	self:Attack()
	return true
end

function FemaleHero:Attack()
	if self.state_ ~= "ATTACK" then
		self:playAttackSound()
		self:setAnimation(0, "attack", false)
		self.state_ = "ATTACK"
	end
	
end

function FemaleHero:Idle()
	self:setAnimation(0, "idle", true)
	self.state_ = "IDLE"
end

function FemaleHero:getState(  )
	return self.state_
end

function FemaleHero:playAttackSound(  )
 	AudioEngine.playEffect( "music/effect/FemaleHero_attack.mp3" )
end


return FemaleHero