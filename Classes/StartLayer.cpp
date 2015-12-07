#include "StartLayer.h"
#include "CCLuaEngine.h"
#include "Game/BlurAction.h"
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
	LayerColor::initWithColor(Color4B::BLACK);
	auto size = Director::getInstance()->getVisibleSize();

	FileUtils::getInstance()->addSearchPath("res");
	auto bg = Sprite::create("HelloWorld.png");
	bg->setPosition(size / 2);
	bg->setOpacity(0);
	addChild(bg);
	auto act = BloomUp::create(0.5, 0, 0.4);
	bg->runAction(Sequence::create(FadeIn::create(0.5),act, DelayTime::create(1), RemoveSelf::create(true), NULL));
	this->runAction(Sequence::create(DelayTime::create(2), CallFunc::create([this](){
		this->checkNeedUpdate();
	}), NULL));

	auto title = Label::createWithSystemFont("This Game Developed By", "Courier", 30);
	title->setPosition(Vec2(size.width / 2, bg->getPositionY() + bg->getContentSize().height/2 + 30));
	addChild(title);
	title->runAction(Sequence::create(DelayTime::create(2), RemoveSelf::create(true), NULL));
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

void StartLayer::onExit() 
{
	Node::onExit();
	_assetManager->release();

	Director::getInstance()->getTextureCache()->removeAllTextures();

}
void StartLayer::addAssetLayer(){
	FileUtils::getInstance()->addSearchPath("res/", true);
	auto assetNode = CSLoader::createNode("Scene/LoadingAsetLayer.csb");
	assetNode->setVisible(false);
	auto size = Director::getInstance()->getWinSize();
	auto m_size = Size(size.width / 960, size.height / 640);
	assetNode->setScaleX(m_size.width);
	assetNode->setScaleY(m_size.height);
	addChild(assetNode);

	auto btnCancel = assetNode->getChildByName<ui::Button*>("ButtonCancel");
	btnCancel->setTouchEnabled(true);
	btnCancel->addClickEventListener([this](Ref* r){
		this->goToLua();
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

	assetNode->runAction(Sequence::create(Place::create(Vec2(0, size.height)), Show::create(),
		MoveBy::create(0.3, Vec2(0, -size.height)), NULL));
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