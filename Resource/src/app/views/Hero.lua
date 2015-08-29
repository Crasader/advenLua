local Hero = class("Hero", function()
	return sp.SkeletonAnimation:create("skeleton.json", "skeleton.atlas", 0.8)
	end)

function Hero:ctor()
	self:setAnimation(0 ,"idle", true)
	self:setPosition(cc.p(display.cx, display.cy))
end

return Hero