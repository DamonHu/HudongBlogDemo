//
//  MainGame.cpp
//  ballgame
//
//  Created by Damon on 16/5/7.
//
//

#include "MainGame.h"
#include "AppCommon.h"
#include "HelloWorldScene.h"
#include <string>
#include <stdlib.h>
#include <time.h>
cocos2d::Scene* MainGame::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::create();
    
    // 'layer' is an autorelease object
    auto layer = MainGame::create();
    
    // add layer as a child to scene
    scene->addChild(layer);
    
    // return the scene
    return scene;
}

bool MainGame::init()
{
    if ( !Layer::init() )
    {
        return false;
    }
    m_fScore = 0.0;
    hasRun = false;
    m_hightScore = UserDefault::getInstance()->getIntegerForKey("hightScore");
    //背景层
    Sprite *gameBG= Sprite::create("gameBg.png");
    gameBG->setPosition(Vec2(VISIBLESIZE_SIZE.width/2 + ORIGIN_VEC2.x, VISIBLESIZE_SIZE.height/2 + ORIGIN_VEC2.y));
    this->addChild(gameBG, 0);
    //左按钮
    leftItem = MenuItemImage::create(
                                           "left.png",
                                           "left.png",
                                           CC_CALLBACK_1(MainGame::menuLeftCallback, this));
    
    leftItem->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2-46,
                                ORIGIN_VEC2.y + 20));
    auto leftMenu = Menu::create(leftItem, NULL);
    leftMenu->setPosition(Vec2::ZERO);
    this->addChild(leftMenu, 1);
    
    //右按钮
    rightItem = MenuItemImage::create(
                                          "right.png",
                                          "right.png",
                                          CC_CALLBACK_1(MainGame::menuRightCallback, this));
    
    rightItem->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+46,ORIGIN_VEC2.y + 20));
    auto rightMenu = Menu::create(rightItem, NULL);
    rightMenu->setPosition(Vec2::ZERO);
    this->addChild(rightMenu, 1);
    //暂停开始
    pauseItem = MenuItemImage::create("pause.png","pause.png",CC_CALLBACK_1(MainGame::menuPauseGame, this));
    pauseItem->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width-16,
                                ORIGIN_VEC2.y +VISIBLESIZE_SIZE.height-16));
    auto pauseMenu = Menu::create(pauseItem, NULL);
    pauseMenu->setPosition(Vec2::ZERO);
    this->addChild(pauseMenu, 1);
    
    initLayerItem();
    
    //规则说明
    auto Numlabel = Label::createWithTTF("红色 横\n蓝色 竖\n黄色 圆圈\n白色 V型\n", "fonts/DFPKanTingLiuW9.ttf", 8);
    
    Numlabel->setPosition(Vec2(ORIGIN_VEC2.x + Numlabel->getContentSize().width/2+5,
                               ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height-70 - Numlabel->getContentSize().height));
    this->addChild(Numlabel);
    
    
    //各种手势
    auto listener = EventListenerTouchOneByOne::create();
    listener->onTouchBegan = [&](Touch* touch,Event*event){
        CCLOG("begin");
        ccp_last = Director::getInstance()->convertToGL(touch->getLocationInView());
        b_click = true;
        b_circle = false;
        b_V = false;
        gd_direction = kGDirectionNo;
        for (int i=0; i<4; i++) {
            cache_directionshape[i] = false;
        }
        return true;
    };
    
    listener->onTouchMoved = [&](Touch* touch,Event*event){
         CCLOG("move");
        b_click = false;
        ccp_now = Director::getInstance()->convertToGL(touch->getLocationInView());
        //添加轨迹
        Sprite *sprite = Sprite::create("black.png");
        sprite->setPosition(ccp_now);
        this->addChild(sprite);
        auto func =[=](){
            sprite->removeFromParent();
        };
        CallFunc *callFun = CallFunc::create(func);
        Sequence *seq = Sequence::create(CCDelayTime::create(1),callFun, NULL);
        sprite->runAction(seq);
        //
        float adsx = ccp_now.x - ccp_last.x;
        float adsy = ccp_now.y - ccp_last.y;
        if (std::abs(adsx)>std::abs(adsy)) {
            if (adsx<0) {   //从右往左移
                CCLOG("从右往左移");
                cache_directionshape[0] = 1;
            }
            else{   //从左往右
                 CCLOG("从左往右");
                cache_directionshape[1] = 1;
            }
        }
        else
        {
            if(adsy < 0) {  //从上往下移
                CCLOG("从上往下移");
                
                cache_directionshape[2] = 1;
            }
            else{   //从下往上移
                CCLOG("从下往上移");
                cache_directionshape[3] = 1;
            }
        }
        //画圆
        int x = 0;
        for (int i = 0 ; i< 4 ; i++)
        {
            if(cache_directionshape[i])
                x++;
        }
        if(x >= 3){
            CCLOG("圈");
            b_circle = true;
        }
        if ((x==2)&&(cache_directionshape[2]==1)&&(cache_directionshape[1]==1||cache_directionshape[0]==1)) {
            CCLOG("V");
            b_V = true;
        }
       
    };
    
    listener->onTouchEnded = [&](Touch* touch,Event*event){
        CCLOG("end");
        //圆形;
        if(b_click) {
            return;
        }
        float adsx = ccp_now.x - ccp_last.x;
        float adsy = ccp_now.y - ccp_last.y;
        if(std::abs(adsx) > std::abs(adsy))   //X方向增量大
        {
            if(adsx < 0){
                gd_direction = kGDirectionLeft;
            }
            else{
                gd_direction = kGDirectionRight;
            }
        }
        else
        {
            if(adsy < 0){
                gd_direction = kGDirectionDown;
            }
            else{
                gd_direction = kGDirectionUp;
            }
        }
        if (b_circle) {
            gd_direction = kGDirectionCircle;
        }
        else if(b_V) {
            gd_direction = kGDirectionV;
        }
        cleanDike();
    };
    
    _eventDispatcher->addEventListenerWithSceneGraphPriority(listener, this);
    
    
    
    return true;
}

//清除障碍物
void MainGame::cleanDike()
{
    CCLOG("cleanDike");
    if (hasRun) {
        if (redSprite->isVisible()) {
            if ((gd_direction == kGDirectionRight)||(gd_direction == kGDirectionLeft)) {
                redSprite->setVisible(false);
                m_fScore = m_fScore+100;
            }
        }
        if (yellowSprite->isVisible()) {
            if (gd_direction ==kGDirectionCircle) {
                yellowSprite->setVisible(false);
                m_fScore = m_fScore+200;
                b_circle = false;
            }
        }
        if (whiteSprite->isVisible()) {
            if (gd_direction ==kGDirectionV) {
                whiteSprite->setVisible(false);
                m_fScore = m_fScore+300;
                b_V = false;
            }
        }
        if (blueSprite->isVisible()) {
            if ((gd_direction == kGDirectionUp)||(gd_direction == kGDirectionDown)) {
                blueSprite->setVisible(false);
                m_fScore = m_fScore+400;
            }
        }
//        if (purpleSprite->isVisible()) {
//            if (b_circle) {
//                purpleSprite->setVisible(false);
//                m_fScore = m_fScore+500;
//                b_circle = false;
//            }
//        }

    }
}

void MainGame::initLayerItem()
{
    //游戏层
    gameLayer = Layer::create();
    gameLayer->setContentSize(Size(240, ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height));
    gameLayer->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2, ORIGIN_VEC2.y+160);
    this->addChild(gameLayer);
    //主角的球
    heroBall = Sprite::create("ball.png");
    heroBall->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2,
                               ORIGIN_VEC2.y + 80));
    this->addChild(heroBall);
    
    //暂停层
    auto pauseLabel = Label::createWithTTF("游戏暂停", "fonts/DFPKanTingLiuW9.ttf", 24);
    
    pauseLabel->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2,
                            ORIGIN_VEC2.y + pauseLabel->getContentSize().height));
    pauseLayer = LayerColor::create(Color4B(100, 100, 100, 100), ORIGIN_VEC2.x+VISIBLESIZE_SIZE.width, 90);
    pauseLayer->setPosition(Vec2::ZERO);
    pauseLayer->addChild(pauseLabel);
    this->addChild(pauseLayer,2);
    pauseLayer->setVisible(false);
    //最高分
    auto Numlabel1 = Label::createWithTTF("最高得分", "fonts/DFPKanTingLiuW9.ttf", 12);
    
    Numlabel1->setPosition(Vec2(ORIGIN_VEC2.x + Numlabel1->getContentSize().width/2+5,
                               ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height - Numlabel1->getContentSize().height));
    this->addChild(Numlabel1);
    
    hightScoreLabel = Label::createWithTTF("0", "fonts/DFPKanTingLiuW9.ttf", 20);
    hightScoreLabel->setPosition(Vec2(ORIGIN_VEC2.x + Numlabel1->getContentSize().width/2+5,
                                 ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height - 2*Numlabel1->getContentSize().height));
    this->addChild(hightScoreLabel);
    
    //得分
    auto Numlabel = Label::createWithTTF("当前得分", "fonts/DFPKanTingLiuW9.ttf", 12);
    
    Numlabel->setPosition(Vec2(ORIGIN_VEC2.x + Numlabel->getContentSize().width/2+5,
                            ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height - 3*Numlabel->getContentSize().height-5));
    this->addChild(Numlabel);
    
    scoreLabel = Label::createWithTTF("0", "fonts/DFPKanTingLiuW9.ttf", 20);
    scoreLabel->setPosition(Vec2(ORIGIN_VEC2.x + Numlabel->getContentSize().width/2+5,
                                 ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height - 4*Numlabel->getContentSize().height-5));
    this->addChild(scoreLabel);
    
    //测试得分增加
    this->schedule(schedule_selector(MainGame::checkOver));
    
    buildRoad();
    
    //障碍物
    redSprite = Sprite::create("red.png");
    redSprite->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+GetRandomValue(-20, 20), ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
    this->addChild(redSprite);
    redSprite->setVisible(false);
    
    blueSprite = Sprite::create("blue.png");
    blueSprite->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+GetRandomValue(-20, 20), ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
    this->addChild(blueSprite);
    blueSprite->setVisible(false);
    
    yellowSprite = Sprite::create("yellow.png");
    yellowSprite->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+GetRandomValue(-20, 20), ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
    this->addChild(yellowSprite);
    yellowSprite->setVisible(false);
    
    whiteSprite = Sprite::create("white.png");
    whiteSprite->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+GetRandomValue(-20, 20), ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
    this->addChild(whiteSprite);
    whiteSprite->setVisible(false);
    
//    purpleSprite = Sprite::create("purple.png");
//    purpleSprite->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+GetRandomValue(-20, 20), ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
//    this->addChild(purpleSprite);
//    purpleSprite->setVisible(false);
    
}

void MainGame::updateScore(float f)
{
    m_fScore++;
    std::stringstream oSS;
    oSS.str("");
    oSS<<m_fScore;
    scoreLabel->setString(oSS.str());
    m_hightScore = m_hightScore > m_fScore ? m_hightScore:m_fScore;
    std::stringstream oSS1;
    oSS1.str("");
    oSS1<<m_hightScore;
    hightScoreLabel->setString(oSS1.str());
}

void MainGame::buildRoad()
{
    roadSprite1 = Sprite::create("road.png");
    roadSprite1->setPosition(Vec2::ZERO);
    roadSprite1->setScaleY((ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height)/roadSprite1->getContentSize().height*5);
    gameLayer->addChild(roadSprite1);
    
    roadSprite2 = Sprite::create("road.png");
    roadSprite2->setPosition(Vec2(ORIGIN_VEC2.x,ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height));
    roadSprite2->setScaleY((ORIGIN_VEC2.y + VISIBLESIZE_SIZE.height)/roadSprite2->getContentSize().height*5);
    gameLayer->addChild(roadSprite2);
    
    //随机障碍物
    auto func =[&](){
        //道路滚动
        if (roadSprite1->getPositionY()<=-(ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height)) {
            roadSprite1->setPositionY(ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
        }
        else if (roadSprite2->getPositionY()<=-(ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height)){
            roadSprite2->setPositionY(ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
        }
        //障碍物
        if (!hasRun&&GetRandomValue(0, 10)<3) {
            runSpAction(redSprite);
        }
        else if (!hasRun&&GetRandomValue(0, 10)<5) {
            runSpAction(blueSprite);
        }
        else if (!hasRun&&GetRandomValue(0, 10)<7) {
            runSpAction(yellowSprite);
        }
        else if (!hasRun&&GetRandomValue(0, 10)<9) {
            runSpAction(whiteSprite);
        }
//        else if(!hasRun){
//            runSpAction(purpleSprite);
//        }
        
    };
    
    MoveBy *move1 = MoveBy::create(1, Vec2(0, -100));
    CallFunc *callFun = CallFunc::create(func);
    Sequence *seq1 = Sequence::create(move1,callFun, NULL);
    RepeatForever *repeat1 = RepeatForever::create(seq1);
    roadSprite1->runAction(repeat1);
    
    MoveBy *move2 = MoveBy::create(1, Vec2(0, -100));
    Sequence *seq2 = Sequence::create(move2,callFun, NULL);
    RepeatForever *repeat2 = RepeatForever::create(seq2);
    roadSprite2->runAction(repeat2);
}
int MainGame::GetRandomValue(int min, int max)
{
    int randValue;
    srand(unsigned(time(NULL)));  //产生随机数种子
    randValue = min + rand()%(max - min + 1) ;  //生成随机数
    return randValue;
}

void MainGame::runSpAction(Sprite *spri)
{
    hasRun = true;
    spri->setVisible(true);
    
    auto func3 =[=](){
        if (spri->getPositionY()<-10) {
            spri->stopAllActions();
            spri->setVisible(false);
            spri->setPosition(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+GetRandomValue(-20, 20), ORIGIN_VEC2.y+VISIBLESIZE_SIZE.height);
            hasRun = false;
        }
    };
    
    MoveBy *move3 = MoveBy::create(1, Vec2(0, -150));
    CallFunc *callFun3 = CallFunc::create(func3);
    Sequence *seq3 = Sequence::create(move3,callFun3, NULL);
    RepeatForever *repeat3 = RepeatForever::create(seq3);
    spri->runAction(repeat3);

}

void MainGame::updateRoad()
{
    
}

void MainGame::checkOver(float f)
{
    //是否碰到边界
    if (heroBall->getPositionX()<=ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2-25 || heroBall->getPositionX()>=ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2+25 ) {
        CCLOG("GAMEOVER");
        gameOver();
    }
    //是否碰到障碍物
    if (hasRun) {
        //判断是否碰到球
        Sprite *sp;
        bool isExist = false;
        if (redSprite->isVisible()) {
            sp = redSprite;
            isExist = true;
        }
        if (yellowSprite->isVisible()) {
            sp = yellowSprite;
            isExist = true;
        }
        if (whiteSprite->isVisible()) {
            sp = whiteSprite;
            isExist = true;
        }
        if (blueSprite->isVisible()) {
            sp = blueSprite;
            isExist = true;
        }
//        if (purpleSprite->isVisible()) {
//            sp = purpleSprite;
//            isExist = true;
//        }
        if (isExist) {
            if (std::abs(sp->getPositionY()-heroBall->getPositionY())<=10&&std::abs(sp->getPositionX()-heroBall->getPositionX())<=10) {
                gameOver();
            }
        }
        
    }
    updateScore(1);
    
}

void MainGame::gameOver()
{
    UserDefault::getInstance()->setIntegerForKey("hightScore", m_hightScore);
    UserDefault::getInstance()->flush();
    pauseLayer->removeAllChildren();
    pauseLayer->setVisible(true);
    auto pauseLabel = Label::createWithTTF("游戏结束", "fonts/DFPKanTingLiuW9.ttf", 24);
    
    pauseLabel->setPosition(Vec2(ORIGIN_VEC2.x + VISIBLESIZE_SIZE.width/2,
                                 ORIGIN_VEC2.y + pauseLabel->getContentSize().height));
    pauseLayer->addChild(pauseLabel);
    unscheduleAllCallbacks();
    scheduleOnce(schedule_selector(MainGame::restartGame), 2);
     
     
}
void MainGame::restartGame(float f)
{
    Scene *sc = HelloWorld::createScene();
    Director::getInstance()->replaceScene(sc);
}
void MainGame::menuLeftCallback(cocos2d::Ref* pSender)
{
    CCLOG("left");
    if (heroBall) {
        MoveBy *leftMove = MoveBy::create(0.1f, Vec2(-10, 0));
        heroBall->runAction(leftMove);
        checkOver(1);
    }
}

void MainGame::menuRightCallback(cocos2d::Ref* pSender)
{
    CCLOG("right");
    if (heroBall) {
        MoveBy *rightMove = MoveBy::create(0.1f, Vec2(10, 0));
        heroBall->runAction(rightMove);
        checkOver(1);
    }
    
}
void MainGame::menuPauseGame(cocos2d::Ref* pSender)
{
    CCLOG("pase");
    if (!Director::getInstance()->isPaused()) {
        Director::getInstance()->pause();
        Sprite *sp = Sprite::create("start.png");
        pauseItem->setNormalSpriteFrame(sp->getSpriteFrame());
        leftItem->setEnabled(false);
        rightItem->setEnabled(false);
        pauseLayer->setVisible(true);
    }
    else{
        Director::getInstance()->resume();
        Sprite *sp = Sprite::create("pause.png");
        pauseItem->setNormalSpriteFrame(sp->getSpriteFrame());
        leftItem->setEnabled(true);
        rightItem->setEnabled(true);
        pauseLayer->setVisible(false);
    }
    
}