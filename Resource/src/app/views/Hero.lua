local Hero = class("Hero", function()
	return sp.SkeletonAnimation:create("Spine/skeleton.json", "Spine/skeleton.atlas", 0.8)
	end)

function Hero:ctor( needPhysics )

	self:setMix("idle", "attack", 0.2)
	self:setMix("attack", "idle", 0.2)

	self:setAnimation(0 ,"idle", true)
	self:changeState(const.HERO_IDLE)
	self.needPhysics = needPhysics
	self:initData()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:init()
       elseif event == "exit" then 
	       	self:onExit()
	    end
  	end
  self:registerScriptHandler(onNodeEvent)
end

function Hero:init()
	if self.needPhysics  == true then 
		self:addEvent()
	end
	self:SetRight()
end

function Hero:OnUpdate()
	if self.handler then 
		GameFuc.unSetUpdate(self.handler)
		self.handler = nil
	end

	--使用定时器
	local function changePos(dt)

		if self.dir == 0 then 
			self:Idle()
		--左走
		elseif self.dir == -1 then 
			self:SetLeft()
		elseif self.dir == 1 then 
			self:SetRight()
		end

		self:Move()
	end
	self.handler = GameFuc.setUpdate(changePos, 1/60,false)
end

function Hero:Move()
	--在没到达一定距离时候自己移动
	local posx, posy = self:getPosition()
	if posx < display.cx/3 and posx > 0 then
		if self.dir == -1 then 
			if self:isCanMoveLeft() then 
				self:setPositionX(posx + self.dir)
			end
		else
			self:setPositionX(posx + self.dir)
		end
	--到达屏幕1/3点时候就右移画面
	elseif posx >= display.cx/3 then 
		if self.dir == 1 then 
			GameFuc.dispatchEvent(EventConst.SCROLL_RIGHT)
		--这个时候想做走就
		elseif self.dir == -1 then 
			if UserDataManager.getInstance():isMapCameraStop() == false then
				GameFuc.dispatchEvent(EventConst.SCROLL_LEFT)
			elseif UserDataManager.getInstance():isMapCameraStop() == true then 
				self:setPositionX(posx + self.dir)
			end
		end
	end
end

function Hero:isCanMoveLeft()
	if self:getPositionX() <= (display.cx/2 - 160) then 
		return false
	end
	return true
end

function Hero:OffUpdate()
	if self.handler then 
		GameFuc.unSetUpdate(self.handler)
		self.handler = nil
	end
end

function Hero:onExit()
	if self.handler then 
		GameFuc.unSetUpdate(self.handler)
		self.handler = nil
	end
end

function Hero:initData(  )
	self:setTag(const.HERO)
	--方向0为不动，-1向左，1为向右
	self.dir = 0
end

function Hero:ChangeDir( dir )
	self.dir = dir
end

function Hero:setPhysics()
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

	--注册添加角色掉到木板
	local onFloorEvent = cc.EventListenerCustom:create( EventConst.HERO_ON_WALL, handler(self, self.onFloor) )
	eventDispatcher_:addEventListenerWithSceneGraphPriority(onFloorEvent, self)

	--角色向右移动的事件
	local moveRightEvent = cc.EventListenerCustom:create( EventConst.HERO_MOVE_RIGHT, handler(self, self.MoveRight) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(moveRightEvent, self)

	--角色想左移动的事件
	local moveLeftEvent = cc.EventListenerCustom:create( EventConst.HERO_MOVE_LEFT, handler(self, self.MoveLeft) )
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(moveLeftEvent, self)

	--角色跳跃事件
	local jumpEvent = cc.EventListenerCustom:create( EventConst.HERO_JUMP, handler(self, self.MoveJump) )
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(jumpEvent, self)

	--角色攻击
	local attackEvent = cc.EventListenerCustom:create( EventConst.HERO_ATTACK, handler(self, self.MoveAttack) )
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(attackEvent, self)

	--角色停止移动的事件
	local moveIdleEvent = cc.EventListenerCustom:create( EventConst.HERO_IDLE, handler(self, self.MoveIdle) )
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(moveIdleEvent, self)

	--键盘响应时间
	local keyListener = cc.EventListenerKeyboard:create()
	local function onKeyPress(keycode, event)
		if keycode == cc.KeyCode.KEY_A then 
			GameFuc.dispatchEvent(EventConst.HERO_MOVE_LEFT)
		end

		if keycode == cc.KeyCode.KEY_D then 
			GameFuc.dispatchEvent(EventConst.HERO_MOVE_RIGHT)
		end

		if keycode == cc.KeyCode.KEY_J then 
			GameFuc.dispatchEvent(EventConst.HERO_ATTACK)
		end

		if keycode == cc.KeyCode.KEY_K then 
			GameFuc.dispatchEvent(EventConst.HERO_JUMP)
		end
	end

	local function okKeyRelease(keycode, event)
		if keycode == cc.KeyCode.KEY_A then 
			GameFuc.dispatchEvent(EventConst.HERO_IDLE)
		end

		if keycode == cc.KeyCode.KEY_D then 
			GameFuc.dispatchEvent(EventConst.HERO_IDLE)
		end
	end
	keyListener:registerScriptHandler(onKeyPress, cc.Handler.EVENT_KEYBOARD_PRESSED)
	keyListener:registerScriptHandler(okKeyRelease, cc.Handler.EVENT_KEYBOARD_RELEASED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(keyListener, self)
end

function Hero:MoveAttack()
	self:OffUpdate()
	self:Attack()
end

function Hero:MoveJump()
	self:OffUpdate()
	self:Jump()
end

function Hero:MoveIdle()
	self:ChangeDir(0)
end

function Hero:MoveLeft()
	self:ChangeDir(-1)
	self:Walk()
end

function Hero:MoveRight()
	self:ChangeDir(1)
	self:Walk()
end

function Hero:onFloor()
	self:OnUpdate()
	self:Walk()
end

function Hero:onMove()
	self:Walk()
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
		 	print("self:getState()", self:getState())
		 	if const.HERO_AIRATTACK == self:getState()   or const.HERO_JUMP == self:getPreState() or self:getState() == const.HERO_DIE 
		 		or const.HERO_WALK == self:getState() then
		 		return 
		 	else
		 		self:OnUpdate()
			 	local state = self:getPreState()
			 	self:ActWithState(state)
			end
		end
end

function Hero:Attack()
	--走的时候不响应攻击
	if self:getState() ~= const.HERO_ATTACK  and 
		self:getState() ~= const.HERO_DIE then
		self:setAnimation(1, "attack", false)
		self:changeState(const.HERO_ATTACK)
		self:playAttackSound()
	end
	
end

function Hero:Jump()
	--走路和攻击时候和死亡不可跳跃
	if self:getState() ~= const.HERO_JUMP and self:getState() ~= const.HERO_ATTACK and self:getState() ~= const.HERO_DIE then
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
	if state == const.HERO_DIE then 
		self:Die()
	elseif state == const.HERO_IDLE then 
		self:Idle()
	elseif state == const.HERO_WALK then 
		self:Walk()
	elseif state == const.HERO_ATTACK then 
		self:Attack()
	elseif state == const.HERO_JUMP  then 
		self:Walk()
	end 
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

--设置面朝向左边
function Hero:SetLeft()
	self:setRotation3D(cc.vec3(0, 180, 0))
end

--设置朝向右边
function Hero:SetRight()
	self:setRotation3D(cc.vec3(0, 0, 0))
end


return Hero