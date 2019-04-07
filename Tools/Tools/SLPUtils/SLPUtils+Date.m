//
//  SLPUtils+Date.m
//  Sleepace
//
//  Created by mac on 9/12/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils+Date.h"
#import "SLPTime24.h"
#import "SLPTime12.h"

static NSString *const kDateFormat = @"yyyy-MM-dd HH:mm:ss";
static NSString *const kSourceTimeZone = @"Asia/Beijin";

@implementation SLPUtils (Date)

+ (BOOL)isTimeMode24{
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL isMode24 = (containsA.location == NSNotFound);
    return isMode24;
}

+ (NSString *)timeStringFrom:(NSInteger)hour minute:(NSInteger)minute isTimeMode24:(NSInteger)isTime24{
    SLPTime24 *time24 = [[SLPTime24 alloc] init];
    time24.hour = hour;
    time24.minute = minute;
    if (isTime24){
        return [time24 timeStringWithFormat:SLP_Time_String_Format_HM];
    }else{
        SLPTime12 *time12 = [time24 convertToTime12];
        return [time12 timeStringWithFormat:SLP_Time_String_Format_HM];
    }
}

+ (NSString *)sleepStartTimeFrom:(NSInteger)startTime;
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:startTime];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents   *comps1;
    
    //当前的时分秒获得
    comps1 =[calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond)
                        fromDate:currentDate];
    NSInteger hour = [comps1 hour];
    
    if (hour >= 0  && hour < 6 )
    {
        [comps1 setHour:-24];
        [comps1 setMinute:0];
        [comps1 setSecond:0];
        
        currentDate = [calendar dateByAddingComponents:comps1 toDate:currentDate options:0];
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    
    NSString *s = [df stringFromDate:currentDate];
    return s;
}

+ (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

+ (NSString *)getEnMonthAndDayWithChDate:(NSString *)chDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd"];
    NSDate *date = [dateFormatter dateFromString:chDate];
    [dateFormatter setDateFormat:@"MMM dd"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getEnMonthAndYearWithChDate:(NSString *)chDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    NSDate *date = [dateFormatter dateFromString:chDate];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getEnDateWithChDate:(NSString *)chDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormatter dateFromString:chDate];
    [dateFormatter setDateFormat:@"MMM dd,yyyy"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getCurrentDateString {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:kDateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getDateStringFromTimeStamp:(NSString *)timeStamp {
    NSDate *updateDate = [NSDate dateWithTimeIntervalSince1970:timeStamp.integerValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kDateFormat];
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithName:kSourceTimeZone];
    [dateFormatter setTimeZone:sourceTimeZone];
    return [dateFormatter stringFromDate:updateDate];
}

+ (NSCalendarUnit)calendarUnitAll{
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|kCFCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond|kCFCalendarUnitWeekday;
    return unit;
}

+ (NSDateComponents *)dateCompsFromDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:[self calendarUnitAll] fromDate:date];
    return cmps;
}

+ (int32_t)getTimeStampFromDateStr:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kDateFormat];
    NSDate *updateDate = [dateFormatter dateFromString:dateStr];
    return [updateDate timeIntervalSince1970];
}

+ (NSInteger)daysOfDateSinceToday:(NSDate *)date{
    NSDate *today = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:today];
    
    NSInteger secondsPerDay = 3600 * 24;
    NSInteger days = timeInterval/secondsPerDay;
    return days;
}

+ (BOOL)isDateToday:(NSDate *)date{
    NSInteger days = [self daysOfDateSinceToday:date];
    BOOL ret = (days == 0);
    return ret;
}
    
+ (BOOL)isDateYesterday:(NSDate *)date{
    NSInteger days = [self daysOfDateSinceToday:date];
    BOOL ret = (days == -1);
    return ret;
}

+ (NSString *)monthStringFrom:(NSInteger)iMonth mode:(SLPMonthSpellModes)mode{
    NSString *string = @"";
    switch (iMonth) {
        case 1:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"January";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Jan";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Ja";
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"February";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Feb";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Fe";
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"March";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Mar";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Ma";
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"April";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Apr";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Ap";
                    break;
                default:
                    break;
            }
        }
            break;
        case 5:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"May";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"May";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Ma";
                    break;
                default:
                    break;
            }
        }
            break;
        case 6:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"June";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Jun";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Ju";
                    break;
                default:
                    break;
            }
        }
            break;
        case 7:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"July";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Jul";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Jl";
                    break;
                default:
                    break;
            }
        }
            break;
        case 8:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"August";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Aug";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Au";
                    break;
                default:
                    break;
            }
        }
            break;
        case 9:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"September";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Sep";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Se";
                    break;
                default:
                    break;
            }
        }
            break;
        case 10:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"October";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Oct";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"Oc";
                    break;
                default:
                    break;
            }
        }
            break;
        case 11:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"November";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Nov";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"No";
                    break;
                default:
                    break;
            }
        }
            break;
        case 12:
        {
            switch (mode) {
                case SLPMonthSpellModes_Completely:
                    string = @"December";
                    break;
                case SLPMonthSpellModes_Abbr:
                    string = @"Dec";
                    break;
                case SLPMonthSpellModes_Abbr1:
                    string = @"De";
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return string;
}
@end
