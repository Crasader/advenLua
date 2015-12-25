module("LayerManager", package.seeall)

local instance = nil 

function new()
	local obj = {}
	setmetatable(obj, {__index = LayerManager})
	obj:init()
	return obj
end

function getInstance()
	if not instance then 
		instance = LayerManager.new()
	end
	return instance
end

function init(self)
	self.layer_ = {}
end

function addLayer(self, layer, id)
	local scene = cc.Director:getInstance():getRunningScene()
	scene:addChild(layer)
	self.layer_[id] = layer
end

function removeLayer(self, id)
	local layer = self.layer_[id]
	if not layer then return end
	layer:removeFromParent()
	self.layer_[id] = nil
end

function getLayer(self, id)
	return self.layer_[id]
end

function cleanLayer(self)
	for c,v in pairs (self.layer_) do
		v:removeFromParent()
		self.layer_[c] = nil
	end
end


