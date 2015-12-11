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
end

--设置关卡
function setMapLevel( self, level )
	self.mapLevel_ = level
end

function getMapLevel(self)
	return self.mapLevel_
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
end

