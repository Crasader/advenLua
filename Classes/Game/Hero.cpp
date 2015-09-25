#include "Hero.h"


using namespace spine;
USING_NS_CC;

Hero* Hero::create(){
	auto hero = new Hero();
	
	if (hero->init())
	{
		return hero;
	}
	return false;
}

bool Hero::init(){
	_SkeAnimation = SkeletonAnimation::createWithFile("res/skeleton.json", "res/skeleton.atlas", 0.8);
	_SkeAnimation->setMix("idle", "walk", 0.2);
	_SkeAnimation->setMix("idle", "attack", 0.2);
	this->setAllEvent();
	this->addChild(_SkeAnimation);

	return true;
	
}

void Hero::setAllEvent(){
	_SkeAnimation->setEventListener([this](int trackIndex, spEvent* event){
		if (trackIndex != 1) {
			return;
		}
		if (event->data->intValue == 3) {
			_state = HeroState::attack;
		}
		if (event->data->intValue == 4) {
			_state = HeroState::walk;
		}
	}
	);
}
void Hero::Idle(){
	if (_state != HeroState::idle) {
		_SkeAnimation->setAnimation(0, "idle", true);
		_state = HeroState::idle;
	}
	
}

void Hero::Walk(){
	if (_state != HeroState::walk) {
		_SkeAnimation->setAnimation(0, "walk", true);
		_state = HeroState::walk;
	}
	

}

void Hero::Attack(){
	if (_state != HeroState::attack) {
		_SkeAnimation->setAnimation(1, "attack", false);
		_state = HeroState::attack;
	}
	
	
}

void Hero::Jump(){
	if (_state != HeroState::jump) {
		_SkeAnimation->setAnimation(0, "jump", false);
		_state = HeroState::jump;
	}
	
}

int Hero::getState(){
	return _state;
}