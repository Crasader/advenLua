--创建主角的管理者
module("MainRoleManager", package.seeall)

--创建男性角色
function createMaleHero( needPhysics )
	local role = require("app.views.Hero").new( needPhysics )
	if needPhysics == true then 
		role:setPhysics()
	end
	return role
end

--创建女性角色
function createFemaleHero()
	local role = require("app.views.FemaleHero").new()
	return role
end

