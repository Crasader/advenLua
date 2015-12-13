local MainBg = class("MainBg", function ( fileName )
	return cc.CSLoader:createNode(fileName)
end)

function MainBg:ctor(  )
	self:init()
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end
  	self:registerScriptHandler(onNodeEvent)
end

function MainBg:init(  )
	
end

function MainBg:onEnter(  )
	local size = cc.Director:getInstance():getVisibleSize()
	local scaleFactorY = display.height / self:getContentSize().height
	self:setScaleY(scaleFactorY)
	local scaleFactorX = display.width / self:getContentSize().width
	self:setScaleX(scaleFactorX)
end

function MainBg:setBgFlipX( isFlip )
	if isFlip == nil  then return end
	local farbg = self:getChildByName("back_far")
	if farbg then 
		farbg:setFlippedX(isFlip)
	end

	local nearBg = self:getChildByName("back_fore")
	if nearBg then 
		nearBg:setFlippedX(isFlip)
	end
end

function MainBg:playBloom( tag)
	--如果没有tag代表全部都是这个效果
	local effectFactor = math.random(100, 500) / 1000
	local farbg = self:getChildByName("back_far")
	local nearBg = self:getChildByName("back_fore")
	local act = BloomUp:create(10, 0.0, effectFactor)
	-- if not tag then 
		farbg:runAction( cc.Repeat:create(cc.Sequence:create(act, act:reverse()), 2)  ) 
	-- end
end



return MainBg