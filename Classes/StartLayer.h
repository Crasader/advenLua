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

	//����Ƿ���Ҫ����
	void checkNeedUpdate();

	//���һ������ʾ�ȸ�������
	void addAssetLayer();

	void startDownload();

	//����lua
	void goToLua();

	void onExit();

public:
	AssetsManager* _assetManager;
	std::string m_address;

	ui::Text* text;
	ui::LoadingBar* loadingBar;
};



#endif //__STARTLAYER__