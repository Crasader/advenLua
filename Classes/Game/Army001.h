#ifndef __ARMY001__
#define __ARMY001__

#include "cocos2d.h"

#include "cocostudio/CocoStudio.h"

USING_NS_TIMELINE;

USING_NS_CC;

class Army001 :public Node {
public:
	enum State
	{
		WALK, IDLE, MELEE, HIT
	};

	static Army001* create();

	virtual bool init();

	void Walk();

	void Idle();

	Node* getBody();


private:
	ActionTimeline* _act;
	State _state;
	Node* _body;

};

#endif //__ARMY001__