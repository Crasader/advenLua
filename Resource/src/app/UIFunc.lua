module("UIFunc", package.seeall)

function MoveDown( node ,height, time )
	if not node then return end
	local h = height or display.cy/2
	local t = time or 0.3
	local act = cc.Sequence:create( cc.Show:create(),cc.MoveBy:create(t, cc.p(0, -h)) )
	node:runAction(act)
end

function MoveUp( node, height, time )
	if not node then return end
	local h = height or display.cy/2
	local t = time or 0.3
	local act = cc.Sequence:create( cc.Show:create(),cc.MoveBy:create(t, cc.p(0, h)) )
	node:runAction(act)
end