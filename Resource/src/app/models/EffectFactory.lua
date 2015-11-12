module("EffectFactory", package.seeall)

function createBossFire(  )
	local fire = require("app/Effect/Boss01Fire").new()

	return fire
end