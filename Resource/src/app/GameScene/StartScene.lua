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
	AudioManager.setDefault()
	self:updateUI()
	self:createArmySomeTimeLater()
end

function StartScene:onExit()
	GameFuc.setSpeedScale(1)
end

function StartScene:DealWithBossShoot(  )
	--创建子弹
	local id = math.random(1,3)
	local bullet = EffectFactory.createBossFire( id )
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

	--下一轮的事件
	local nextRoundEvent = cc.EventListenerCustom:create( EventConst.NEXT_ROUND, handler(self, self.setNextRound) )

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(nextRoundEvent, self)
end

function StartScene:DealWithResume()
	AudioEngine.resumeMusic()
end

function StartScene:DealWithGamecut(  )
	
end

function StartScene:DealWithBossDie()
	self.boss = nil
	--是否是最后一轮，是就进入结算界面
	if self:isAllRound() then 
		--如果是最后一关
		self:getInNextScene()
	else
		--派发全部敌人死亡，进入下一轮
		self:dispatchAllArmyDie()
	end
end

function StartScene:getInNextScene()
	local function enterResult()
		if UserDataManager.getInstance():getMapLevel() >= GameConst.MAX_MAP_LEVEL then 
			self:EnterResultScene( false )
		else
			self:EnterResultScene( true )	
		end
	end

	--降低音量
	AudioManager.setVolDown()
	self.hero:Walk()
	local act = cc.Sequence:create( cc.MoveBy:create(5, cc.p(display.width, 0)), cc.CallFunc:create(enterResult) )
	self.hero:runAction( act )

end


function StartScene:DealWithHeroDie()
	local function goNext()
		--如果还有生命就重新开始这个关卡
		UserDataManager.getInstance():subLife()
		if UserDataManager.getInstance():getLife() >= 0 then 
			self:EnterResultScene( false )	
		else
			self:EnterGameOverScene( )
		end
	end

	local act = cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(goNext))
	self:runAction(act)
	self.hero:Die()
end

function StartScene:EnterGameOverScene()
	SceneManager.getInOverScene()
end

function StartScene:initData(  )
	--初始化分数
	self:setDefalutRound()
	self:retain()
end

function StartScene:setDefalutRound()
	self:setRound(1)
	local armyNum = self:getArmyInRound(1)
	self:setArmyNum(armyNum)
end

function StartScene:addUI(  )
	local size = cc.Director:getInstance():getVisibleSize()
	local layer = cc.Layer:create()
	self:addChild(layer)
	self.Layer = layer
	--add Back
	local backGround = LevelManager.getLevel()
	local backGround2 = LevelManager.getLevel()
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

	--addTime 
	local timeNode = UIManager.createTimePanel()
	timeNode:setPosition(cc.p(display.width - 260, display.height - 16 ))
	self.Layer:addChild(timeNode, 20)
	self.timeNode = timeNode

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
	physicsWorld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
end

function StartScene:addMainCharacter(  )
	--添加物理世界框
	local wall = PhysicsManager.createWall()
	wall:setPosition(cc.p(display.cx, display.height +  275/2 ))
	self.Layer:addChild(wall,20)

	local sex = UserDataManager.getInstance():getPlayerSex()
	self.hero = self:createHeroById(sex )
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
	self:setScore()
end

function StartScene:createHeroById( id )
	if id == 1 then
		return MainRoleManager.createMaleHero()
	elseif id == 2 then
		return MainRoleManager.createFemaleHero()
	end
end

function StartScene:createArmy(  )
	
	--对应当前轮返回对应敌人的id
	local armyId = self:getArmyId()
	local army = ArmyManager.getArmyById(armyId)
	self:setArmyNum(self:getArmyNum() - 1)
	army:setTag(const.NORMAL_ARMY)
  	army:Walk()
  	army:setPosition(cc.p(display.cx*2, 275/2 + 25))
  	army:setPhysics()
  	self.Layer:addChild(army,10)

  	local speed = ArmyManager.getSpeed(armyId)
  	army:setSpeed(speed)
end

function StartScene:getArmyId()
	local round = self:getRound()
	--根据索引获得对应的怪物id
	local id =self:getArmyIdFromRound(round)
	return id
end

function StartScene:getArmyIdFromRound( round ) 
	--获得当前关卡的所有怪物索引数据
	local allArmy = ArmyManager.getAllArmy()
	--随机得到一个
	return allArmy[math.random(1, #allArmy)]
end

function StartScene:createBoss(  )
	if not self.boss then 
		local bossId = self:getBossId()
		local boss = ArmyFactory.createBoss(bossId)
	  	boss:commIntoGame()
	  	boss:setPosition(cc.p(display.cx* 2.5, 275/2+ 180))
	  	boss:setPhysics()
	  	self.Layer:addChild(boss,10)
	  	self.boss = boss
		--这里应该根据一个表来设置速度
	end
end

--获得boss的id
function StartScene:getBossId()
	local round = self:getRound()
	local id = self:getBossIdFromRound( round )
	return id
end

--通过当前轮获得boss的id
function StartScene:getBossIdFromRound(round)
	if not round then return end
	return ArmyManager.getBossInRound(round)
end

--派发全部怪物死掉
function StartScene:dispatchAllArmyDie()
	GameFuc.dispatchEvent( EventConst.ALL_DIE)
	self:addRound()
end

--设置轮数
function StartScene:setRound( num )
	UserDataManager.getInstance():setMapRound( num )
end

--递增轮数
function StartScene:addRound()
	UserDataManager.getInstance():addMapRound()
end

--获得当前轮数
function StartScene:getRound()
	return UserDataManager.getInstance():getMapRound()
end

--是否是最后一轮
function StartScene:isAllRound()
	local allRound = self:getAllRound()
	local round = self:getRound()
	if allRound <= round then 
		return true
	else
		return false
	end
end

function StartScene:isNeedCreateArmy(  )
	if self:getArmyNum() <= 0 then 
		return false
	else 
		return true
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
		--子弹与子弹不进行碰撞模拟
		elseif GameFuc.isBulletContactWithBullet(spriteA , spriteB) then 
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
			GameFuc.dispatchEvent( EventConst.HERO_DIE )
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
		if self.hero:getState() == const.HERO_ATTACK or self.hero:getState() == const.HERO_AIRATTACK then
			self.effect:setPosition(cc.p(bodyArmy:getPositionX() -20, bodyArmy:getPositionY()))
			self.effect:Strike()

			--设置被打飞的速度
			local score = UserDataManager.getInstance():getPlayerScore()
			local speed = ArmyManager.getSpeed(bodyArmy:getId())
			bodyArmy:getPhysicsBody():setVelocity(cc.p(speed.outX,speed.outY))
			--打击敌人的处理
			--先计算出应该获得的分数
			local score = GameFuc.getNeedScore(bodyArmy:getScore())
			local recoverHp = GameFuc.getRecoverHp(bodyArmy:getRecoverHp())
			self:defeatArmy( score , recoverHp )
			bodyArmy:playDefeatEffect()

			bodyArmy:runAction(cc.Sequence:create( cc.RotateBy:create(1, 720),
				cc.RemoveSelf:create(false)))
		else
			armyId = bodyArmy:getId()
			showHeroInjure( armyId)
		end

	end

	--如果是子弹与主角的碰撞
	if GameFuc.isHeroContactWithBullet(spriteA, spriteB) then 
		--确定第一个为主角
		local bodyHero = GameFuc.getHero( spriteA, spriteB ) 
		local bodyBullet = GameFuc.getBullet( spriteA, spriteB )
		--如果角色是攻击状态就返回
		if self.hero:getState() == const.HERO_ATTACK or self.hero:getState() == const.HERO_AIRATTACK then
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
	local hurtHp = ArmyManager.getHurtHp( hurtId )
	return hurtHp
end

--下一轮的事件
function StartScene:setNextRound()
	local round = self:getRound()
	local allRound = self:getAllRound()
	if round <= allRound then 
		local armyNum = self:getArmyInRound(round)
		if armyNum then 
			self:setArmyNum(armyNum)
			self:createArmySomeTimeLater()
		else
			self:createBoss()
		end
	else
		self:getInNextScene()
	end
end

--获得当前轮敌人出现的个数
function StartScene:getArmyInRound(round)
	if not round then round = 1 end
	local armyNum = ArmyManager.getArmyNumInRound(round)
	return armyNum
end

function StartScene:getAllRound()
	local round = LevelManager.getAllRound()
	return round
end

function StartScene:setArmyNum( num )
	if not num then return end
	self.armyNum = num
end

function StartScene:getArmyNum()
	return self.armyNum
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
			local createArmyTime = self:getArmyCreateTime()
			if time >=  createArmyTime then
				self:createArmy()
				time = 0
			end
		end
		--每秒清除一次
		if cleanTime >= 1 then 
			cleanTime = 0
			self:cleanOutWindowArmy()
			--全部小怪死亡后移动背景
			if self:isAllArmyDie()  then 
				if self:isAllRound() then 
					--如果是最后一关
					self:getInNextScene()
				else
					--派发全部敌人死亡，进入下一轮
					self:dispatchAllArmyDie()
				end
				GameFuc.unSetUpdate(self.armyCreateHandler)
				self.armyCreateHandler = nil
			end
		end
	end
	--如果已经有了这个计时器就先取消再开启
	if self.armyCreateHandler then 
		GameFuc.unSetUpdate(self.armyCreateHandler)
		self.armyCreateHandler = nil
	end
	self.armyCreateHandler = GameFuc.setUpdate(update, 0.1, false )
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

--判断是否全部敌人死亡
function StartScene:isAllArmyDie()
	if self:getArmyNum() > 0 then 
		return false
	end

	local armys = self.Layer:getChildren()
	local sum = 0
	for c, army in pairs (armys) do
		if army then 
			if army:getTag() == const.NORMAL_ARMY then 
				sum = sum + 1
			end
		end
	end

	if sum > 0 then 
		return false
	else
		return true
	end
end

function StartScene:getArmyCreateTime(  )
	--这里可以根据难度不同敌人创建的时间也不同
	return ArmyManager.getCreateArmyTime()
end

function StartScene:setScore(  )
	local score = UserDataManager.getInstance():getPlayerScore()
	self.score:setScore(score)
end

function StartScene:defeatArmy( score , recoverHp)
	local deltaScore = score or 0
	local deltaHp = recoverHp or 0
	UserDataManager.getInstance():addPlayerScore(deltaScore)
	self.hero:addHp(deltaHp)
	self:updateUI()
end

function StartScene:playBgSound(  )
	AudioManager.playWorld1Sound()
end

--进入结算界面
function StartScene:EnterResultScene( flagWin  )
	--有没有超过记录
	self:SaveHighestScore()
	--进入到结算场景
	local function getInNext()
		AudioManager.stop()
		SceneManager.getInNextLevelScene()
	end
	--true 进入下一关，false进入这一关
	if flagWin == false then 
		UserDataManager.getInstance():reset()
		local scene = SceneManager.createLevelScene()
		local fadeIn = cc.TransitionFade:create(1,scene, cc.c3b(255, 0, 0) )
		cc.Director:getInstance():replaceScene(fadeIn)
	elseif flagWin == true then 
		UserDataManager.getInstance():addMapLevel()
		UserDataManager.getInstance():resetTime()
		self:runAction(cc.Sequence:create( cc.DelayTime:create(1.5),cc.CallFunc:create(getInNext)  ))
	end
end

function StartScene:SaveHighestScore(  )
	--获得当前最高的数据
	local hightScore = UserDataManager.getInstance():getHighScore()
	--大于就保存
	local playerScore = UserDataManager.getInstance():getPlayerScore()
	if playerScore > hightScore then 
		UserDataManager.getInstance():setHighScore( playerScore )
	end
end

return StartScene

