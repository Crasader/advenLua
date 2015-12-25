local GamePadPanel = class("GamePadPanel", function()
	return cc.CSLoader:createNode("MainUI/ControlPad.csb")
	end)

function GamePadPanel:ctor()
	local btnLeft = self:getChildByName("Button_Left")

	local btnRight = self:getChildByName("Button_Right")

	local function leftCallback(event)
		if (event.name == "began" or event.name == "moved") then 
			GameFuc.dispatchEvent(EventConst.HERO_MOVE_LEFT)
		end

		if event.name == "ended" or event.name == "cancelled" then 
			GameFuc.dispatchEvent(EventConst.HERO_IDLE)
		end
	end
	btnLeft:onTouch(leftCallback)

	local function rightCallback(event)
		if (event.name == "began" or event.name == "moved") then 
			GameFuc.dispatchEvent(EventConst.HERO_MOVE_RIGHT)
		end

		if event.name == "ended" or event.name == "cancelled" then 
			GameFuc.dispatchEvent(EventConst.HERO_IDLE)
		end
	end
	btnRight:onTouch(rightCallback)
end

return GamePadPanel