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
	self:createGameCutScene()
	self:addEvent()

	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    elseif event == "exit" then 
	    	self:onExit()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)
end

function StartScene:onEnter(  )
	if not AudioEngine.isMusicPlaying() then 
		AudioEngine.resumeMusic()
	end
	self:updateUI()
end

function StartScene:onExit()
	GameFuc.setSpeedScale(1)
end

function StartScene:createGameCutScene()
	self.gamecutScene = SceneManager.createGameCutScene()
	self.gamecutScene:retain()
end

function StartScene:DealWithBossShoot(  )
	--创建子弹
	local bullet = EffectFactory.createBossFire()
	self.Layer:addChild(bullet)
	bullet:setPosition(display.width, display.cy)
	bullet:setSpeed({x= -500, y= 0})
	bullet:Fire()
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
end

function StartScene:DealWithGamecut(  )
	if self.gamecutScene then 
		AudioEngine.pauseMusic()

		local rendTex = self.rendTex
		if not rendTex then 
			rendTex = cc.RenderTexture:create(display.width, display.height)
			rendTex:retain()
			self.rendTex = rendTex
		end
		rendTex:beginWithClear(0, 0, 0, 1.0)
		self.Layer:visit()
		rendTex:endToLua()
		self.gamecutScene:initWithTexture(rendTex:getSprite():getTexture())
		cc.Director:getInstance():pushScene(self.gamecutScene)
	end
end

function StartScene:DealWithBossDie()
	self:EnterGameOverScene( true )	
end

function StartScene:DealWithHeroDie()
	self:EnterGameOverScene( false )	
end

function StartScene:initData(  )
	self.heroScore_ = 0
	self.index = 1
	self.armyNum =  0
	--获得难度选择
	local diffculty = cc.UserDefault:getInstance():getIntegerForKey("Diffcuity", 1)
	self.diffculty = diffculty
	--获得产生的角色的id
	local heroID = cc.UserDefault:getInstance():getIntegerForKey("Sex", 1)
	self.heroId = heroID
	self:retain()
end

function StartScene:addUI(  )
	local size = cc.Director:getInstance():getVisibleSize()
	local layer = cc.Layer:create()
	self:addChild(layer)
	self.Layer = layer
	--add Back
	local backGround = LevelFactory.createLavel1()
	local backGround2 = LevelFactory.createLavel1()
	self.Layer:addChild(backGround)
	self.Layer:addChild(backGround2)
	--控制背景层
	local mapController = ObjectManager.createMapControl(backGround, backGround2)
	self.Layer:addChild(mapController)
	
	--添加暂停键
	local btnZT = UIManager.createCutBtn()
	btnZT:setPosition(cc.p( 50, display.height - 35 ))
	self.Layer:addChild(btnZT,20)

	--add Hp
	local hpPanel = UIManager.createHpBar()
	--初始化设置其hp
	hpPanel:setPosition(cc.p(200, display.height - 20))
	self.hpWidget = hpPanel
	self.Layer:addChild(hpPanel,20)

	--add Score
	local scoreNode = UIManager.createScorePanel()
	
	scoreNode:setPosition(cc.p(display.width - 120, display.height - 16))
	self.Layer:addChild(scoreNode,20)
	self.score = scoreNode
	self:setScore()

	--add Effect
	local effect = EffectFactory.createNorAttackEffect()
	effect:setVisible(false)
	effect:setScale(2)
	effect:setSpeed(3)
	self.Layer:addChild(effect)
	self.effect = effect

end

function StartScene:setPhysicsCondition(  )
	local physicsWorld = self:getPhysicsWorld()
	physicsWorld:setGravity(cc.p(0,-500))
	-- physicsWorld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
end

function StartScene:addMainCharacter(  )
	--添加物理世界框
	local wall = PhysicsManager.createWall()
	wall:setPosition(cc.p(display.cx, display.height +  275/2 ))
	self.Layer:addChild(wall,20)

	self.hero = self:createHeroById(self.heroId )
	self.hero:setPosition(cc.p(display.cx/2, 275 ))
	--最后才设置位置
	self.Layer:addChild(self.hero,10)
  	self:createArmy()

	local x,y = self.hero:getPosition()
	local cameraControl = ObjectManager.createCameraControl(self:getDefaultCamera(), cc.p(x,y))
	self:addChild(cameraControl)

end

--更新UI
function StartScene:updateUI()
	self.hpWidget:setHp(self.hero:getHp())
end

function StartScene:createHeroById( id )
	if id == 1 then
		return MainRoleManager.createMaleHero()
	elseif id == 2 then
		return MainRoleManager.createFemaleHero()
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
	if self.armyNum <= 50 then 
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

		--英雄与普通敌人碰撞不进行碰撞模拟
		if GameFuc.isHeroContactWithNormalArmy( spriteA, spriteB ) then 
			return false
		--英雄与子弹碰撞不进行碰撞模拟
		elseif GameFuc.isHeroContactWithBullet(spriteA, spriteB) then 
			return false
		--子弹与boss不进行碰撞模拟
		elseif GameFuc.isBulletContactWithBoss( spriteA, spriteB ) then 
			return false
		elseif GameFuc.isBulletContactWithArmy( spriteA, spriteB ) then 
			return false
		else
			return true
		end
	end

	local physicsListener = cc.EventListenerPhysicsContact:create()
	physicsListener:registerScriptHandler(onContactBegan, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
	local eventDispatcker = self:getEventDispatcher()
	eventDispatcker:addEventListenerWithSceneGraphPriority(physicsListener, self)
end

function StartScene:dealPhysicsContact( spriteA, spriteB )
	local function showHeroInjure( hurtId )
		self.hero:Injure()
		local deltaHp = self:getDeltaHp( hurtId )
		self.hero:MinitesHp(deltaHp)
		if self.hero:getHp() <= 0 then
			--停止缓慢低地弹出游戏
			local event =  cc.EventCustom:new(EventConst.HERO_DIE)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
		end
		if self.hpWidget then 
			self.hpWidget:setHp(self.hero:getHp() )
		end
	end

	--如果是普通敌人与主角的碰撞
	if GameFuc.isHeroContactWithNormalArmy( spriteA, spriteB ) then 
		--确定第一个为主角
		local bodyHero = GameFuc.getHero( spriteA, spriteB ) 
		local bodyArmy = GameFuc.getNormalArmy( spriteA, spriteB )
		if self.hero:getState() == "ATTACK" or self.hero:getState() == "AIRATTACK" then
			self.effect:setPosition(cc.p(bodyArmy:getPositionX() -20, bodyArmy:getPositionY()))
			self.effect:Strike()

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
		if self.hero:getState() == "ATTACK" or self.hero:getState() == "AIRATTACK" then
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

	--主角与地板的碰撞
	if GameFuc.isHeroContactWithWall( spriteA, spriteB ) then 
		local event = cc.EventCustom:new( EventConst.HERO_ON_WALL )
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
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
	local cleanTime = 0
	local function update( deta )
		time = time + deta
		cleanTime = cleanTime + deta
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

		--每秒清除一次
		if cleanTime >= 1 then 
			cleanTime = 0
			self:cleanOutWindowArmy()
		end
	end
	self.numUpdate = update
	self:scheduleUpdateWithPriorityLua(update, 0)
end

--清除在界面外面的敌人
function StartScene:cleanOutWindowArmy()
	local armys = self.Layer:getChildren()
	for c, army in pairs (armys) do
		if army then 
			if army:getPositionX() < 0 and army:getTag() == const.NORMAL_ARMY then 
				army:removeFromParent()
			end
		end
	end
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
	self.score:setScore(self.heroScore_)
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
	AudioManager.playWorld1Sound()
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

