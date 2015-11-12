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

	self:createGameCutScene()

	self:addEvent()
	
end

function StartScene:createGameCutScene()
	self.gamecutScene = require("app.GameScene.GameCutScene").new()
	self.gamecutScene:retain()
end

function StartScene:DealWithBossShoot(  )
	--创建子弹
	local bullet = EffectFactory.createBossFire()
	self.Layer:addChild(bullet)
	bullet:setPosition(display.width, display.cy)
	bullet:setSpeed({x= -500, y= 0})
	bullet:Fire()
	-- bullet:runAction(cc.Spawn:create( cc.ScaleBy:create(2, 2), cc.MoveBy:create(2, cc.p(-display.width/2, 0)) ))
end

function StartScene:addEvent(  )

	--boss射击子弹事件
	local bossEventLis = cc.EventListenerCustom:create( EventConst.BOSS_SHOOT, handler(self, self.DealWithBossShoot) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(bossEventLis, self)

	--boss死亡后的事件
	local bossDieEvent = cc.EventListenerCustom:create( EventConst.BOSS01_DIE, handler(self, self.DealWithBossDie) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(bossDieEvent, self)

	--主角死亡后的事件
	local heroDieEvent = cc.EventListenerCustom:create( EventConst.HERO_DIE, handler(self, self.DealWithHeroDie) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(heroDieEvent, self)


	--暂停事件
	local gamecutEvent = cc.EventListenerCustom:create( EventConst.GAME_CUT, handler(self, self.DealWithGamecut) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(gamecutEvent, self)

	--resume事件
	local gameResumeEvent = cc.EventListenerCustom:create( EventConst.GAME_RESUME, handler(self, self.DealWithResume) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(gameResumeEvent, self)
end

function StartScene:DealWithResume()
	AudioEngine.resumeMusic()
	cc.Director:getInstance():startAnimation()
end

function StartScene:DealWithGamecut(  )
	if self.gamecutScene then 
		AudioEngine.pauseMusic()
		cc.Director:getInstance():stopAnimation()
		local scene = self.gamecutScene

		local rendTex = self.rendTex
		if not rendTex then 
			rendTex = cc.RenderTexture:create(display.width, display.height)
			rendTex:retain()
			self.rendTex = rendTex
		end

		rendTex:beginWithClear(0, 0, 0, 1.0)

		self.Layer:visit()

		rendTex:endToLua()

		scene:initWithTexture(rendTex:getSprite():getTexture())

		cc.Director:getInstance():pushScene(scene)
		scene:toGuass()
		
	end
end

function StartScene:DealWithBossDie()
	self:EnterGameOverScene( true )	
end

function StartScene:DealWithHeroDie()
	self:EnterGameOverScene( false )	
end

function StartScene:initData(  )
	self.heroHp_ = 100
	self.heroScore_ = 0
	self.index = 1
	self.armyNum =  0

	--获得难度选择
	local diffculty = cc.UserDefault:getInstance():getIntegerForKey("Diffcuity", 1)

	self.diffculty = diffculty

	--获得产生的角色的id
	local heroID = cc.UserDefault:getInstance():getIntegerForKey("Sex", 1)

	self.heroId = heroID
end

function StartScene:addUI(  )
	local size = cc.Director:getInstance():getVisibleSize()
	local layer = cc.Layer:create()
	self:addChild(layer)
	self.Layer = layer
	--add Back
	local backGround = LevelFactory.createLavel1()
	backGround:setPosition(cc.p(0, 0))
	local nextBg = LevelFactory.createLavel1()
	nextBg:setPosition(cc.p(display.width, 0))
	nextBg:setRotation3D(cc.vec3(0,60,0))
	local lastBg = LevelFactory.createLavel1()
	backGround:setPosition(cc.p(2*display.width - 1, 0))
	self.Layer:addChild(backGround)
	self.Layer:addChild(nextBg)
	self.Layer:addChild(lastBg)

	--添加暂停键
	local btnZT = cc.CSLoader:createNode("MainUI/ZanTingBTN.csb")
	btnZT:setPosition(cc.p( 50, display.height - 35 ))
	btnZT:setScale(2)
	self.Layer:addChild(btnZT,20)

	self.pauseTag = false
	--得到按钮并且设置监听
	local btn = btnZT:getChildByName("Button")
	local function onTouch( sender, eventType )
		if eventType ~= ccui.TouchEventType.ended then return end
		local event = cc.EventCustom:new(EventConst.GAME_CUT)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
	end
	btn:addTouchEventListener( onTouch )

	--add Hp
	local hp = cc.CSLoader:createNode("MainUI/HP.csb")
	hp:setScaleY(2.0)
	self.heroHpBar = hp:getChildByName("HP")
	self.heroHpBar:setPercent(self.heroHp_)
	hp:setPosition(cc.p(200, display.height - 20))
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


	self.hero = self:createHeroById(self.heroId )
	--最后才设置位置
	self.Layer:addChild(self.hero,10)
  	self:createArmy()

	
end

function StartScene:createHeroById( id )
	if id == 1 then
		return require("app.views.Hero").new()
	elseif id == 2 then
		return require("app.views.FemaleHero").new()
	end
end

function StartScene:createArmy(  )
  	-- local index = self:getIndexOfWorld(self.heroScore_)
	
	--随机生成怪物
	local armyId = math.random(1, 3)
	local army = ArmyFactory.createArmyById(armyId)
	self.armyNum = self.armyNum + 1
	army:setTag(const.NORMAL_ARMY)
  	army:Walk()
  	army:setPosition(cc.p(display.cx*2, 275/2 + 25))
  	army:setPhysics()
  	self.Layer:addChild(army,10)
  	--这里应该根据一个表来设置速度
  	local speedTbl = self:getSpeedTbl(armyId)
  	local speed = speedTbl[self.index]
  	army:setSpeed(speed)
end

function StartScene:createBoss(  )
	if not self.boss then 
		local boss = ArmyFactory.createBoss(1)
	  	boss:commIntoGame()
	  	boss:setPosition(cc.p(display.cx* 2.5, 275/2+ 180))
	  	boss:setPhysics()
	  	self.Layer:addChild(boss,10)
	  	self.boss = boss
		  	--这里应该根据一个表来设置速度
	end
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
	if self.armyNum <= 5 then 
		return true
	else 
		return false
	end


end

function StartScene:addPhysicsEvent(  )
	local function onContactBegan( contact )
		local spriteA = contact:getShapeA():getBody():getNode()
		local spriteB = contact:getShapeB():getBody():getNode()

		--如果是两个精灵与boss的碰撞就不执行下面逻辑了
		if spriteA and (spriteA:getTag() ==const.NORMAL_ARMY ) and spriteB and ((spriteB:getTag() == const.NORMAL_ARMY ) or (spriteB:getTag() == const.BOSS))  then 
			return 
		end 
		if spriteB and (spriteB:getTag() == const.NORMAL_ARMY) and spriteA and ((spriteA:getTag() == const.NORMAL_ARMY) or (spriteA:getTag() == const.BOSS)) then 
			return 
		end


		local armyId 
		self:dealPhysicsContact(spriteA, spriteB)
	end

	local physicsListener = cc.EventListenerPhysicsContact:create()
	physicsListener:registerScriptHandler(onContactBegan, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
	local eventDispatcker = self:getEventDispatcher()
	eventDispatcker:addEventListenerWithSceneGraphPriority(physicsListener, self)
end

function StartScene:dealPhysicsContact( spriteA, spriteB )
	local function showHeroInjure( hurtId )
		local act1 = RedFilter:create(0.2, 0, 1.0, true)
		local shineAct = cc.Sequence:create(act1, act1:reverse())
		self.hero:runAction( cc.Repeat:create(shineAct, 2) )

		local deltaHp = self:getDeltaHp( hurtId )
		self.heroHp_ = self.heroHp_ - deltaHp
		if self.heroHp_ <= 0 then
			--停止缓慢低地弹出游戏
			local event =  cc.EventCustom:new(EventConst.HERO_DIE)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
		end
		self.heroHpBar:setPercent(self.heroHp_)
	end

	--如果是普通敌人与主角的碰撞
	if GameFuc.isHeroContactWithNormalArmy( spriteA, spriteB ) then 
		--确定第一个为主角
		local bodyHero = GameFuc.getHero( spriteA, spriteB ) 
		local bodyArmy = GameFuc.getNormalArmy( spriteA, spriteB )
		if self.hero:getState() == "ATTACK" then
			self.effect:setPosition(cc.p(bodyArmy:getPositionX() -20, bodyArmy:getPositionY()))
			self.effectTimeLine:play("Strike", false)

			--设置被打飞的速度
			local index = self:getIndexOfWorld(self.heroScore_)
			self.index  = index 
			local speed = Army001Speed[self.index]
			bodyArmy:getPhysicsBody():setVelocity(cc.p(speed.outX,speed.outY))
			--打击敌人的处理
			self:defeatArmy(bodyArmy.typeId)
			bodyArmy:playDefeatEffect()
			bodyArmy:runAction(cc.Sequence:create( cc.RotateBy:create(1, 720),
				cc.RemoveSelf:create(false)))
		else
			armyId = bodyArmy.typeId
			showHeroInjure( armyId)
		end

	end

	--如果是子弹与主角的碰撞
	if GameFuc.isHeroContactWithBullet(spriteA, spriteB) then 
		--确定第一个为主角
		local bodyHero = GameFuc.getHero( spriteA, spriteB ) 
		local bodyBullet = GameFuc.getBullet( spriteA, spriteB )
		--如果角色是攻击状态就返回
		if self.hero:getState() == "ATTACK" then
			bodyBullet:reverseSpeed()
		else
			armyId = bodyBullet.typeId
			showHeroInjure( armyId)
		end
	end

	--子弹和boss的碰撞
	if GameFuc.isBulletContactWithBoss(spriteA, spriteB ) then 
		local bodyBullet = GameFuc.getBullet( spriteA, spriteB )
		local bodyBoss = GameFuc.getBoss(spriteA, spriteB)
		--Boss被子弹打到后
		if not bodyBoss then return end

		--向左方向的返回
		if bodyBullet.dir == const.DIRECTTOR_LEFT then return end

		bodyBoss:playDefeatEffect()
	end
	
end

function StartScene:getDeltaHp( hurtId )
	--默认返回10
	if not hurtId then return 10 end
	local hurtHp 
	if hurtId == 1 then 
		return HurtOfArmy001[self.diffculty]
	elseif hurtId == 2 then 
		return HurtOfArmy002[self.diffculty]
	elseif hurtId == 3 then 
		return HurtOfArmy003[self.diffculty]
	else
		return 20
	end
end

function StartScene:createArmySomeTimeLater(  )
	local time = 0
	local function update( deta )
		local army = self.Layer:getChildByTag(1)

		if army and army:getPositionX() <= 50 then
			army:removeFromParent()
		end

		time = time + deta
		--获得创建敌人的时间
		if self:isNeedCreateArmy() then 
		--如果不需要创造敌人就取消计时器来创造敌人
			local createArmyTime = self:getArmyCreateTime(self.index)
			if time >=  createArmyTime then
				self:createArmy()
				time = 0
			end
		else 
			self:createBoss()
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

function StartScene:defeatArmy( id )
	local deltaScore = self:getDeltaScore(id)
	self.heroScore_ = self.heroScore_ + deltaScore
	self:setScore()
end

function StartScene:getDeltaScore( id )
	return ArmyScore[id]
end

function StartScene:getIndexOfWorld( score )
	local worldSeting = self:getWorldSetting()
	local diffculty = self.diffculty
	local lengthOfSetting =  #worldSeting
	for index = 1 , lengthOfSetting do
		if score <= worldSeting[index] then 
			if diffculty == 1 then 

				return index

			elseif diffculty == 2 then 
				local lastIndex = index + 2
				--如果未到最后就返回这个
				if lastIndex <= lengthOfSetting then 
					return lastIndex
				else 
					return lengthOfSetting
				end
			elseif diffculty == 3 then 
				local lastIndex = index + 5
				if lastIndex <= lengthOfSetting then 
					return lastIndex
				else 
					return lengthOfSetting
				end
			end
		end
	end
	return lengthOfSetting
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


function StartScene:EnterGameOverScene( flagWin  )
	--有没有超过记录
	self:SaveHighestScore()
	self:saveScore()

	--进入到结算场景
	local function getInNext()
		local scene = require("app.GameScene.GameOverScene").new()
		cc.Director:getInstance():replaceScene(scene)
	end
	if flagWin == false then 
		local scene = require("app.GameScene.GameOverScene").new()
		local fadeIn = cc.TransitionFade:create(1,scene, cc.c3b(255, 0, 0) )
		cc.Director:getInstance():replaceScene(fadeIn)
	elseif flagWin == true then 
		self:runAction(cc.Sequence:create( cc.DelayTime:create(1.5),cc.CallFunc:create(getInNext)  ))
	end


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

