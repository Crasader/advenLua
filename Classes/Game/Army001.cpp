#include "Army001.h"


USING_NS_CC;

Army001* Army001::create(){
	auto npc = new Army001();

	if (npc->init()) {
		return npc;
	}
}

bool Army001::init(){

	_body = CSLoader::createNode("Npc_pig.csb");

	_body->getChildByName<Sprite*>("Pig")->setFlippedX(true);

	//this->setPhysicsBody(PhysicsBody::createCircle(_body->getChildByName<Sprite*>("Pig")->getContentSize().width / 4));
	this->addChild(_body);
	_act = CSLoader::createTimeline("Npc_pig.csb");
	_body->runAction(_act);


	return true;
}

Node* Army001::getBody(){
	return _body;
}

void Army001::Walk(){
	if (_state != Army001::WALK){
		_act->play("walk", true);
		_state = Army001::WALK;
	}
	
}

void Army001::Idle(){
	if (_state != Army001::IDLE){
		_act->play("idle", true);
		_state = Army001::IDLE;
	}
	
}