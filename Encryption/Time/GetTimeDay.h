//
//  GetTimeDay.h
//  TestFixture
//
//  Created by BEN on 14-3-12.
//  Copyright (c) 2014年 BEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTimeDay : NSObject
{
//    NSCalendarDate *calenderDate;
}

+(NSString*)GetCurrentDay;  //get current date ,time format:yyyy-MM-dd

+(NSString*)GetCurrentTime; //get current time ,time format:yyyy-MM-dd HH:mm:ss

+(NSString*)GetFileTime;    //get current time ,time format:yyyy-MM-dd HH_mm_ss

+(NSString*)GetCurrentCutDay;

+(NSString*)GetWriteCurrentDate;

+(NSString*)GetCurrentSecond;

+(BOOL) JudgeCurrentlyMoreThan24h:(NSString*)oldDate;
+(NSString *) judgeNextAuditTimeString:(NSString*)oldDateStr;

+(int) judgeNextAuditTime:(NSString*)oldDateStr;

+(NSString *)ChangeSecondToOtherTime:(double)oldSecond;

//-(double)getTimeInterval;


@end
