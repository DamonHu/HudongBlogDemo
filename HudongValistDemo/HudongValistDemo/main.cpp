//
//  main.cpp
//  HudongValistDemo
//
//  Created by admin on 15/5/18.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#include <iostream>
using namespace std;
void funcs(int s,...)
{
    va_list va;//定义一个 va_list
    va_start(va, s);//第一个参数是列表，第二个参数是参数
    while (s) {
        printf("%d",s);
        s = va_arg(va, int);//读取下一个
    }
    va_end(va);//结束
}
int main(int argc, const char * argv[]) {
    funcs(1,2,3,4,5,6,7);
    return 0;
}
