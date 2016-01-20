module("GameFuc", package.seeall)

--主角是否与普通的敌人碰撞
function isHeroContactWithNormalArmy( spriteA, spriteB )
	if spriteA and (spriteA:getTag() == const.NORMAL_ARMY) and (spriteB:getTag() == const.HERO) 
		or spriteB and (spriteB:getTag() == const.NORMAL_ARMY) and (spriteA:getTag() == const.HERO) then
		return true
	end
	return false
end  

--主角是否与子弹的碰撞
function isHeroContactWithBullet( spriteA, spriteB )
	if spriteA and (spriteA:getTag() == const.BULLET) and (spriteB:getTag() == const.HERO) 
		or spriteB and (spriteB:getTag() == const.BULLET) and (spriteA:getTag() == const.HERO) then
		return true
	end
	return false
end

--子弹是否与boss碰撞
function isBulletContactWithBoss( spriteA, spriteB )
	if spriteA and (spriteA:getTag() == const.BULLET) and (spriteB:getTag() == const.BOSS) 
		or spriteB and (spriteB:getTag() == const.BULLET) and (spriteA:getTag() == const.BOSS) then
		return true
	end
	return false
end

--子弹是否与普通怪物碰撞
function isBulletContactWithArmy( spriteA, spriteB )
	if spriteA and (spriteA:getTag() == const.BULLET) and (spriteB:getTag() == const.NORMAL_ARMY) 
		or spriteB and (spriteB:getTag() == const.BULLET) and (spriteA:getTag() == const.NORMAL_ARMY) then
		return true
	end
	return false
end

--子弹与子弹的碰撞
function isBulletContactWithBullet(spriteA, spirteB)
	if spriteA and (spriteA:getTag() == const.BULLET) and (spriteB:getTag() == const.BULLET) 
		or spriteB and (spriteB:getTag() == const.BULLET) and (spriteA:getTag() == const.BULLET) then
		return true
	end
	return false
end

--主角是否与墙壁碰撞
function isHeroContactWithWall( spriteA,  spriteB )
	if spriteA and (spriteA:getTag() == const.HERO) and (spriteB:getTag() == const.WALL) 
		or spriteB and (spriteB:getTag() == const.HERO) and (spriteA:getTag() == const.WALL) then
		return true
	end
	return false
end

--是否与死亡碰撞器碰撞
function isContactWithDeadBox( spriteA, spriteB)
	if spriteA and (spriteA:getTag() == const.DEAD_BOX) or spriteB and (spriteB:getTag() == const.DEAD_BOX ) then
		return true
	end
	return false
end

--根据传入碰撞的两个物体获得主角
function getHero( spriteA, spriteB )
	if spirteA and ( spriteA:getTag() == const.HERO ) then 
		return spriteA
	end

	if spriteB and ( spriteB:getTag() == const.HERO ) then 
		return spriteB
	end

	return nil
end

--根据传入碰撞的两个物体获得普通怪物
function getNormalArmy( spriteA, spriteB )
	if spriteA and ( spriteA:getTag() == const.NORMAL_ARMY ) then 
		return spriteA
	end

	if spriteB and ( spriteB:getTag() == const.NORMAL_ARMY ) then 
		return spriteB
	end
end

--根据传入碰撞的两个物体获得子弹
function getBullet( spriteA, spriteB  )
	if spriteA and ( spriteA:getTag() == const.BULLET ) then 
		return spriteA
	end

	if spriteB and ( spriteB:getTag() == const.BULLET ) then 
		return spriteB
	end
end

--根据传入碰撞的两个物体获得boss
function getBoss( spriteA, spriteB )
	if spriteA and ( spriteA:getTag() == const.BOSS ) then 
		return spriteA
	end

	if spriteB and ( spriteB:getTag() == const.BOSS ) then 
		return spriteB
	end
end

--派发事件
function dispatchEvent(eventName)
	local event = cc.EventCustom:new(eventName)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
end

--全局设置调度器速度
function setSpeedScale( scale )
	if not scale then return end
	cc.Director:getInstance():getScheduler():setTimeScale(scale)
end

--添加update函数
function setUpdate(hand, time , isPause)
	return cc.Director:getInstance():getScheduler():scheduleScriptFunc(hand, time, isPause )
end

--取消update函数
function unSetUpdate( id)
	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(id)
end

--获得应该获得的分数
function getNeedScore( score )
	return score
end

--获得应该恢复的Hp
function getRecoverHp( value )
	return value
end