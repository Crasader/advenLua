
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
	local hero = require("app.views.Hero").new()
	self:addChild(hero)
  	-- local army = Army001:create()
  	-- self:addChild(army)
end

return MainScene
