
cc.FileUtils:getInstance():setPopupNotify(false)
local adress = cc.FileUtils:getInstance():getWritablePath()
cc.FileUtils:getInstance():addSearchPath(adress.."src/",true)
cc.FileUtils:getInstance():addSearchPath(adress.."res/", true)

require "config"
require "cocos.init"
require "init"

local function main()
    local scene = require("app.GameScene.LoadingAssetScene").new()
	cc.Director:getInstance():replaceScene(scene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
