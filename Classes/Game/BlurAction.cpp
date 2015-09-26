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

		if (_isSke)
		{
			this->setShader("BoxFilterMVP");
		}
		else
		{
			this->setShader("BoxFilterP");
		}

		_state = GLProgramState::getOrCreateWithGLProgram(_shader);
		return true;
	}
		
	return false;
}

void BoxfilterAct::setShader(std::string name)
{
	auto shader = GLProgramCache::getInstance()->getGLProgram(name);
	if (shader != nullptr)
	{
		_shader = shader;
	}
	else
	{
		if (_isSke)
		_shader = GLProgram::createWithFilenames("myShader/MVP_Stand.vert", "myShader/BoxFilter.frag");
		else 
		_shader = GLProgram::createWithFilenames("myShader/P_stand.vert", "myShader/BoxFilter.frag");

		GLProgramCache::getInstance()->addGLProgram(_shader, name);
	}
	
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
	target->setGLProgramState(_state);
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

		if (_isSke)
		{
			this->setShader("EdgeFilterMVP");
		}
		else
		{
			this->setShader("EdgeFilterP");
		}

		_state = GLProgramState::getOrCreateWithGLProgram(_shader);

		return true;
	}
	return false;
}

void EdgeFilterAct::setShader(std::string key)
{
	auto shader = GLProgramCache::getInstance()->getGLProgram(key);
	if (shader != nullptr)
	{
		_shader = shader;
	}
	else
	{
		if (_isSke)
			_shader = GLProgram::createWithFilenames("myShader/MVP_Stand.vert", "myShader/EdgeFilter.frag");
		else 
			_shader = GLProgram::createWithFilenames("myShader/P_stand.vert", "myShader/EdgeFilter.frag");

		GLProgramCache::getInstance()->addGLProgram(_shader, key);

	}
}

void EdgeFilterAct::startWithTarget(Node *target)
{
	ActionInterval::startWithTarget(target);
	_num = _from;
	target->setGLProgramState(_state);

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

		//set the shader
		if (_isSke)
			this->setShader("SharpFilterMVP");
		else
			this->setShader("SharpFilterP");
			

		_state = GLProgramState::getOrCreateWithGLProgram(_shader);

		return true;

	}
	return false;
}

void SharpFilterAct::setShader(std::string key)
{
	auto shader = GLProgramCache::getInstance()->getGLProgram(key);
	if (shader != nullptr)
	{
		_shader = shader;
	}
	else
	{
		if (_isSke)
			_shader = GLProgram::createWithFilenames("myShader/MVP_Stand.vert", "myShader/SharpFilter.frag");
		else 
			_shader = GLProgram::createWithFilenames("myShader/P_stand.vert", "myShader/SharpFilter.frag");

		GLProgramCache::getInstance()->addGLProgram(_shader, key);
	}
}

void SharpFilterAct::startWithTarget(Node *target)
{
	ActionInterval::startWithTarget(target);

	_num = _from;

	target->setGLProgramState(_state);

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