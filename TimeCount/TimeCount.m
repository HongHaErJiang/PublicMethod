//
//  TimeCount.m
//  MeiShiZhaoShi
//
//  Created by ZhangLiang on 15/3/18.
//  Copyright (c) 2015年 MeiShiZhaoShi. All rights reserved.
//

#import "TimeCount.h"

@implementation TimeCount

// 根据NSDate实例返回字符串
+ (NSString *)dateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}


#pragma mark - 传入Date日期输出用.分割开来的年月日
+ (NSString *)dateStringWithDateSeparaSpot:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}


#pragma mark - 传入时间戳，输出时分
+ (NSString *)timeReturnHour:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)alltimeFormatted:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+ (NSString *)alltime3Formatted:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd   HH:mm"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


#pragma mark - 传入时间戳日期输出用.分割开来的年月日
+ (NSString *)DateFormattedForYearMonthDaySeparaWithSpot:(NSString *)totalSeconds
{
    double time = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}



+ (NSString *)alltimeFormatted2:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd(HH:mm)"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)alltimeFormatted3:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd(HH:mm)"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

// 输出月日
+ (NSString *)mdTimeFormatted:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM/dd"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+ (NSString *)ymTimeFormatted:(NSString *)totalSeconds {
    
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

// 输出年月日
+ (NSString *)timeFormatted:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)printfHourMinutes:(NSString *)totalSeconds
{
    double time                    = [totalSeconds doubleValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *confromTimesp          = [NSDate dateWithTimeIntervalSince1970:time / 1000 ];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

// 输出年月日
+ (NSString *)printfYearMonthDayWith:(NSDate *)date
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *confromTimespStr     = [dateFormatter stringFromDate:date];
    return confromTimespStr;
}

/**
 *  计算星期几
 *
 *  @param totalSeconds 时间总秒数
 *
 *  @return 星期几字符串
 */
+ (NSString *)getWeekWithDate:(long)totalSeconds
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:totalSeconds / 1000 ];    // NSDate转换
    NSCalendar *calendar  = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]; // 初始化日历
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents * comps = [calendar components:unitFlags fromDate:confromTimesp]; // 传入NSDate
    NSArray *weekArr  = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *week = weekArr[[comps weekday] - 1];
    return week;
}

#pragma mark - 计算两个时间之间的时间差是否大于一天
+ (NSString *)timeChaWithStartTime:(NSString *)startTime stopTime:(NSString *)stopTime{
    
    
    double startTimeDouble = [startTime doubleValue];
    NSDate *startDate          = [NSDate dateWithTimeIntervalSince1970:startTimeDouble / 1000 ];
    NSTimeInterval startTimeIntreval =[startDate timeIntervalSince1970]*1;   // 开始时间秒
    
    double stopTimeDouble = [stopTime doubleValue];
    NSDate *stopDate          = [NSDate dateWithTimeIntervalSince1970:stopTimeDouble / 1000 ];
    NSTimeInterval stopTimeIntreval =[stopDate timeIntervalSince1970]*1;   // 结束时间秒
    
    NSTimeInterval cha = stopTimeIntreval - startTimeIntreval;
    
    NSString *timeString;
    if (cha/86400>1)
    {
        timeString                     = [NSString stringWithFormat:@"%f", cha/86400];
        timeString                     = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@天", timeString];
        return timeString;
    }else{
        return @"1";
    }

}


#pragma mark 计算一个时间距现在的时间差
/**
 *  计算一个时间距离现在的时间差
 *
 *  @param theDate 传入的时间戳
 *
 *  @return 时间差字符串
 */
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;

    NSDate* dat                    = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";

    NSTimeInterval cha             = late-now;

    if (cha/3600<1) {
    timeString                     = [NSString stringWithFormat:@"%f", cha/60];
    timeString                     = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"剩余%@分", timeString];

    }
    if (cha/3600>1&&cha/86400<1) {
    timeString                     = [NSString stringWithFormat:@"%f", cha/3600];
    timeString                     = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"剩余%@小时", timeString];
    }
    if (cha/86400>1)
    {
    timeString                     = [NSString stringWithFormat:@"%f", cha/86400];
    timeString                     = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"剩余%@天", timeString];
    }
    return timeString;
}

@end
