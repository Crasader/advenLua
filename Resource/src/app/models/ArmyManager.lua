--敌人管理者，管理敌人数据
module("ArmyManager", package.seeall)

function getArmyScore( id )
	return ArmyScore[id]
end