//
//  Timer.m
//  Class
//
//  Created by Incubecn on 15/10/25.
//  Copyright © 2015年 lmc. All rights reserved.
//

#import "HiperTimer.h"

@implementation HiperTimer

-(id)init
{
    self = [super init];
    
    return self;
}


//开始
-(void)Start
{
    if (0 == gettimeofday(&tv, NULL)) {
        mStart = tv.tv_sec *1000 + tv.tv_usec / 1000;
    }
}


//停止，重置
-(void)Stop
{
    mStart = mEnd;
}

//获取离开始的时间间隔    毫秒
-(int)durationMillisecond
{
    if(0 == gettimeofday(&tv, NULL))
    {
        mEnd = tv.tv_sec *1000 + tv.tv_usec / 1000;
    }
    
    return (int)(mEnd - mStart);
}


//获取当前时间 返回 年月日
-(NSString *)getCurrentDay
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd";
    return [fm stringFromDate:[NSDate date]];
}


//获取当前时间 返回 年月日时分秒
-(NSString *)getCurrentTime
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [fm stringFromDate:[NSDate date]];
}

//获取当前时间 返回 年月日时分秒 毫秒
-(NSString *)getCurrentTimePrecisionMS
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
    return [fm stringFromDate:[NSDate date]];
}

@end
