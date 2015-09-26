ArmyFactory = {}

function ArmyFactory.createArmy001()
	local army = require("app.views.Army001").new()
	return army
end

function ArmyFactory.createArmy002(  )
	local army = require("app.views.Army002").new()
	return army
end

function ArmyFactory.createArmy003(  )
	local army = require("app.views.Army003").new()
	return army
end

function ArmyFactory.createArmyById( id )
	if id == 1 then 
		return ArmyFactory.createArmy001()
	elseif id == 2 then 
		return ArmyFactory.createArmy002()
	elseif id == 3 then 
		return ArmyFactory.createArmy003()
	end
end


