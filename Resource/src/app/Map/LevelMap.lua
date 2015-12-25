local LevelMap = class("LevelMap", function (  )
	return cc.TMXTiledMap:create("Map/world02.tmx")
end)

function LevelMap:ctor()

end

return LevelMap