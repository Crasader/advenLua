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

function createArmy004()
	local army = require("app.views.NormalArmy").new(NormalArmyData[4])
	return army
end

function createArmy005()
	local army = require("app.views.NormalArmy").new(NormalArmyData[5])
	return army
end

function createArmy006()
	local army = require("app.views.NormalArmy").new(NormalArmyData[6])
	return army
end

function createArmy( id )
	local army = require("app.views.NormalArmy").new(NormalArmyData[id])
	return army
end


function createBoss01()
	local boss = require("app.views.NormalBoss").new(NormalBossData[1])
	return boss
end

function createBoss02()
	local boss = require("app.views.NormalBoss").new(NormalBossData[2])
	return boss
end

function createBossById( id )
	local boss = require("app.views.NormalBoss").new(NormalBossData[id])
	return boss
end

function createBoss( id )
	if id == 1 then 
		return ArmyFactory.createBoss01()
	elseif id == 2 then 
		return ArmyFactory.createBoss02()
	else
		return ArmyFactory.createBossById( id )
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
	elseif id == 4 then 
		army = ArmyFactory.createArmy004()
	elseif id == 5 then 
		army = ArmyFactory.createArmy005()
	elseif id == 6 then 
		army = ArmyFactory.createArmy006()
	else
		army = ArmyFactory.createArmy( id )
	end
	return army
end


