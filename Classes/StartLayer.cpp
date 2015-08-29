#include "StartLayer.h"
#include "cocos-ext.h"
#include "CCLuaEngine.h"

USING_NS_CC;
USING_NS_CC_EXT;

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

	auto m_address = FileUtils::getInstance()->getWritablePath();

	

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

	auto lb = Label::createWithSystemFont("startLayer", "Courier", 50);
	lb->setPosition(size / 2);
	addChild(lb);

	FileUtils::getInstance()->addSearchPath(m_address,true);

	auto assetMrg = AssetsManager::create("http://192.168.1.130/advenLua.zip",
		"http://192.168.1.130/version.php",
		m_address.c_str(),
		[lb, m_address](int a){
		log("error,%d",a);
		lb->setString("Error");
		if (a == 2) {
			auto engine = LuaEngine::getInstance();
			auto address = m_address + "src/main.lua";
			engine->executeScriptFile(address.c_str());
		}
	},
		[lb](int a){
		log("down loading");
		lb->setString("downLoading");
	},
		[lb, m_address](){
		log("success~~~~");
		lb->setString("success~~~~~");

		auto engine = LuaEngine::getInstance();
		auto address = m_address + "src/main.lua";
		engine->executeScriptFile(address.c_str());

	});
	assetMrg->retain();
	//assetMrg->setConnectionTimeout(3);
	if (assetMrg->checkUpdate()){
		assetMrg->update();
	};
	
	
	




	return true;
}
