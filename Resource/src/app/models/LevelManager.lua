module("LevelManager", package.seeall)

--根据当前的关卡数创建对应的关卡
function getLevel()
	local level = UserDataManager.getInstance():getMapLevel()
	local map = LevelFactory.createLevelByIndex(level)
	return map
end

--根据关卡获得所有的轮数
function getAllRound()
	local level = UserDataManager.getInstance():getMapLevel()
	if level == 1 then 
		return WORLD_ONE_ROUND_NUM
	elseif level == 2 then 
		return WORLD_TWO_ROUND_NUM
	elseif level == 3 then 
		return WORLD_THREE_ROUND_NUM
	elseif level == 4 then 
		return WORLD_FOUR_ROUND_NUM
	end
	return  WORLD_TWO_ROUND_NUM
end

--根据关卡获得关卡时间
function getLevelTime()
	local level = UserDataManager.getInstance():getMapLevel()
	if level == 1 then 
		return WORLD_ONE_GAMETIME
	elseif level == 2 then 
		return WORLD_TWO_GAMETIME
	elseif level == 3 then 
		return WORLD_THREE_GAMETIME
	elseif level == 4 then
		return WORLD_FOUR_GAMETIME
	else
		return WORLD_FOUR_GAMETIME
	end
end