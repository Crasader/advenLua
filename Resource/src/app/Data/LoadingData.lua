plistFile = {
	"plist/1001.plist",
	"plist/1002.plist",
	"plist/1003.plist",
	"plist/7005.plist",
	"comon/UI_BigMap_Common01.plist",
	"comon/UI_BuyGandD_Btn_Common.plist",
	"comon/UI_Common_Common01.plist",
	"comon/UI_Common_Common02.plist",
	"comon/UI_Fight_Common01.plist",
	"comon/UI_GameOverShow_Common.plist",
	"comon/UI_Monster_common.plist",
	"comon/UI_Monster_common.plist",
	"comon/UI_Ready_Common01.plist",
	"SkillImg/ByStrike01_effect-hd.plist",
	"SkillImg/ByStrike04_effect.plist",
}

pngFile = {
	"Spine/femaleHero.png",
	"Spine/maleHero.png",
	"comon/UI_loading_blood_01.png",
	"comon/UI_loading_blood_02.png",
	"Map/Stage_BackGroup01_far.png",
	"Map/Stage_BackGroup01_near.png",
}

shaderFile = {
	["SharpFilterP"] ={["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/SharpFilter.frag"} ,
	["SharpFilterMVP"] ={["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/SharpFilter.frag"} ,
	["EdgeFilterMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/EdgeFilter.frag"},
	["EdgeFilterP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/EdgeFilter.frag"},
	["BoxFilterMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/BoxFilter.frag"},
	["BoxFilterP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/BoxFilter.frag"},
	["BloomUpMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/BloomUp.frag"},
	["BloomUpP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/BloomUp.frag"},
	["BlurFilterMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/Blur.frag"},
	["BlurFilterP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/Blur.frag"},
	["RedFilterMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/RedFilter.frag"},
	["RedFilterP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/RedFilter.frag"},

}

--背景音乐
MusicFile = {
	["World1"] = "music/bg/World1.mp3",
}

--音效
EffectFile = {
	[1] = "music/effect/monster_damage.mp3",
	[2] = "music/effect/monster_die_fire.mp3",
	[3] = "music/effect/hero_attack.mp3",
}