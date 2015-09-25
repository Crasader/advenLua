#include "BlurAction.h"

USING_NS_CC;

BoxfilterAct* BoxfilterAct::create(float time, float from, float to, bool isSke )
{
	auto filter = new BoxfilterAct();
	filter->init(time, from, to, isSke);
	filter->autorelease();

	return filter;
	
}

bool BoxfilterAct::init(float time, float from, float to, bool isSke)
{
	if (ActionInterval::initWithDuration(time))
	{
		_durition = time;
		_from = from;
		_to = to;
		_deltaNumber = _to - _from;
		_isSke = isSke;
		return true;
	}
		
	return false;
}

BoxfilterAct* BoxfilterAct::clone() const
{
	auto filter = new BoxfilterAct();
	filter->init(_durition, _from, _to, _isSke);
	filter->autorelease();

	return filter;

}

BoxfilterAct* BoxfilterAct::reverse() const
{
	auto filter = BoxfilterAct::create(_durition, _to, _from, _isSke);
	return filter;
}

void BoxfilterAct::startWithTarget(Node *target)
{
	ActionInterval::startWithTarget(target);
	
	
	_num = _from;

	if (_isSke)
		_shader = GLProgram::createWithFilenames("myShader/MVP_Stand.vert", "myShader/BoxFilter.frag");
	else
		_shader = GLProgram::createWithFilenames("myShader/P_Stand.vert", "myShader/BoxFilter.frag");

	_state = target->getGLProgramState();

	_state->setGLProgram(_shader);

	_state->setUniformFloat(_shader->getUniformLocationForName("u_number"), _num);


}

void BoxfilterAct::update(float time)
{
	auto animationInter = 1.0f / Director::getInstance()->getAnimationInterval();
	_num += _deltaNumber / ((animationInter)* _duration);
	_state->setUniformFloat(_shader->getUniformLocationForName("u_number"), _num );
}

//方波特效
EdgeFilterAct* EdgeFilterAct::create(float time, float from, float to, bool isSke)
{
	EdgeFilterAct* filter = new EdgeFilterAct();
	filter->init(time, from, to, isSke);
	filter->autorelease();
	return filter;
}

bool EdgeFilterAct::init(float time, float from, float to, bool isSke)
{
	if (ActionInterval::initWithDuration(time))
	{
		_duration = time;
		_from = from;
		_to = to;
		_deltaNum = _to - _from;
		_isSke = isSke;
		return true;
	}
	return false;
}

void EdgeFilterAct::startWithTarget(Node *target)
{
	ActionInterval::startWithTarget(target);
	_num = _from;

	if (_isSke)
	_shader = GLProgram::createWithFilenames("myShader/MVP_Stand.vert", "myShader/EdgeFilter.frag");
	else
	_shader = GLProgram::createWithFilenames("myShader/P_Stand.vert", "myShader/EdgeFilter.frag");

	_state = target->getGLProgramState();

	_state->setGLProgram(_shader);

	_state->setUniformFloat(_shader->getUniformLocationForName("u_number"), _num);

}

void EdgeFilterAct::update(float time)
{
	auto animationInter = 1.0f/ Director::getInstance()->getAnimationInterval();
	_num += _deltaNum / ((animationInter) * _duration);
	_state->setUniformFloat(_shader->getUniformLocationForName("u_number"), _num);
}

EdgeFilterAct* EdgeFilterAct::clone() const
{
	auto filter = EdgeFilterAct::create(_duration, _from, _to, _isSke);
	return filter;
}

EdgeFilterAct* EdgeFilterAct::reverse() const
{
	auto filter = EdgeFilterAct::create(_duration, _to, _from, _isSke);
	return filter;
}

//锐化特效
SharpFilterAct* SharpFilterAct::create(float time, float from, float to,  bool isSke)
{
	auto filter = new SharpFilterAct();
	
	if (filter->init(time, from, to, isSke))
	{
		filter->autorelease();

		return filter;
	}
	return nullptr;
}

bool SharpFilterAct::init(float time, float from, float to,bool isSke)
{
	if (ActionInterval::initWithDuration(time))
	{
		_from = from;
		_to = to;
		_duration = time;
		_deltaNum = _to - _from;
		_isSke = isSke;
		return true;

	}
	return false;
}

void SharpFilterAct::startWithTarget(Node *target)
{
	ActionInterval::startWithTarget(target);

	_num = _from;

	//set the shader
	if (_isSke)
	_shader = GLProgram::createWithFilenames("myShader/MVP_Stand.vert", "myShader/SharpFilter.frag");
	else
	_shader = GLProgram::createWithFilenames("myShader/P_Stand.vert", "myShader/SharpFilter.frag");

	_state = target->getGLProgramState();

	_state->setGLProgram(_shader);

	_state->setUniformFloat(_shader->getUniformLocationForName("u_number"), _num);

}

void SharpFilterAct::update(float time)
{
	auto animationInter = 1.0f / Director::getInstance()->getAnimationInterval();
	_num += _deltaNum / ((animationInter)* _duration);
	_state->setUniformFloat(_shader->getUniformLocationForName("u_number"), _num);

}

SharpFilterAct* SharpFilterAct::clone() const
{
	auto filter = SharpFilterAct::create(_duration, _from, _to, _isSke);
	return filter;
}

SharpFilterAct* SharpFilterAct::reverse() const
{
	auto filter = SharpFilterAct::create(_duration, _to, _from,_isSke);
	return filter;
}