# IosThread
Ios多线程Demo

多线程可以在充分发挥机器的性能，并行执行任务，可以根据自己的需要来创建同步线程还是异步线程，是否需要阻塞总线程等功能来达到提高效率的问题。当然线程数也不是越多越好，过多的线程数会消耗过多的CPU和内存资源，有可能会造成主线程的卡顿，影响体验，一般开四个同时运行的线程即可。

IOS一般使用这四种方式来多线程操作

performSelector

NSOperation

NSThread

GCD

该demo就是显示这四种方式来实现多线程的方法

原文《[IOS多线程使用](http://www.hudongdong.com/ios/349.html)》
