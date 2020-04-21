//
//  Timer.h
//  Class
//
//  Created by Incubecn on 15/10/25.
//  Copyright © 2015年 lmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/time.h>

@interface HiperTimer : NSObject
{
    struct timeval tv;
    uint64_t mStart;
    uint64_t mEnd;
}


//开始
-(void)Start;

//停止，重置
-(void)Stop;

//获取离开始的时间间隔    毫秒
-(int)durationMillisecond;

//获取当前时间 返回 年月日
-(NSString *)getCurrentDay;

//获取当前时间 返回 年月日时分秒
-(NSString *)getCurrentTime;

//获取当前时间 返回 年月日时分秒 毫秒
-(NSString *)getCurrentTimePrecisionMS;


@end
