//
//  TimeCount.h
//  MeiShiZhaoShi
//
//  Created by ZhangLiang on 15/3/18.
//  Copyright (c) 2015年 MeiShiZhaoShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeCount : NSObject

/*! @brief 输出年月日
 *
 */
+ (NSString *)timeFormatted:(NSString *)totalSeconds;

// 输出字符串年月日
+ (NSString *)dateStringWithDate:(NSDate *)date;

/**
 *  输出HH:mm时分
 *
 *  @param totalSeconds 字符串秒
 *
 *  @return 时间字符串
 */
+ (NSString *)printfHourMinutes:(NSString *)totalSeconds;

/*! @brief 算星期几
 *
 */


+ (NSString *)getWeekWithDate:(long)totalSeconds;

/*! @brief 获取小时
 *
 */
+ (NSString *)timeReturnHour:(NSString *)totalSeconds;

+ (NSString *)printfYearMonthDayWith:(NSDate *)date;

/**
 *  计算一个时间距离现在的时间差距
 *
 *  @param theDate
 *
 *  @return
 */
+ (NSString *)intervalSinceNow: (NSString *) theDate;

/**
 * 计算两个时间差
 * @param startTime 开始时间时间戳
 * @param stopTime 结束时间时间戳
 * @return 天数
 */
+ (NSString *)timeChaWithStartTime:(NSString *)startTime stopTime:(NSString *)stopTime;
+ (NSString *)mdTimeFormatted:(NSString *)totalSeconds;
+ (NSString *)ymTimeFormatted:(NSString *)totalSeconds;
/**
 *  输出年月日时分
 */
+ (NSString *)alltimeFormatted:(NSString *)totalSeconds;

/**
 * 输出月日时分
 */
+ (NSString *)alltimeFormatted2:(NSString *)totalSeconds;
+ (NSString *)alltime3Formatted:(NSString *)totalSeconds;
// 输出年月日，用点隔开
+ (NSString *)DateFormattedForYearMonthDaySeparaWithSpot:(NSString *)totalSeconds;

// 根据NSDate输出日期用点分割
+ (NSString *)dateStringWithDateSeparaSpot:(NSDate *)date;

// 输出诸如2015.12.13（3：45）
+ (NSString *)alltimeFormatted3:(NSString *)totalSeconds;


@end
