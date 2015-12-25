module("GameDataManager", package.seeall)
--用于保存管理一些游戏的数据

--单例
local instance = nil

function new()
	local cls = {}
	setmetatable(cls, {__index = GameDataManager})
	cls:init()
	return cls
end

function getInstance()
	if not instance then 
		instance = GameDataManager.new()
	end
	return instance
end

function init(self)
	self.mapSize_ = cc.size(0, 0)
end

function saveMapSize(self,size)
	self.mapSize_ = size
end

function getMapSize(self)
	return self.mapSize_
end
