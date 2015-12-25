local SkillPanel = class("SkillPanel", function (  )
	return cc.CSLoader:createNode("MainUI/AttackPanel.csb")
end)

function SkillPanel:ctor()
	local attackBtn = self:getChildByName("Button_Attack")

	local jumpBtn = self:getChildByName("Button_Jump")

	local function attackCallback(event)
		if (event.name == "began" ) then 
			GameFuc.dispatchEvent(EventConst.HERO_ATTACK)
		end
	end
	attackBtn:onTouch(attackCallback)

	local function jumpCallback(event)
		if (event.name == "began") then 
			GameFuc.dispatchEvent(EventConst.HERO_JUMP)
		end

	end
	jumpBtn:onTouch(jumpCallback)
end

return SkillPanel