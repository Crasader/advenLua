module("EffectFactory", package.seeall)

function createBossFire( id )
	local fire = require("app/Effect/Boss01Fire").new( BulletData[id] )

	return fire
end

--一般被打击中的特效
function createNorAttackEffect()
	local effect = require("app/Effect/NormalAttackEffect").new()

	return effect
end

--一般敌人死亡时候的特效
function createNorDieEffect()
	local effect = require ("app.Effect.ArmyDieEffect").new()

	return effect
end