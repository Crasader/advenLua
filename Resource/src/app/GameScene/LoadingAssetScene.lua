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

	require "app.Data.LoadingData"

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
		-- self:getIntoForChun()
	else
		self:readyIntoGame()
	end
end

function LoadingAssetScene:getIntoForChun(  )
	local function goToPlay(  )
		local scene = require("app.GameScene.MenuScene").new()
		cc.Director:getInstance():replaceScene(scene)
	end
	math.randomseed(os.time())

	local seed = math.random(1, 5)
	local sp 
	--2和3时候放图
	if seed == 2 then 
		sp = cc.Sprite:create("chun/chun.png")
		sp:setPosition(cc.p( display.cx/2, display.cy * 1.5))
		self:addChild(sp)
		self.title:setOpacity(0)
		sp:setOpacity(0)
		self.title:setSystemFontSize(50)
		self.title:setString("高纯，有你真好...")
		sp:runAction(cc.Sequence:create( cc.FadeIn:create(1.0),cc.DelayTime:create(1.0),cc.FadeOut:create(2.0)) )
	elseif seed == 3 then 
		sp = cc.Sprite:create("chun/chun.png")
		sp:setPosition(cc.p( display.cx/1.5, display.cy * 1.5))
		self:addChild(sp)
		self.title:setOpacity(0)
		self.title:setSystemFontSize(30)
		self.title:setString("亲爱的纯：\n 不知不觉咱们在一起这么久 \n 这么久来也没跟你说过什么情话 \n 这么久以来真是麻烦你的照顾了\n 跟你在一起的每一天都很开心 \n 你不在这里很不习惯 \n 很想念你 \n")
		sp:setOpacity(0)
		sp:runAction(cc.Sequence:create( cc.FadeIn:create(1.0), cc.DelayTime:create(1.0),cc.FadeOut:create(2.0)) )

	else
		self.title:setSystemFontSize(50)
		self.title:setOpacity(0)
		self.title:setString("即将开始你的冒险旅程...")
	end
		self.title:runAction(cc.FadeIn:create(1.0))
		
		self.title:runAction(cc.Sequence:create( cc.DelayTime:create(5.0),cc.FadeOut:create(1.5), cc.CallFunc:create( goToPlay )) )
end

function LoadingAssetScene:StartGame(  )
	local function goToPlay(  )
		local scene = require("app.GameScene.MenuScene").new()
		cc.Director:getInstance():replaceScene(scene)
	end
	self.title:setString("冒险即将开始...")
	self.title:runAction(cc.Sequence:create( cc.FadeOut:create(1.5), cc.CallFunc:create( goToPlay )) )
end


return LoadingAssetScene