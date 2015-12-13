--敌人管理者，管理敌人数据
module("ArmyManager", package.seeall)

--根据当前关卡获得敌人的全部信息
function getAllArmy()
	local level = UserDataManager.getInstance():getMapLevel()
	if level ==  1 then 
		return INDEX_OF_ARMY_WORLD_ONE
	elseif level == 2 then
		return INDEX_OF_ARMY_WORLD_TWO
	elseif level == 3 then 
		return INDEX_OF_ARMY_WORLD_THREE
	end

	return INDEX_OF_ARMY_WORLD_ONE
end

--根据当前关卡数获取敌人的轮数索引表
function getRoundArmyIndex()
	local level = UserDataManager.getInstance():getMapLevel()
	if level == 1 then 
		return WorldOneArmyInRound
	elseif level == 2 then 
		return WorldTwoArmyInRound
	elseif level == 3 then 
		return WorldThreeArmyInRound
	end
	return WorldOneArmyInRound
end

--根据当前关卡数获取boss的索引表
function getRoundBossIndex()
	local level = UserDataManager.getInstance():getMapLevel()
	if level == 1 then 
		return WorldOneBossInRound
	elseif level == 2 then 
		return WorldTwoBossInRound
	elseif level == 3 then 
		return WorldThreeBossInRound
	end
	return WorldOneArmyInRound
end

--根据轮数获取敌人的数目
function getArmyNumInRound( round )
	local armyRoundTbl = ArmyManager.getRoundArmyIndex()
	return armyRoundTbl[round]
end

--根据轮数获取boss的id
function getBossInRound( round )
	local bossRoundTbl = ArmyManager.getRoundBossIndex()
	return bossRoundTbl[round]
end

function getArmyById( id )
	local level = UserDataManager.getInstance():getMapLevel()
	local army = ArmyFactory.createArmyById(id)
	return army
end

--获取敌人的速度
function getSpeed( id )
	local level = UserDataManager.getInstance():getMapLevel()
	local round = UserDataManager.getInstance():getMapRound()
	local speedTbl = ArmyManager.getSpeedTbl( id )
	return speedTbl[(level-1)*10+round]
end

--获取敌人速度列表
function getSpeedTbl(id)
	if id == 1 then 
		return Army001Speed
	elseif id == 2 then 
		return Army002Speed
	elseif id == 3 then 
		return Army003Speed
	else
		return Army003Speed
	end
end

--获取对应怪物造成的伤害
function getHurtHp( hurtId )
	local diffculty = UserDataManager.getInstance():getDifficulty()
	if hurtId == 1 then 
		return HurtOfArmy001[diffculty]
	elseif hurtId == 2 then 
		return HurtOfArmy002[diffculty]
	elseif hurtId == 3 then 
		return HurtOfArmy003[diffculty]
	elseif hurtId == 4 then 
		return HurtOfArmy004[diffculty]
	elseif hurtId == 5 then 
		return HurtOfArmy005[diffculty]
	elseif hurtId == 6 then 
		return HurtOfArmy006[diffculty]
	elseif hurtId == 7 then 
		return HurtOfArmy007[diffculty]
	elseif hurtId == 8 then 
		return HurtOfArmy008[diffculty]
	elseif hurtId == 9 then 
		return HurtOfArmy009[diffculty]
	elseif hurtId == 10 then 
		return HurtOfArmy010[diffculty]
	else
		return 20
	end
end

--根据当前的关卡和轮数获取敌人的生产时间
function getCreateArmyTime()
	local diffculty = UserDataManager.getInstance():getDifficulty()
	local level = UserDataManager.getInstance():getMapLevel()
	local round = UserDataManager.getInstance():getMapRound()
	local createTimeTbl = ArmyManager.getCreateTimeSetting( level, diffculty )
	return createTimeTbl[round]
end

--根据关卡获得创建时间
function getCreateTimeSetting( level, diffculty )
	if level == 1 then 
		if diffculty == 1 then 
			return World1ArmyCreateTimeEasy
		elseif diffculty == 2 then 
			return World1ArmyCreateTimeNormal
		elseif diffculty == 3 then 
			return World1ArmyCreateTimeHard
		end
	elseif level == 2 then 
		if diffculty == 1 then 
			return World1ArmyCreateTimeEasy
		elseif diffculty == 2 then 
			return World1ArmyCreateTimeNormal
		elseif diffculty == 3 then 
			return World1ArmyCreateTimeHard
		end
	elseif level == 3 then 
		if diffculty == 1 then 
			return World1ArmyCreateTimeEasy
		elseif diffculty == 2 then 
			return World1ArmyCreateTimeNormal
		elseif diffculty == 3 then 
			return World1ArmyCreateTimeHard
		end
	end
end