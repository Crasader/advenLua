module("HelpFuc", package.seeall)

--获得一段随机数
function getRandom( a, b )
	math.randomseed(os.time())
	if a > b then
		return math.random(b, a) 
	elseif a == b then 
		return 0
	else
		return math.random(a, b)
	end
end