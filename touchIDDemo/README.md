# touchIDDemo
IOS开发TouchID指纹解锁的demo

在游戏开发中，因为有帐号密码，并且再加上QQ登录这些功能之后，就不怎么用的到TouchID这个指纹解锁功能，但是如果是单机App应用的话，倒是可以加上这个功能，来为本地加个锁。

![image](http://cdn.hudongdong.com/content/uploadfile/201610/a4201477905426.png)

指纹解锁开发很简单，只用两步，引用头文件，接收返回结果

一、引入库和头文件

在项目中引入LocalAuthentication.framework这个系统库，然后在需要用的地方导入头文件

```
#import <LocalAuthentication/LocalAuthentication.h>
```

二、加入TouchID功能

TouchID只用这两个函数

```
//判断是否支持TouchID功能
- (BOOL)canEvaluatePolicy:(LAPolicy)policy error:(NSError * __autoreleasing *)error __attribute__((swift_error(none)));
//指纹解锁
- (void)evaluatePolicy:(LAPolicy)policy  localizedReason:(NSString *)localizedReason  reply:(void(^)(BOOL success, NSError * __nullable error))reply;
```

使用的时候首先判断手机是否支持touchID功能，如果支持，就开始指纹解锁，然后在指纹解锁的代码块中，实现解锁成功和解锁失败的逻辑。需要真机调试，模拟器不支持

**该Demo就是演示如何使用TouchID，原文地址《[IOS开发之TouchID指纹解锁的使用](http://www.hudongdong.com/ios/381.html)》**
