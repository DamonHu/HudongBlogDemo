#include "HelloWorldScene.h"
#include "AppCommon.h"
#include "cocos-ext.h"
#include "MainGame.h"
USING_NS_CC;
USING_NS_CC_EXT;

Scene* HelloWorld::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::create();
    
    // 'layer' is an autorelease object
    auto layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    
    if ( !Layer::init() )
    {
        return false;
    }

    auto label = Label::createWithTTF("Hello World", "fonts/Marker Felt.ttf", 24);
    
    label->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2,
                            ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height - label->getContentSize().height));

    //背景
    this->addChild(label, 1);

    auto sprite = Sprite::create("startBg.png");

    sprite->setPosition(Vec2(VISIBLESIZE_SIZE.width/2 + ORIGIN_VEC2.x, VISIBLESIZE_SIZE.height/2 + ORIGIN_VEC2.y));

    this->addChild(sprite, 0);
    //关闭按钮
    auto closeItem = MenuItemImage::create(
                                           "CloseNormal.png",
                                           "CloseSelected.png",
                                           CC_CALLBACK_1(HelloWorld::menuCloseCallback, this));
    
    closeItem->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width - closeItem->getContentSize().width/2 ,
                                ORIGIN_VEC2.y + closeItem->getContentSize().height/2));
    
    auto menu = Menu::create(closeItem, NULL);
    menu->setPosition(Vec2::ZERO);
    this->addChild(menu, 1);
    
    //开始按钮
    auto startItem = MenuItemImage::create(
                                           "startBtn.png",
                                           "startBtn.png",
                                           CC_CALLBACK_1(HelloWorld::menuStartPlay, this));
    
    startItem->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width-15 - startItem->getContentSize().width/2 ,
                                ORIGIN_VEC2.y + startItem->getContentSize().height/2+75));
    
    auto startMenu = Menu::create(startItem, NULL);
    startMenu->setPosition(Vec2::ZERO);
    this->addChild(startMenu, 1);
    
   
    
    return true;
}

void HelloWorld::menuStartPlay(cocos2d::Ref* pSender)
{
    CCLOG("startPlay");
    Scene *scene = MainGame::createScene();
    Director::getInstance()->replaceScene(scene);
}

void HelloWorld::menuCloseCallback(Ref* pSender)
{
    Director::getInstance()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
