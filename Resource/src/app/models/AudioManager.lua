module("AudioManager", package.seeall)

--播放World1的背景音乐
function playWorld1Sound()
	AudioEngine.playMusic("music/bg/World1.mp3", true)
end

--播放男角色攻击的音效
function playMaleAttEffect()
	AudioEngine.playEffect( "music/effect/hero_attack.mp3" )
end

--播放敌人被打击中的音效
function playArmyHitEffect()
	AudioEngine.playEffect("music/effect/monster_damage.mp3", false)
end

--播放敌人死亡消失的音效
function playArmyDieEffect()
	AudioEngine.playEffect("music/effect/monster_die_fire.mp3", false)
end