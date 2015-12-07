local SelectRolePanel = class("SelectRolePanel", function (  )
	return cc.CSLoader:createNode("Scene/SelectRole.csb")
end)

function SelectRolePanel:ctor(  )
	self:initData()

end

function SelectRolePanel:initData(  )
	local btnMaleHero = self:getChildByName("Button_maleHero")
	local btnFemaleHero = self:getChildByName("Button_femaleHero")

	--添加事件
	local btnTbl = {
	[1] = btnMaleHero,
	[2] = btnFemaleHero
}
	for key, value in pairs (btnTbl) do
		local function onTouch( sender, eventType )
			if eventType == ccui.TouchEventType.began then 
				value:runAction( cc.ScaleTo:create(0.1,1.05))
			end
			cc.UserDefault:getInstance():setIntegerForKey("Sex", key)

			if eventType == ccui.TouchEventType.ended then 
				local function GoToNext(  )
					self:getToStart()	
				end
				value:runAction( cc.ScaleTo:create(0.1,1))
				self:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, display.cy)), cc.CallFunc:create(GoToNext)))
			end	
		end
		value:addTouchEventListener( onTouch )

	end
end

function SelectRolePanel:getToStart(  )
	 -- local scene = require("app.GameScene.StartScene").new()
	 local scene = SceneManager.createStartScene()
	cc.Director:getInstance():replaceScene(scene)
end

return SelectRolePanel