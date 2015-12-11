
World1Setting = {
	[1] = 1000,
	[2] = 1500,
	[3] = 1500,
	[4] = 2000,
	[5] = 2500,
	[6] = 3000,
	[7] = 3500,
	[8] = 4000,
	[9] = 5000,
	[10] = 6500,
	[11] = 7500,
	[12] = 8000,
	[13] = 9000,
	[14] = 10000,
	[15] = 12000,
	[16] = 13000,
	[17] = 14000,
	[18] = 15000,
	[19] = 16000,
	[20] = 20000,
	[21] = 22000,
	[22] = 25000,
	[23] = 30000,
	[24] = 35000,
	[25] = 37000,
	[26] = 38000,
	[27] = 39000,
	[28] = 40000,
	[29] = 45000,
	[30] = 50000,
}

World1ArmyCreateTimeEasy = {
	[1] = 2,
	[2] = 1.8,
	[3] = 1.6,
	[4] = 1.5,
	[5] = 1.4,
	[6] = 1.4,
	[7] = 1.4,
	[8] = 1.4,
	[9] = 1.3,
	[10] = 1.3,
	[11] = 1.2,
	[12] = 1.2,
	[13] = 1.2,
	[14] = 1.2,
	[15] = 1.0,
	[16] = 1.0,
	[17] = 1.0,
	[18] = 1.0,
	[19] = 1.0,
	[20] = 1.0,
	[21] = 0.9,
	[22] = 0.9,
	[23] = 0.9,
	[24] = 0.9,
	[25] = 0.9,
	[26] = 0.8,
	[27] = 0.8,
	[28] = 0.8,
	[29] = 0.8,
	[30] = 0.8,
}

World1ArmyCreateTimeNormal = {
	[1] = 2,
	[2] = 1.8,
	[3] = 1.5,
	[4] = 1.5,
	[5] = 1.4,
	[6] = 1.4,
	[7] = 1.4,
	[8] = 1.2,
	[9] = 1.2,
	[10] = 1.2,
	[11] = 1.0,
	[12] = 0.9,
	[13] = 0.9,
	[14] = 0.9,
	[15] = 0.8,
	[16] = 0.8,
	[17] = 0.7,
	[18] = 0.7,
	[19] = 0.7,
	[20] = 0.7,
	[21] = 0.7,
	[22] = 0.6,
	[23] = 0.6,
	[24] = 0.6,
	[25] = 0.6,
	[26] = 0.6,
	[27] = 0.6,
	[28] = 0.6,
	[29] = 0.6,
	[30] = 0.6,
}

World1ArmyCreateTimeHard = {
	[1] = 2,
	[2] = 1.8,
	[3] = 1.6,
	[4] = 1.5,
	[5] = 1.2,
	[6] = 1.2,
	[7] = 1.2,
	[8] = 1.0,
	[9] = 1.0,
	[10] = 1.0,
	[11] = 0.8,
	[12] = 0.8,
	[13] = 0.8,
	[14] = 0.8,
	[15] = 0.6,
	[16] = 0.6,
	[17] = 0.6,
	[18] = 0.6,
	[19] = 0.6,
	[20] = 0.6,
	[21] = 0.6,
	[22] = 0.5,
	[23] = 0.5,
	[24] = 0.5,
	[25] = 0.5,
	[26] = 0.5,
	[27] = 0.5,
	[28] = 0.5,
	[29] = 0.5,
	[30] = 0.5,
}

--设置怪物的数目
World1ArmySetting = {
	[1] = {["Army001"] = 2 , ["Army002"] = 3, ["Army003"] = 5 },
	[2] = {["Army001"] = 3 , ["Army002"] = 5, ["Army003"] = 7 },
}

--怪物出现的顺序
WorldArmyOrderSetting = {
	[1] = { [1] = 1 , [2] = 3, [3] = 2 },
	[2] = { [1] = 2 , [2] = 1, [3] = 3 },
}

--猪的伤害
HurtOfArmy001 = {
	[1] = 15, [2] = 20, [3] = 25
}

--精灵的伤害
HurtOfArmy002 = {
	[1] = 12.5, [2] = 15 , [3] = 20 
}

--蛇的伤害
HurtOfArmy003 = {
	[1] = 10, [2] = 12.5, [3] = 15
}

--击败各个怪物获得的奖励
ArmyScore = {
	[1] = 250, [2] = 150, [3] = 100
}

ArmyInRound = {
	[1] = 20,
	[2] = 30,
	[3] = nil,
	[4] = 50,
	[5] = nil,
	[6] = 70,
	[7] = 100,
}

BossInRound = {
	[3] = 1,
	[5] = 1,
	[8] = 1,
}

WORLD_ONE_ROUND_NUM = 8