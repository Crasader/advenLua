plistFile = {
	[1] = "plist/1001.plist",
	[2] = "plist/1002.plist",
	[3] = "plist/1003.plist",
	[4] = "comon/UI_BigMap_Common01.plist",
	[5] = "comon/UI_Common_Common01.plist",
	[6] = "comon/UI_Common_Common02.plist",
	[7] = "comon/UI_Monster_common.plist",
	[8] = "SkillImg/ByStrike01_effect-hd.plist",
	[9] = "SkillImg/ByStrike04_effect.plist",
	[10] = "comon/UI_Fight_Common01.plist",
	[11] = "plist/7005.plist"
}

pngFile = {
	[1] = "skeleton.png",
	[2] = "comon/UI_loading_blood_01.png",
	[3] = "comon/UI_loading_blood_02.png",
	[4] = "Map/Stage_BackGroup01_far.png",
	[5] = "Map/Stage_BackGroup01_near.png",
}

shaderFile = {
	["SharpFilterP"] ={["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/SharpFilter.frag"} ,
	["SharpFilterMVP"] ={["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/SharpFilter.frag"} ,
	["EdgeFilterMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/EdgeFilter.frag"},
	["EdgeFilterP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/EdgeFilter.frag"},
	["BoxFilterMVP"] = {["vert"] = "myShader/MVP_Stand.vert", ["frag"] = "myShader/BoxFilter.frag"},
	["BoxFilterP"] = {["vert"] = "myShader/P_stand.vert", ["frag"] = "myShader/BoxFilter.frag"},
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