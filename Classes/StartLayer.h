#ifndef __STARTLAYER__

#define __STARTLAYER__

#include "cocos2d.h"

USING_NS_CC;

class StartLayer : Layer {

public:
	static Scene* createScene();

	CREATE_FUNC(StartLayer);

	bool init();


};



#endif //__STARTLAYER__