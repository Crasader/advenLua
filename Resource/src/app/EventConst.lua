module("EventConst", package.seeall)

--boss死亡事件
BOSS01_DIE		=  "boss01Die"
BOSS_SHOOT				=  "bossShoot"

--主角打击到普通怪物
HERO_HIT_NORMAL_ARMY  = "heroHitNormalArmy"
--角色被普通怪物打击到
NORMAL_ARMY_HIT_HERO  = "normalArmyHitHero"

--主角死亡事件
HERO_DIE			= "heroDie"
--主角与墙壁碰撞
HERO_ON_WALL		="heroOnWall"
--主角右移事件
HERO_MOVE_RIGHT		= "heroMoveRight"
--主角左移事件
HERO_MOVE_LEFT		= "heroMoveLeft"
--主角静止事件
HERO_IDLE			= "heroIdle"
--主角攻击事件
HERO_ATTACK			="heroAttack"
--主角跳跃事件
HERO_JUMP			="heroJump"

--暂停时间
GAME_CUT  				= "gameCut"
--恢复暂停
GAME_RESUME				= "gameResume"

--进入排名界面
IN_RANK					="inRank"

--背景地图滚动切换事件
CHANGE_MAP				="changeMap"
--滚动摄像机
SCROLL_VIEW				="scrollView"
--自动滚动摄像机
SCROLL_RIGHT 			="scrollRight"
SCROLL_LEFT				="scrollLeft"
--一轮全部敌人死亡的事件
ALL_DIE					="allDie"
--下一轮事件
NEXT_ROUND				="nextRound"


