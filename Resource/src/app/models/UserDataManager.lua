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
	cc.UserDefault:getInstance():setIntegerForKey("Sex", key)
end

function getPlayerSex(self)
	if not self.playerSex_ then
		self.playerSex_ = cc.UserDefault:getInstance():getIntegerForKey("Sex", 1)
	end 
	return self.playerSex_
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



