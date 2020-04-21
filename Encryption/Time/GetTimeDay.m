//
//  GetTime.m
//  TestFixture
//
//  Created by BEN on 14-3-12.
//  Copyright (c) 2014年 BEN. All rights reserved.
//

#import "GetTimeDay.h"

@implementation GetTimeDay

-(id)init
{
    if (self = [super init])
    {
//        calenderDate = [[NSCalendarDate alloc] init];
    }
    
    return self;
}

//-(double)getTimeInterval
//{
//    return [[NSDate date] timeIntervalSinceDate:calenderDate];
//}

+(NSString*)GetCurrentTime
{
    NSString* currentTime = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        currentTime = [formatter stringFromDate:date];
        //[formatter release];
        return currentTime;
    }
}

-(time_t)convertTimeStamp:(NSString *)stringTime
{
        
        time_t createdAt = 0;
        struct tm *created;
        time_t now;
        time(&now);
        
        created = localtime(&now);
        const char *strTime = [stringTime UTF8String];
        
        if(![stringTime isEqualToString:@""])
        {
            if (strptime(strTime, "%a %b %d %H:%M:%S %z %Y", created) == NULL)
            {
                strptime(strTime, "%Y/%m/%d/%R", created);
                
            }
            
            createdAt = mktime(created);
            
        }
        
        return createdAt;
}

+(NSString*)GetCurrentSecond
{
    NSString* currentTime = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        currentTime = [formatter stringFromDate:date];
        //[formatter release];
        return currentTime;
    }
}

+(BOOL) JudgeCurrentlyMoreThan24h:(NSString*)oldDateStr
{
    //...
    BOOL isJudge = NO;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *newDateStr = [GetTimeDay GetCurrentSecond];
    
    NSDate *oldDate = [formatter dateFromString:oldDateStr];
    NSDate *newDate = [formatter dateFromString:newDateStr];
    
    NSTimeInterval oldTime = [oldDate timeIntervalSince1970];
    NSTimeInterval newTime = [newDate timeIntervalSince1970];
    
    double dc = newTime - oldTime;
    double h24 = 24 * 60 * 60;
    
    if(dc <0)
    {
        isJudge = YES;
    }
    else if (dc > h24)
    {
        isJudge = YES;
    }
    else
    {
        isJudge = NO;
    }
    
    return isJudge;
}

+(NSString*)GetcurrentTemp
{
    NSString* currentTime = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH"];
        currentTime = [formatter stringFromDate:date];
        //[formatter release];
        return currentTime;
    }
}
    
+(NSString*)GetFileTime
{
    NSString* currentTime = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH_mm_ss"];
        currentTime = [formatter stringFromDate:date];
        //[formatter release];
        return currentTime;
    }
}

+(NSString*)GetCurrentDay
{
    NSString* currentDay = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        currentDay = [formatter stringFromDate:date];
        //[formatter release];
        return currentDay;
    }
}

+(NSString*)GetCurrentCutDay
{
    NSString* currentDay = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        currentDay = [formatter stringFromDate:date];
        //[formatter release];
        return currentDay;
    }
}

+(NSString*)GetWriteCurrentDate
{
    NSString* currentDay = @"";
    @synchronized (self)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        currentDay = [formatter stringFromDate:date];
        //[formatter release];
        return currentDay;
    }
}

+(NSString *) judgeNextAuditTimeString:(NSString*)oldDateStr
{
    NSString *nextAuditTimeStr = [[NSString alloc]init];
    int timeIntervalDifferenc = 0;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormatter dateFromString:oldDateStr];
    NSDate *newDate = [ dateFormatter dateFromString:[GetTimeDay GetCurrentSecond]];
    
    NSTimeInterval oldTimeInterval = [oldDate timeIntervalSince1970];
    NSTimeInterval newTimeInterval = [newDate timeIntervalSince1970];
    
    
    if ((oldTimeInterval - newTimeInterval) >0 )
    {
        timeIntervalDifferenc = 0;
    }else
    {
        timeIntervalDifferenc = newTimeInterval - oldTimeInterval;
        if (timeIntervalDifferenc > 24*60*60)
        {
            timeIntervalDifferenc = 0;
        }else
        {
            timeIntervalDifferenc = 24*60*60 - timeIntervalDifferenc;
        }
    }
    
    int hourDifference = timeIntervalDifferenc / 60 / 60;
    int minuteeDifference = timeIntervalDifferenc % 3600 / 60;
    int secondDifference  = timeIntervalDifferenc % 60;
    
    nextAuditTimeStr = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hourDifference,minuteeDifference,secondDifference];
    return  nextAuditTimeStr;
}



+(int) judgeNextAuditTime:(NSString*)oldDateStr
{
    int timeIntervalDifferenc = 0;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormatter dateFromString:oldDateStr];
    NSDate *newDate = [ dateFormatter dateFromString:[GetTimeDay GetCurrentSecond]];
    
    NSTimeInterval oldTimeInterval = [oldDate timeIntervalSince1970];
    NSTimeInterval newTimeInterval = [newDate timeIntervalSince1970];
    
    
    if ((oldTimeInterval - newTimeInterval) >0 )
    {
        timeIntervalDifferenc = 0;
    }else
    {
        timeIntervalDifferenc = newTimeInterval - oldTimeInterval;
        if (timeIntervalDifferenc > 24*60*60)
        {
            timeIntervalDifferenc = 0;
        }else
        {
            timeIntervalDifferenc = 24*60*60 - timeIntervalDifferenc;
        }
    }
    
    return timeIntervalDifferenc;
}


+(NSString *)ChangeSecondToOtherTime:(double)oldSecond{
    
    NSString *needTime;
    int Second=oldSecond;
    int newHour;
    int newMinute;
    int newSecond;
    @synchronized (self)
    {
        if (Second>0) {
            newHour=oldSecond/60/60;
            newMinute=Second % 3600/60;
            newSecond=Second % 60;
        }else{
            newHour=0;
            newMinute=0;
            newSecond=0;
        }
    }
    needTime=[NSString stringWithFormat:@"%d:%d:%d",newHour,newMinute,newSecond];
    return needTime;
}



@end
