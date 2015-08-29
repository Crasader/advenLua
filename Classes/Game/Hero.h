#ifndef __HERO__
#define __HERO__

#include "cocos2d.h"
#include <spine/spine-cocos2dx.h>
#include "spine/spine.h"

using namespace spine;


USING_NS_CC;

class Hero : public Node {

public:
	enum HeroState
	{
		idle,walk,attack,jump,

	};

	static Hero* create();

	virtual bool init();

	virtual void setAllEvent();

	//idle
	virtual void Idle();

	//walk
	virtual void Walk();

	//attack
	virtual void Attack();

	//jump
	virtual void Jump();

	int getState();




private:
	int _state;
	SkeletonAnimation* _SkeAnimation;
	

};
#endif //__HERO__