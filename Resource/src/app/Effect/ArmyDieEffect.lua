local EffectArmyDie = class("EffectArmyDie", function (  )
	return  cc.CSLoader:createNode("Effect/armyDieEffect.csb")
end)

function EffectArmyDie:ctor(  )
	self:init()
end

function EffectArmyDie:init(  )
	self.act = cc.CSLoader:createTimeline("Effect/armyDieEffect.csb")
	self:runAction(self.act)
end

function EffectArmyDie:playEffect(  )
	self.act:play("explore", false)
	self:playDieSound()
end

function EffectArmyDie:playDieSound(  )
	AudioEngine.playEffect("music/effect/monster_die_fire.mp3", false)
end

return EffectArmyDie