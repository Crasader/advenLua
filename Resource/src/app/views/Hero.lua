local Hero = class("Hero", function()
	return sp.SkeletonAnimation:create("Spine/maleHero.json", "Spine/maleHero.atlas", 0.8)
	end)

function Hero:ctor()

	self:setMix("idle", "attack", 0.2)
	self:setMix("attack", "idle", 0.2)

	self:setAnimation(0 ,"idle", true)
	self:changeState("IDLE")

	self:initData()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:init()
	    end
  	end
  self:registerScriptHandler(onNodeEvent)
end

function Hero:init()
	self:addEvent()

	self.act = BloomUp:create(1, 0.0, 0.2, true)

	self:runAction(cc.RepeatForever:create(cc.Sequence:create(self.act, self.act:reverse())))
	
end

function Hero:initData(  )
	self:setTag(const.HERO)
	--给英雄设置物理边框
	self:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(120,250)))
	--设置碰撞和接触掩码
	self:getPhysicsBody():setContactTestBitmask(1)
	
	self.physicsBody = self:getPhysicsBody()
	self.physicsBody:setRotationEnable(false)

	self.physicsBody:setPositionOffset(cc.p( 50,0 ))

	self.hp_ = 100

end

function Hero:setHp( value )
	self.hp_ = value
end

function Hero:getHp()
	return self.hp_
end

function Hero:MinitesHp( value )
	self.hp_ = self.hp_ - value
end

function Hero:addHp( value )
	self.hp_ = self.hp_ + value
end

function Hero:addEvent()
	local eventDispatcher_ = cc.Director:getInstance():getEventDispatcher()

	--注册刚开始播放动画的监听器
	self:registerSpineEventHandler(function (event)
      
  end, sp.EventType.ANIMATION_START)

	--注册自定义事件
	self:registerSpineEventHandler(handler(self, self.setAnimationEvent), sp.EventType.ANIMATION_EVENT)

	--注册添加触摸监听器
	local listener = cc.EventListenerTouchAllAtOnce:create()
	listener:registerScriptHandler(handler(self, self.dealTouchBegan), cc.Handler.EVENT_TOUCHES_BEGAN)
	listener:registerScriptHandler(handler(self, self.dealTouchMoved), cc.Handler.EVENT_TOUCHES_MOVED)
	listener:registerScriptHandler(handler(self, self.dealTouchEnded), cc.Handler.EVENT_TOUCHES_ENDED)
	eventDispatcher_:addEventListenerWithSceneGraphPriority(listener, self)

	--注册添加角色掉到木板
	local onFloorEvent = cc.EventListenerCustom:create( EventConst.HERO_ON_WALL, handler(self, self.onFloor) )
	eventDispatcher_:addEventListenerWithSceneGraphPriority(onFloorEvent, self)
end

function Hero:onFloor()
	self:changeState( "Idle" )
	self:Idle()
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
		 	--空中攻击不改变状态
		 	if self:getState() == "AIRATTACK" then
		 		
		 	else
			 	self:Idle()
			 end
		end
end

function Hero:dealTouchBegan(touches, event)
	print("dealTouchBegan~~~~~")
	local x = touches[1]:getLocation().x
	local y = touches[1]:getLocation().y
	print(x,y)
	--左侧就是跳跃，右侧是攻击
	if x > display.width/2 and y < display.cy then 		
		self:Attack()
	elseif x < display.width/2 and y > display.height/2 then 
		GameFuc.setSpeedScale( 2 )
	else
		self:Jump()
	end
	return true
end

function Hero:dealTouchMoved(touches, event)
	

end

function Hero:dealTouchEnded(touch, event)
	GameFuc.setSpeedScale( 1 )
end

function Hero:Attack()
	if self:getState() ~= "ATTACK" then
		self:playAttackSound()
		self:setAnimation(0, "attack", false)
		if self:getState() == "JUMP" then 
			self:changeState( "AIRATTACK" )
		else
			self:changeState("ATTACK")
		end
	end
	
end

function Hero:Jump()
	if self:getState() ~= "JUMP" and self:getState() ~= "AIRATTACK" then
		-- self:setAnimation(0, "attack", false)
		self:runAction(cc.JumpBy:create(1, cc.p(0,500), display.cy/2, 1))
		self:changeState("JUMP")
	end
end

function Hero:Idle()
	if self:getState() ~= "IDLE" then
		self:setAnimation(0, "idle", true)
		self:changeState("IDLE")
	end
end

function Hero:getState(  )
	return self.state_
end

function Hero:setPreState( state )
	self.preState_ = state
end

function Hero:getPreState()
	return self.preState_
end

function Hero:changeState( state )
	if not state then return end
	self:setPreState(self:getState())
	self.state_ = state
end

function Hero:ActWithState( state ) 
end

function Hero:playAttackSound(  )
 	AudioManager.playMaleAttEffect()
end

--主角受到伤害
function Hero:Injure()
	--先显示受到伤害的动画
	local act1 = RedFilter:create(0.2, 0, 1.0, true)
	local shineAct = cc.Sequence:create(act1, act1:reverse())
	self:runAction( cc.Sequence:create( cc.Repeat:create(shineAct, 2) , RedFilter:create(0.1, 0, 0.0, true) )  )
end


return Hero