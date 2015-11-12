module("ArmyFactory", package.seeall)

function createArmy001()
	local army = require("app.views.Army001").new()
	return army
end

function createArmy002(  )
	local army = require("app.views.Army002").new()
	return army
end

function createArmy003(  )
	local army = require("app.views.Army003").new()
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
	if id == 1 then 
		return ArmyFactory.createArmy001()
	elseif id == 2 then 
		return ArmyFactory.createArmy002()
	elseif id == 3 then 
		return ArmyFactory.createArmy003()
	end
end


