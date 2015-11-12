local GameCutScene = class("GameCutScene", function ()
	return cc.Scene:create()
end)

function GameCutScene:ctor(  )
	
end

function GameCutScene:initWithTexture( tex )
	if self.bg then 
		self.bg:initWithTexture(tex)
		return 
	end

	local bg = cc.Sprite:createWithTexture(tex)
	bg:setPosition(cc.p(display.cx, display.cy))
	bg:setFlippedY(true)
	
	self.bg = bg
	self:addChild(bg)
end

function GameCutScene:toGuass()
	local  shader = cc.GLProgram:createWithFilenames("myShader/P_stand.vert", "myShader/Blur.frag");
	local gs = cc.GLProgramState:create(shader)
	gs:setUniformFloat(shader:getUniformLocationForName("blurRadius"), 15.0)
	if shader then 
		self.bg:setGLProgramState(gs)
	end
end

return GameCutScene