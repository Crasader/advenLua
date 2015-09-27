local GameOverScene = class("GameOverScene", function (  )
	return cc.Scene:create()
end)

function GameOverScene:ctor(  )
	
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

end

function GameOverScene:onEnter(  )
	
end

return GameOverScene