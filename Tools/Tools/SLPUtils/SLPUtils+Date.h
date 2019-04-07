//
//  SLPUtils+Date.h
//  Sleepace
//
//  Created by mac on 9/12/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils.h"

typedef NS_ENUM(NSInteger,SLPMonthSpellModes) {
    SLPMonthSpellModes_Completely,//全拼
    SLPMonthSpellModes_Abbr,//缩写
    SLPMonthSpellModes_Abbr1,//最短的缩写
};

@interface SLPUtils (Date)
//当前是否时候为24小时制
+ (BOOL)isTimeMode24;
//将24进制时间转化为字符串
+ (NSString *)timeStringFrom:(NSInteger)hour minute:(NSInteger)minute isTimeMode24:(NSInteger)isTime24;
//获取开始睡眠时间
+ (NSString *)sleepStartTimeFrom:(NSInteger)startTime;
///时间转换
+ (NSString *)timeFormatted:(int)totalSeconds;

// 将 MM/dd 格式的中文日期转换为 MMM dd格式的英文日期
+ (NSString *)getEnMonthAndDayWithChDate:(NSString *)chDate;
// 将 yyyy/MM 格式的中文日期转换为 MMM yyyy格式的英文日期
+ (NSString *)getEnMonthAndYearWithChDate:(NSString *)chDate;
// 将 yyyy/MM/dd 格式的中文日期转换为 MMM dd,yyyy格式的英文日期
+ (NSString *)getEnDateWithChDate:(NSString *)chDate;

//获取当前时间的字符串 yyyy-MM-dd HH:mm:ss
+ (NSString *)getCurrentDateString;

+ (NSString *)getDateStringFromTimeStamp:(NSString *)timeStamp;

+ (int32_t)getTimeStampFromDateStr:(NSString *)dateStr;

+ (NSDateComponents *)dateCompsFromDate:(NSDate *)date;
//今天之后几天 返回负数则是前几天
+ (NSInteger)daysOfDateSinceToday:(NSDate *)date;
+ (BOOL)isDateToday:(NSDate *)date;
+ (BOOL)isDateYesterday:(NSDate *)date;
+ (NSString *)monthStringFrom:(NSInteger)iMonth mode:(SLPMonthSpellModes)mode;
@end
