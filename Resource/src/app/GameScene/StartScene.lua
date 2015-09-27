local StartScene = class("StartScene", function (  )
	return cc.Scene:createWithPhysics()
end)

function StartScene:ctor(  )
	self:setPhysicsCondition()

	self:initData()

	self:playBgSound()

	self:addUI()

	self:addMainCharacter()

	self:addPhysicsEvent()

	self:createArmySomeTimeLater()

end

function StartScene:initData(  )
	--加载敌人出现的速度
	require "app.Data.ArmySpeed"

	--加载关卡设置
	require "app.Data.World1"

	--加载敌人生产工厂
	require("app.models.ArmyFactory")

	self.heroHp_ = 100
	self.heroScore_ = 0

end

function StartScene:addUI(  )
	local size = cc.Director:getInstance():getVisibleSize()
	local layer = cc.Layer:create()
	self:addChild(layer)
	self.Layer = layer
	--add Back
	local backGround = cc.CSLoader:createNode("Level/Level1.csb")
	backGround:setPosition(cc.p(0, 0))
	local scaleFactorY = size.height / backGround:getContentSize().height
	backGround:setScaleY(scaleFactorY)
	local scaleFactorX = size.width / backGround:getContentSize().width
	backGround:setScaleX(scaleFactorX)
	self.Layer:addChild(backGround)

	--add Hp
	local hp = cc.CSLoader:createNode("MainUI/HP.csb")

	self.heroHpBar = hp:getChildByName("HP")
	self.heroHpBar:setPercent(self.heroHp_)
	hp:setPosition(cc.p(150, display.height - 20))
	self.Layer:addChild(hp,20)

	--add Score
	local scoreNode = cc.CSLoader:createNode("MainUI/Score.csb")
	self.score = scoreNode:getChildByName("Score")

	scoreNode:setPosition(cc.p(display.width - 120, display.height - 16))
	self.Layer:addChild(scoreNode,20)
	self:setScore()

	--add Effect
	local effect = cc.CSLoader:createNode("Effect/attackEffect.csb")
	effect:setVisible(false)
	effect:setScale(2)
	self.Layer:addChild(effect)
	local effectTimeLine = cc.CSLoader:createTimeline("Effect/attackEffect.csb")
	effectTimeLine:setTimeSpeed(3)

	local function onFrameEvent( frame )
		if nil == frame then
			return 
		end

		local str = frame:getEvent()
		if str == "end" then
			effect:setVisible(false)
		end

		if str == "start" then
			effect:setVisible(true)
		end
	end
	effectTimeLine:setFrameEventCallFunc(onFrameEvent)
	effect:runAction(effectTimeLine)
	self.effectTimeLine = effectTimeLine
	self.effect = effect

end

function StartScene:setPhysicsCondition(  )
	local physicsWorld = self:getPhysicsWorld()
	physicsWorld:setGravity(cc.p(0,-300))
	physicsWorld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
end

function StartScene:addMainCharacter(  )
	--添加物理世界框

	local wall = cc.Node:create()
	wall:setPosition(cc.p(display.cx, display.cy +  275/2 ))
	self.Layer:addChild(wall,20)
	wall:setPhysicsBody(cc.PhysicsBody:createEdgeBox(cc.size(display.width*2,display.height)))


	self.hero = require("app.views.Hero").new()
	--给英雄设置物理边框
	self.hero:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(200,275)))
	--设置碰撞和接触掩码
	-- self.hero:getPhysicsBody():setCollisionBitmask(0)
	self.hero:getPhysicsBody():setContactTestBitmask(1)
	--最后才设置位置
	self.hero:setPosition(cc.p(display.cx/2, 275 ))

	self.Layer:addChild(self.hero,10)
  	self:createArmy()

	
end

function StartScene:createArmy(  )
	if not self:isNeedCreateArmy() then return end

  	local index = self:getIndexOfWorld(self.heroScore_)

	--得到对应应该生成几个怪物
	local armyNumTbl = World1ArmySetting[index]
	
	local armyId = math.random(1, 3)
	local army = ArmyFactory.createArmyById(armyId)
	army:setTag(1)
  	army:Walk()
  	army:setPosition(cc.p(display.cx*2, 275/2 + 25))
  	army:setPhysics()
  	self.Layer:addChild(army,10)
  	--这里应该根据一个表来设置速度
  	local speedTbl = self:getSpeedTbl(armyId)
  	local speed = speedTbl[index]
  	army:setSpeed(speed)
end

function StartScene:getSpeedTbl( id )
	if id == 1 then 
		return Army001Speed
	elseif id == 2 then 
		return Army002Speed
	elseif id == 3 then 
		return Army003Speed
	end
end

function StartScene:isNeedCreateArmy(  )
	if self.heroScore_ > World1Setting[#World1Setting] then 
		return false
	end
	return true

end

function StartScene:addPhysicsEvent(  )
	local function onContactBegan( contact )
		local spriteA = contact:getShapeA():getBody():getNode()
		local spriteB = contact:getShapeB():getBody():getNode()

		local function showHeroInjure(  )
			local shineAct = cc.Sequence:create(cc.FadeOut:create(0.2), cc.FadeIn:create(0.15))
			self.hero:runAction(cc.Repeat:create(shineAct, 6))
			self.heroHp_ = self.heroHp_ - 10
			if self.heroHp_ <= 0 then
				--停止缓慢低地弹出游戏
					
				self:EnterGameOverScene()	

			end
			self.heroHpBar:setPercent(self.heroHp_)
		end

		--如果是两个精灵自己的碰撞就不执行下面逻辑了
		if spriteA and (spriteA:getTag() == 1 ) and spriteB and (spriteB:getTag() == 1 ) then 
			return 
		end 

		if spriteA and (spriteA:getTag() == 1)  then
			if self.hero:getState() == "ATTACK" then
				self.effect:setPosition(cc.p(spriteA:getPositionX() -20, spriteA:getPositionY()))
				self.effectTimeLine:play("Strike", false)

				--设置被打飞的速度
				local index = self:getIndexOfWorld(self.heroScore_)
				local speed = Army001Speed[index]
				spriteA:getPhysicsBody():setVelocity(cc.p(speed.outX,speed.outY))
				--打击敌人的处理
				self:defeatArmy()
				spriteA:playDefeatEffect()

				spriteA:runAction(cc.Sequence:create(cc.RotateBy:create(2, 720),
					cc.RemoveSelf:create(false)))
			else
				showHeroInjure()
			end
			
		elseif spriteB and (spriteB:getTag() == 1) then
			if self.hero:getState() == "ATTACK" then
				self.effect:setPosition(cc.p(spriteB:getPositionX() -20, spriteB:getPositionY()))
				self.effectTimeLine:play("Strike", false)
				spriteB:playDefeatEffect()
				spriteB:getPhysicsBody():setVelocity(cc.p(200,200))

				--打击敌人的处理
				self:defeatArmy()

				spriteB:runAction(cc.Sequence:create(cc.RotateBy:create(2, 720),
						cc.RemoveSelf:create(false)))
			else
				showHeroInjure()
			end
		end
	end

	local physicsListener = cc.EventListenerPhysicsContact:create()
	physicsListener:registerScriptHandler(onContactBegan, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
	local eventDispatcker = self:getEventDispatcher()
	eventDispatcker:addEventListenerWithSceneGraphPriority(physicsListener, self)
end

function StartScene:createArmySomeTimeLater(  )
	local time = 0
	local function update( deta )
		local army = self.Layer:getChildByTag(1)

		if army and army:getPositionX() <= 50 then
			army:removeFromParent()
		end

		time = time + deta
		local index = self:getIndexOfWorld(self.heroScore_)
		local createArmyTime = World1ArmyCreateTime[index]
		if time >=  createArmyTime then
			self:createArmy()
			time = 0
		end
	end

	self.numUpdate = update

	self:scheduleUpdateWithPriorityLua(update, 0)
end

function StartScene:setScore(  )
	self.score:setText("Score:"..self.heroScore_)
end

function StartScene:defeatArmy(  )
	self.heroScore_ = self.heroScore_ + 100
	self:setScore()
end

function StartScene:getIndexOfWorld( score )
	for index= 1 , #World1Setting do
		if score <= World1Setting[index] then 
			return index
		end
	end
end

function StartScene:playBgSound(  )
	AudioEngine.playEffect("music/bg/World1.mp3", true)
end

function StartScene:EnterGameOverScene(  )
	--有没有超过记录
	self:SaveHighestScore()
	self:saveScore()

	--进入到结算场景
	cc.Director:getInstance():stopAnimation()


end

function StartScene:SaveHighestScore(  )
	--获得当前最高的数据
	local saveMgr = cc.UserDefault:getInstance()
	local highestKey = "HighestScore"
	local hightScore = saveMgr:getIntegerForKey(highestKey)
	--大于就保存
	if self.heroScore_ > hightScore then 
		saveMgr:setIntegerForKey( highestKey,  self.heroScore_)
	end
end

function StartScene:saveScore( )
	local saveMgr = cc.UserDefault:getInstance()
	local key = "Score"

	--保存数据到下个场景展示
	saveMgr:setIntegerForKey( key , self.heroScore_ )
end

return StartScene

