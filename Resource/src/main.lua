
cc.FileUtils:getInstance():setPopupNotify(false)
local adress = cc.FileUtils:getInstance():getWritablePath()
cc.FileUtils:getInstance():addSearchPath(adress.."src/",true)
cc.FileUtils:getInstance():addSearchPath(adress.."res/", true)

require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
