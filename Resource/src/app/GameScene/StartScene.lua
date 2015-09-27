local StartScene = class("StartScene", function (  )
	return cc.Scene:createWithPhysics()
end)

function StartScene:ctor(  )
	self:setPhysicsCondition()

	self:initData()

	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)
end

function StartScene:onEnter(  )
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

	--获得难度选择
	local diffculty = cc.UserDefault:getInstance():getIntegerForKey("Diffcuity", 1)

	self.diffculty = diffculty

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

	--添加暂停键
	local btnZT = cc.CSLoader:createNode("MainUI/ZanTingBTN.csb")
	btnZT:setPosition(cc.p( 25, display.height - 20 ))
	self.Layer:addChild(btnZT,20)

	self.pauseTag = false
	--得到按钮并且设置监听
	local btn = btnZT:getChildByName("Button")
	local function onTouch( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		if self.pauseTag == false then 
			self.pauseTag = true
			AudioEngine.pauseMusic()
			cc.Director:getInstance():stopAnimation()

		else
			self.pauseTag = false
			cc.Director:getInstance():startAnimation()
			AudioEngine.resumeMusic()
		end
	end
	btn:addTouchEventListener( onTouch )

	--add Hp
	local hp = cc.CSLoader:createNode("MainUI/HP.csb")

	self.heroHpBar = hp:getChildByName("HP")
	self.heroHpBar:setPercent(self.heroHp_)
	hp:setPosition(cc.p(170, display.height - 20))
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
	
	--随机生成怪物
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
	-- if self.heroScore_ > World1Setting[#World1Setting] then 
	-- 	return false
	-- end
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

				spriteA:runAction(cc.Sequence:create(cc.Spawn:create( cc.RotateBy:create(1, 720),cc.ScaleBy:create(1, 0.5)),
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
		--获得创建敌人的时间
		local createArmyTime = self:getArmyCreateTime(index)
		if time >=  createArmyTime then
			self:createArmy()
			time = 0
		end
	end

	self.numUpdate = update

	self:scheduleUpdateWithPriorityLua(update, 0)
end

function StartScene:getArmyCreateTime( index )
	--这里可以根据难度不同敌人创建的时间也不同
	local diffculty = self.diffculty
	if diffculty == 1 then 
		return World1ArmyCreateTimeEasy[index]
	elseif diffculty == 2 then 
		return World1ArmyCreateTimeNormal[index]
	elseif diffculty == 3 then 
		return World1ArmyCreateTimeHard[index]
	end
end

function StartScene:setScore(  )
	self.score:setText("Score:"..self.heroScore_)
end

function StartScene:defeatArmy(  )
	self.heroScore_ = self.heroScore_ + 100
	self:setScore()
end

function StartScene:getIndexOfWorld( score )
	local worldSeting = self:getWorldSetting()
	local diffculty = self.diffculty
	local lengthOfSetting =  #worldSeting
	for index= 1 , lengthOfSetting do
		if score <= worldSeting[index] then 
			if diffculty == 1 then 

				return index

			elseif diffculty == 2 then 
				local lastIndex = index + 2
				--如果未到最后就返回这个
				if lastIndex <= lengthOfSetting then 
					return lastIndex
				else return lengthOfSetting
				end
			elseif diffculty == 3 then 
				local lastIndex = index + 5
				if lastIndex <= lengthOfSetting then 
					return lastIndex
				else return lengthOfSetting
				end
			end

		else 
			return lengthOfSetting
		end
	end
end

function StartScene:getWorldSetting(  )
	local diffculty = self.diffculty
	--对应简单难度
	if diffculty == 1 then 

	--对应普通难度
	elseif diffculty == 2 then 

	--对应困难难度
	elseif diffculty == 3 then 

	end 

	return World1Setting
end

function StartScene:playBgSound(  )
	AudioEngine.playMusic("music/bg/World1.mp3", true)
end

function StartScene:EnterGameOverScene(  )
	--有没有超过记录
	self:SaveHighestScore()
	self:saveScore()

	--进入到结算场景
	local scene = require("app.GameScene.GameOverScene").new()
	local fadeIn = cc.TransitionFade:create(1,scene, cc.c3b(255, 0, 0) )
	cc.Director:getInstance():replaceScene(fadeIn)


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

