--创建主角的管理者
module("MainRoleManager", package.seeall)

--创建男性角色
function createMaleHero()
	local role = require("app.views.Hero").new()
	return role
end

--创建女性角色
function createFemaleHero()
	local role = require("app.views.FemaleHero").new()
	return role
end

