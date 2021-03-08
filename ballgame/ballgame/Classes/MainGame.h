//
//  MainGame.hpp
//  ballgame
//
//  Created by Damon on 16/5/7.
//
//

#ifndef MainGame_hpp
#define MainGame_hpp

#include <stdio.h>
#include "cocos2d.h"
USING_NS_CC;
class MainGame: public cocos2d::Layer
{
public:
    static cocos2d::Scene* createScene();
    
    virtual bool init();
    
    // a selector callback
    void menuLeftCallback(cocos2d::Ref* pSender);
    void menuRightCallback(cocos2d::Ref* pSender);
    
    void menuPauseGame(cocos2d::Ref* pSender);
    void initLayerItem();
    
    Layer *gameLayer;   //游戏层
    
    Sprite *heroBall;   //主角的球
    MenuItemImage *pauseItem;
    
    MenuItemImage *leftItem;//左按钮
    MenuItemImage *rightItem;//右按钮
    LayerColor *pauseLayer;
    
    Sprite *roadSprite1;
    Sprite *roadSprite2;
    Label *scoreLabel;//得分
    Label *hightScoreLabel;//最高得分
    
    Sprite *redSprite;//红   横
    Sprite *blueSprite;//蓝  竖
    Sprite *yellowSprite;//黄   圆
    Sprite *whiteSprite;//白 V
    Sprite *purpleSprite;//紫    画圈消除
    
    void updateScore(float f);//更新得分
    CREATE_FUNC(MainGame);
    
public:
    void buildRoad();//动态创建道路
    void updateRoad();
    
    int GetRandomValue(int min, int max);//生成随机数
    
    void checkOver(float f);//检测游戏结束
    
    void gameOver();
    void restartGame(float f);//重新玩
    
    void runSpAction(Sprite *spri);
    void cleanDike();//消除障碍物
private:
    float m_fScore; //得分
    float m_hightScore;//最高得分
    bool hasRun;//已经有跑的障碍物了

    //手势方向
    enum GDirection
    {
        kGDirectionUp = 0,
        kGDirectionDown,
        kGDirectionLeft,
        kGDirectionRight,
        kGDirectionNo,
        kGDirectionCircle,
        kGDirectionV
    };
    
    bool b_click;                   //判断当前是否是单击;
    bool b_debug;                   //调试用;
    bool b_circle;                  //圆;
    bool b_V;                       //V
    bool cache_directionshape[4];   //方向缓存，move中用它来判断是否是单向手势
    GDirection gd_direction;        //手势方向;
    Point ccp_last,ccp_now;       //记录起始、当前坐标
    
    
};
#endif /* MainGame_hpp */
