local Hero = class("Hero", function()
	return sp.SkeletonAnimation:create("Spine/skeleton.json", "Spine/skeleton.atlas", 0.8)
	end)

function Hero:ctor()

	self:setMix("idle", "attack", 0.2)
	self:setMix("attack", "idle", 0.2)

	self:setAnimation(0 ,"idle", true)
	self:changeState(const.HERO_IDLE)

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

	self.hp_ = UserDataManager.getInstance():getHp()

end

function Hero:setHp( value )
	UserDataManager.getInstance():setHp(value)
end

function Hero:getHp()
	return UserDataManager.getInstance():getHp()
end

function Hero:MinitesHp( value )
	UserDataManager.getInstance():subHp(value)
end

function Hero:addHp( value )
	UserDataManager.getInstance():addHp(value)
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
	self.touchListener = listener
	listener:setSwallowTouches(true)
	listener:registerScriptHandler(handler(self, self.dealTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
	eventDispatcher_:addEventListenerWithSceneGraphPriority(listener, self)

	--注册添加角色掉到木板
	local onFloorEvent = cc.EventListenerCustom:create( EventConst.HERO_ON_WALL, handler(self, self.onFloor) )
	eventDispatcher_:addEventListenerWithSceneGraphPriority(onFloorEvent, self)

	--屏幕移动时候角色移动
	local eventListener = cc.EventListenerCustom:create(EventConst.SCROLL_VIEW, handler(self, self.onMove))
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(eventListener, self)

	--下一轮时候角色静止
	local nextRoundEvent = cc.EventListenerCustom:create( EventConst.NEXT_ROUND, handler(self, self.onStatic) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(nextRoundEvent, self)
end

function Hero:onFloor()
	self:Idle()
end

function Hero:onMove()
	self:Walk()
end

function Hero:onStatic()
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
		 	--空中不改变状态
		 	if const.HERO_AIRATTACK == self:getState()   or const.HERO_JUMP == self:getPreState() or self:getState() == const.HERO_DIE then
		 		return 
		 	else
			 	self:Idle()
			end
		end
end

function Hero:dealTouchBegan(touches, event)
	GameFuc.setSpeedScale( 1 )
	local x = touches:getLocation().x
	local y = touches:getLocation().y
	--左侧就是跳跃，右侧是攻击
	if x > display.width/2 and y < display.cy then 		
		self:Attack()
	-- elseif x < display.width/2 and y > display.height/2 then 
	-- 	GameFuc.setSpeedScale( 2 )
	else
		self:Jump()
	end
	return false
end

function Hero:dealTouchMoved(touches, event)
	

end

function Hero:dealTouchEnded(touches, event)
	
end

function Hero:Attack()
	--走的时候不响应攻击
	if self:getState() ~= const.HERO_ATTACK and self:getState() ~= const.HERO_WALK and 
		self:getState() ~= const.HERO_DIE then
		self:setAnimation(0, "attack", false)
		self:changeState(const.HERO_ATTACK)
		self:playAttackSound()
	end
	
end

function Hero:Jump()
	--走路和攻击时候和死亡不可跳跃
	if self:getState() ~= const.HERO_JUMP and self:getState() ~= const.HERO_ATTACK and 
		self:getState() ~= const.HERO_WALK and self:getState() ~= const.HERO_DIE then
		-- self:setAnimation(0, "attack", false)
		self:runAction(cc.JumpBy:create(1, cc.p(0,500), display.cy/2, 1))
		self:setAnimation(0, "jump", false)
		self:changeState(const.HERO_JUMP)
	end
end

function Hero:Idle()
	if self:getState() ~= const.HERO_IDLE and self:getState() ~= const.HERO_DIE then
		self:setAnimation(0, "idle", true)
		self:changeState(const.HERO_IDLE)
	end
end

function Hero:Walk()
	if self:getState() ~= const.HERO_WALK and self:getState() ~= const.HERO_DIE then 
		self:setAnimation(0, "walk", true)
		self:changeState(const.HERO_WALK)
	end
end

function Hero:Die()
	if self:getState() ~= const.HERO_DIE then 
		self:setAnimation(0, "die", false)
		self:changeState(const.HERO_DIE)
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