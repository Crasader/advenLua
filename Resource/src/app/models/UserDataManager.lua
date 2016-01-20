module("UserDataManager", package.seeall)

--单例
local instance = nil

function new()
	local obj = {}
	setmetatable(obj, {__index = UserDataManager})
	obj:init()
	return obj
end

function getInstance()
	if not instance then 
		instance = UserDataManager.new()
	end
	return instance
end

function init( self )
	self:setMapLevel(1)
	self:setMapRound(1)
	self:setDefaultHp(GameConst.DEAULT_HP)
	self:setDefaultLife(GameConst.DEFAULT_LIFE)
	self:setPlayerScore(0)
	self:setDefaultTime()
end

function initDefault(self)
	self:setDefaultHp(GameConst.DEAULT_HP)
	self:setDefaultLife(GameConst.DEFAULT_LIFE)
	self:setMapRound(1)
	self:setPlayerScore(0)
	self:setDefaultTime()
end

function setHero(self, hero_)
	self.hero_ = hero_
end

function getHero(self)
	return self.hero_
end

--消耗一条生命之后重置生命值
function reset(self)
	self:setDefaultHp(100)
	self:setMapRound(1)
	self:setDefaultTime()
end

function resetTime(self)
	self:setDefaultTime()
end

--设置默认的生命值
function setDefaultLife(self, value)
	self:setLife( value )
end

function setLife(self, value)
	self.life_ = value
end

function addLife(self)
	self:setLife(self:getLife() + 1)
end

function subLife(self)
	self:setLife(self:getLife() - 1)
end

function getLife(self, value)
	return self.life_
end

--设置默认血量
function setDefaultHp( self,value )
	self.hp_ = value
end

function setHp(self, value)
	self.hp_ = value
end

function getHp(self)
	return self.hp_
end

function addHp(self, value)
	self.hp_ = self.hp_ + value
	if self.hp_ >= GameConst.DEAULT_HP then
		self.hp_ = GameConst.DEAULT_HP
	end
end

function subHp( self, value )
	self.hp_ = self.hp_ - value
end

--设置关卡
function setMapLevel( self, level )
	self.mapLevel_ = level
end

function getMapLevel(self)
	return self.mapLevel_
end

--前进一关
function addMapLevel(self)
	self.mapLevel_ = self.mapLevel_ + 1
end

--设置当前玩家的轮数
function setMapRound(self, round)
	self.mapRound_ = round
end

function getMapRound(self)
	return self.mapRound_
end

--前进一轮
function addMapRound(self)
	self.mapRound_ =  self.mapRound_ + 1
end

--获得难度
function getDifficulty(self)
	if not self.difficulty_ then 
		self.diffculty_ = cc.UserDefault:getInstance():getIntegerForKey("Diffcuity", 1)
	end
	return self.diffculty_
end

function setDifficulty(self, difficulty)
	self.diffculty_ = difficulty
	cc.UserDefault:getInstance():setIntegerForKey("Diffcuity", difficulty)
end

--获得玩家姓名
function getPlayerName(self)
	if not self.playerName_ then 
		self.playerName_ = cc.UserDefault:getInstance():getStringForKey("Name", "abc")
	end
	return self.playerName_
end

--设置玩家名字
function setPlayerName(self, name)
	self.playerName_ = name
	cc.UserDefault:getInstance():setStringForKey("Name", name)
end

--设置玩家性别
function setPlayerSex(self, sex)
	self.playerSex_ = sex
	cc.UserDefault:getInstance():setIntegerForKey("Sex", sex)
end

function getPlayerSex(self)
	if not self.playerSex_ then
		self.playerSex_ = cc.UserDefault:getInstance():getIntegerForKey("Sex", 1)
	end 
	-- return self.playerSex_
	--女角色没做好，默认范围男的
	return 1
end

--获得玩家最高分数
function getHighScore(self)
	if not self.highestScore_ then 
		self.highestScore_ = cc.UserDefault:getInstance():getIntegerForKey("HighestScore", 0)
	end
	return self.highestScore_
end

function setHighScore(self, score)
	self.highestScore_ = score
	cc.UserDefault:getInstance():setIntegerForKey("HighestScore", score)
end

--保存玩家分数
function setPlayerScore(self, score)
	self.playerScore_ = score
end

--增加玩家分数
function addPlayerScore(self, score)
	self.playerScore_ = self.playerScore_ + score
end

--获取玩家分数
function getPlayerScore(self)
	return self.playerScore_
end

--设置默认时间
function setDefaultTime(self)
	self:setTime(GameConst.DEFAULT_TIME) 
end

function setTime(self, value)
	self.time_ = value
end

function subTime(self)
	self:setTime(self:getTime() - 1)
end

function addTime(self)
	self:setTime(self:getTime() + 1)
end

function getTime(self)
	return self.time_
end

--摄像机控制
function isMapCameraStop(self)
	return self.isMapCameraStop_ 
end

function mapCameraStop(self)
	self.isMapCameraStop_ = true
end

function mapCameraMove(self)
	self.isMapCameraStop_ = false
end



