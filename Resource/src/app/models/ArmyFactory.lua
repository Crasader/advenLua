module("ArmyFactory", package.seeall)

function createArmy001()
	local army = require("app.views.NormalArmy").new(NormalArmyData[1])
	return army
end

function createArmy002(  )
	local army = require("app.views.NormalArmy").new(NormalArmyData[2])
	return army
end

function createArmy003(  )
	local army = require("app.views.NormalArmy").new(NormalArmyData[3])
	return army
end

function createBoss01()
	return require("app.views.Boss001").new()
end

function createBoss( id )
	if id == 1 then 
		return ArmyFactory.createBoss01()
	end
end

function createArmyById( id )
	local army
	if id == 1 then 
		army = ArmyFactory.createArmy001() 
	elseif id == 2 then 
		army = ArmyFactory.createArmy002()
	elseif id == 3 then 
		army = ArmyFactory.createArmy003()
	end
	return army
end


