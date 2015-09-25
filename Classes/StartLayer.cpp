#include "StartLayer.h"
#include "CCLuaEngine.h"

#include "cocostudio/CocoStudio.h"

USING_NS_CC;
USING_NS_CC_EXT;

using namespace ui;

#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
#include <dirent.h>
#include <sys/stat.h>

#endif

Scene* StartLayer::createScene(){
	auto scene = Scene::create();

	auto layer = StartLayer::create();

	scene->addChild(layer);

	return scene;
}

bool StartLayer::init(){


	this->checkNeedUpdate();



	return true;
}

void StartLayer::checkNeedUpdate(){
	m_address = FileUtils::getInstance()->getWritablePath();



#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
	DIR *pDir = NULL;

	pDir = opendir(m_address.c_str());
	if (!pDir)
	{
		mkdir(m_address.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
	}
#else
	if ((GetFileAttributesA(m_address.c_str())) == INVALID_FILE_ATTRIBUTES)
	{
		CreateDirectoryA(m_address.c_str(), 0);
	}
#endif
	auto size = Director::getInstance()->getWinSize();

	FileUtils::getInstance()->addSearchPath(m_address, true);

	_assetManager = AssetsManager::create("http://112.74.214.142/advenLua.zip",
		"http://112.74.214.142/version.php",
		m_address.c_str(),
		[this](int a){
		log("error,%d", a);
		
		this->goToLua();
		

	},
		[this](int a){
		log("down loading");
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
		text->setText("now is downLoading...");

#else
		text->setText("正在下载");
#endif

		loadingBar->setPercent(a);

	},
		[this](){
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
		text->setText("now is getInto Game...");

#else
		text->setText("正在进入游戏");
#endif

		this->goToLua();


	});
	_assetManager->retain();
	//assetMrg->setConnectionTimeout(3);
	if (_assetManager->checkUpdate()){
		//如果有更新，显示出玩家更新的提示面板
		this->addAssetLayer();
	}
	else{
		this->goToLua();
	}
		

}

void StartLayer::addAssetLayer(){
	FileUtils::getInstance()->addSearchPath("res/", true);
	auto assetNode = CSLoader::createNode("Scene/LoadingAsetLayer.csb");
	
	auto size = Director::getInstance()->getWinSize();
	auto m_size = Size(size.width / 960, size.height / 640);
	assetNode->setScaleX(m_size.width);
	assetNode->setScaleY(m_size.height);
	assetNode->runAction(Sequence::createWithTwoActions(Place::create(Vec2(0, size.height)),
		MoveBy::create(0.3, Vec2(0, -size.height))));
	addChild(assetNode);

	auto btnCancel = assetNode->getChildByName<ui::Button*>("ButtonCancel");
	btnCancel->setTouchEnabled(true);
	btnCancel->addClickEventListener([this](Ref* r){
		this->goToLua();
		
		_assetManager->deleteVersion();
	});

	//设置确定按钮
	auto btnOk = assetNode->getChildByName<ui::Button*>("ButtonOk");
	btnOk->addClickEventListener([this, btnCancel](Ref* r){
		this->startDownload();
		btnCancel->setTouchEnabled(false);
	});

	//获得文本和进度条
	text = assetNode->getChildByName<ui::Text*>("Text");
	loadingBar = assetNode->getChildByName<ui::LoadingBar*>("LoadingBar");

}

void StartLayer::startDownload(){
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
	text->setText("now start downLoading...");
#else
	text->setText("开始下载");
#endif
	
	_assetManager->update();

}

void StartLayer::goToLua(){
	auto engine = LuaEngine::getInstance();
	auto address = m_address + "src/main.lua";
	
	engine->executeScriptFile(address.c_str());
	
	
}