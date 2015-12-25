local MainMenuScene = class("MainMenuScene", function()
	return cc.Scene:create()
	end)

function MainMenuScene:ctor()
	local mainPanel = PanelManager.createMainMenuPanel()
	self:addChild(mainPanel)

	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    elseif event == "exit" then 
	    	self:onExit()
	    end
  	end

  	self:registerScriptHandler(onNodeEvent)

	
end

function MainMenuScene:onEnter()
	local hero = MainRoleManager.createMaleHero()
	hero:setPosition(cc.p( display.width + display.cx/2 , display.cy ))
	self:addChild( hero )
	hero:SetLeft()
	hero:Walk()

	local function runHeroIdle()
		hero:Idle()
	end
	local act = cc.Sequence:create( cc.DelayTime:create(1),cc.MoveBy:create(2.4, cc.p(-display.cx, 0)),cc.CallFunc:create( runHeroIdle ) )
	hero:runAction( act )
end

function MainMenuScene:onExit()

end

return MainMenuScene