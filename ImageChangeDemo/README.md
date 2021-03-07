# ImageChangeDemo
UIImage修改颜色的demo
**demo的参考文章《[IOS开发之使用代码控制UIImage的颜色
](http://www.hudongdong.com/ios/447.html)》**

碰到一个需要解决的问题就是可能需要同样的图标，同样的素材，但是需要按照用户喜爱变为不同的颜色，从而搭配不同的模板造型。如果有个红色的图片，又想要蓝色的图片，如果让美工仅仅是调色，估计三套之后就会被打的，并且也会占用资源。

所以就找找看有没有用代码控制，同一套图片弄成不同的颜色就行了，找到了很多前人的方法，我就跟着乘凉了

思路就是UIGraphicsBeginImageContext根据图片设置的颜色重新绘制生成新的图片。

原图如下

![](http://cdn.hudongdong.com/usr/uploads/2017/02/924630644.png)

效果图

![](http://cdn.hudongdong.com/usr/uploads/2017/02/732926539.png)
