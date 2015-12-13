local LoadingAssetScene = class("LoadingAssetScene", function (  )
	return cc.Scene:create()
end)

function LoadingAssetScene:ctor(  )
	self:init()
end

function LoadingAssetScene:init(  )
	
	local function onNodeEvent(event)
	    if event == "enter" then
	        self:onEnter()
	    end
  	end
  	self.pngFileNum = 0.0
  	self.allPngBum = #pngFile

  self:registerScriptHandler(onNodeEvent)
	
end

function LoadingAssetScene:onEnter(  )
	local str = string.format("%02d", self.pngFileNum/self.allPngBum)
	local title = cc.Label:createWithSystemFont(str, "Courier", 42)

	title:setPosition(cc.p(display.width - 200, 100))
	self:addChild(title)

	self.title = title
	
	self:readyIntoGame()
end

function LoadingAssetScene:afterLoading()
	self.pngFileNum = self.pngFileNum + 1.0
	self:updateTitle()
	if self.pngFileNum >= self.allPngBum then 
		self:loadingAsset()
	else
		display.loadImage(pngFile[self.pngFileNum],function (  )
			self:afterLoading()
		end)
	end
end

function LoadingAssetScene:updateTitle()
	local str = string.format("%02d", self.pngFileNum /self.allPngBum * 100 )
	str = str.."%"
	if self.title then 
		self.title:setString(str)
	end
end

function LoadingAssetScene:loadTex()
	--加载单张的小图
	if pngFile then 
		display.loadImage(pngFile[1],function (  )
			self:afterLoading()
		end)
	end

	return true

end

function LoadingAssetScene:loadingAsset(  )

	--加载plist
	if plistFile then 
		for c,v in pairs (plistFile) do
			print(v)
			cc.SpriteFrameCache:getInstance():addSpriteFrames(v)
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

	UserDataManager.getInstance()

	local ifno = cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
    print("ifno", ifno)
	self:StartGame()
end

function LoadingAssetScene:readyIntoGame(  )
	self:loadTex()
end


function LoadingAssetScene:StartGame(  )
	local scene = SceneManager.createMainMenuScene()
	cc.Director:getInstance():replaceScene(scene)
end


return LoadingAssetScene
