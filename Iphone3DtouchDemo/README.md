# Iphone3DtouchDemo
ios 3dtouch功能Demo

3DTouch是在6s之后苹果的一项技术，通过屏幕的压力来弹出快捷窗，从而更便捷的操作。以前我不怎么用，但是自从发现支付宝直接弹窗支付扫码之后，发现这个功能也是很不错的，下面开始开发，注意，这个功能只能在6s和6s之上的手机上面真机运行，Xcode的模拟器是不支持的。

**3DTouch的改进包括三个方面**

* Quick Actions（点击icon的快捷方式）

* Peek&Pop（应用内快速预览内容）

* UITouch（增加了压力和最大压力）

这个代码就是这三个的示例demo，可以直接使用该demo代码参考，也可以查看该demo的说明文章《[IOS开发之3DTouch功能的开发详解](http://www.hudongdong.com/ios/380.html)》

**Quick Actions**

Quick Actions就是不同力度点击桌面icon时弹出的快捷方式

![image](http://cdn.hudongdong.com/content/uploadfile/201610/fa011477578368.jpg)

**Peek&Pop**

Peek&Pop是在应用中，点击相应的视图来预览图片和弹出相应选项

![image](http://cdn.hudongdong.com/content/uploadfile/201610/b3f81477578369.jpg)

**UITouch**

在UITouch中，新添加了力度force和maximumPossibleForce这两个属性，就是检测按压的力度

![image](http://cdn.hudongdong.com/content/uploadfile/201610/152e1477578370.jpg)
