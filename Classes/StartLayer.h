#ifndef __STARTLAYER__

#define __STARTLAYER__

#include "cocos2d.h"
#include "cocos-ext.h"
#include "ui/CocosGUI.h"

USING_NS_CC_EXT;

USING_NS_CC;

class StartLayer : LayerColor {

public:
	static Scene* createScene();

	CREATE_FUNC(StartLayer);

	bool init();

	//检查是否需要更新
	void checkNeedUpdate();

	//添加一个层显示热更新需求
	void addAssetLayer();

	void startDownload();

	//进入lua
	void goToLua();

	void onExit();

public:
	AssetsManager* _assetManager;
	std::string m_address;

	ui::Text* text;
	ui::LoadingBar* loadingBar;
};



#endif //__STARTLAYER__