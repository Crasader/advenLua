local LoadingAssetScene = class("LoadingAssetScene", function (  )
	return cc.Scene:create()
end)

function LoadingAssetScene:ctor(  )
	self:init()
end

function LoadingAssetScene:init(  )
	local title = cc.Label:createWithSystemFont("Loading...", "Courier", 50)

	title:setPosition(cc.p(display.cx, display.cy))
	self:addChild(title)

	self.title = title

	require "app.Data.LoadingData"

	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  self:registerScriptHandler(onNodeEvent)
	
end

function LoadingAssetScene:onEnter(  )
	print("loadingAsset~~~~~~~~")
	self:readyIntoGame()
end

function LoadingAssetScene:loadingAsset(  )
	--加载plist
	if plistFile then 
		for c,v in pairs (plistFile) do
			cc.SpriteFrameCache:getInstance():addSpriteFrames(v)
		end
	end

	--加载单张的小图
	if pngFile then 
		for c, v in pairs (pngFile) do
			cc.Director:getInstance():getTextureCache():addImage(v)
		end
	end

	--加载shader
	if shaderFile then 
		for key , value in pairs (shaderFile) do
			local shader = cc.GLProgram:createWithFilenames(value["vert"], value["frag"])
			if shader then 
				cc.GLProgramCache:getInstance():addGLProgram(shader, key)
			end
		end
	end

	return true
end

function LoadingAssetScene:readyIntoGame(  )
	if self:loadingAsset() then 
		self:StartGame()
	else
		self:readyIntoGame()
	end
end

function LoadingAssetScene:StartGame(  )
	local scene = require("app.GameScene.StartScene").new()
	cc.Director:getInstance():replaceScene(scene)
end


return LoadingAssetScene