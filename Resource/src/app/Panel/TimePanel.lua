local TimePanel = class("TimePanel", function()
		return cc.CSLoader:createNode("MainUI/TimeLB.csb")
	end)
function TimePanel:ctor()

	self:initData()
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

function TimePanel:initData()
	self.time = self:getChildByName("Time")
end

function TimePanel:addEvent()

end

function TimePanel:onEnter()
	local function update( dt )
		local time = UserDataManager.getInstance():getTime()
		if time > 0 then 
			UserDataManager.getInstance():subTime()
			self:updateTime()
		else
			GameFuc.unSetUpdate(self.handler)
			GameFuc.dispatchEvent( EventConst.HERO_DIE )
		end

	end
	--如果已经有了这个计时器就先取消再开启
	if self.handler then 
		GameFuc.unSetUpdate(self.handler)
		self.handler = nil
	end
	self.handler = GameFuc.setUpdate(update, 1, false )
	self:updateTime()
end

function TimePanel:onExit()
	--如果已经有了这个计时器就先取消再开启
	if self.handler then 
		GameFuc.unSetUpdate(self.handler)
		self.handler = nil
	end
end

--设置血条值
function TimePanel:setTime( value)
	if not value then return end
	self.time:setString(tostring(value))
end

function TimePanel:updateTime()
	self:setTime(tostring(UserDataManager.getInstance():getTime()))
end


return TimePanel