local Army001 = class("Army001", function ()
	return cc.CSLoader:createNode("Npc_pig.csb")
end)

function Army001:ctor( )
	self:getChildByName("Pig"):setFlippedX(true)
	self.act = cc.CSLoader:createTimeline("Npc_pig.csb")
	self:runAction(self.act)
end

function Army001:Walk(  )
	self.act:play("walk", true)
end

function Army001:Idle(  )
	self.act:play("idle", true)
end

return Army001