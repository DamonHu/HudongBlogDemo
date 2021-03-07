# Plugin-x-
Plugin-x自己增加新的接口
##Plugin-x自己增加新的接口

就如前面这个文章说的，cocos2d-x 默认给 Plugin-x 四个协议接口，ProtocolAds, ProtocolAnalytics, ProtocolIAP, ProtocolSocial，他们默认提供给你的有比如说支付接口等等，但是如果想要增加新的接口，比如说 login登陆，logout退出这些接口就需要自己写了。

当然，要么你直接修改文件，比如说直接修改ProtocolSocial这个接口，但是一般都不提倡你直接修改，所以这里就说一下复制一份之后，改造成想要的就行了。

文章《[Plugin-x自己增加新的接口（图文教程）](http://www.hudongdong.com/cocos2d/171.html)》
