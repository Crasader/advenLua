local LoadingAssetScene = class("LoadingAssetScene", function (  )
	return cc.Scene:create()
end)

function LoadingAssetScene:ctor(  )
	self:init()
end

function LoadingAssetScene:init(  )
	local title = cc.Label:createWithSystemFont("Loading...", "Courier", 24)

	title:setPosition(cc.p(display.cx, display.cy))
	self:addChild(title)

	self.title = title


	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end

  self:registerScriptHandler(onNodeEvent)
	
end

function LoadingAssetScene:onEnter(  )
	self:readyIntoGame()
end

function LoadingAssetScene:loadingAsset(  )
	--加载plist
	if plistFile then 
		for c,v in pairs (plistFile) do
			print(v)
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

	--载入音乐
	if MusicFile then 
		for key , value in pairs (MusicFile) do
			AudioEngine.preloadMusic(value)
		end
	end

	--载入音效
	if EffectFile then 
		for c,v in pairs (EffectFile) do
			AudioEngine.preloadEffect(value)
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
	local function goToPlay(  )
		local scene = SceneManager.createMainMenuScene()
		cc.Director:getInstance():replaceScene(scene)
	end
	self.title:setString("冒险即将开始...")
	self.title:runAction(cc.Sequence:create( cc.FadeOut:create(1.5), cc.CallFunc:create( goToPlay )) )
end


return LoadingAssetScene
