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

--根据传入碰撞的两个物体获得主角
function getHero( spriteA, spriteB )
	if spirteA and ( spriteA:getTag() == const.HERO ) then 
		return spriteA
	end

	if spriteB and ( spriteB:getTag() == const.HERO ) then 
		return spriteB
	end
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
