//
//  SLPTime12.m
//  Sleepace
//
//  Created by mac on 4/7/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPTime12.h"
#import "SLPTime24.h"

@implementation SLPTime12

- (SLPTime24 *)convertToTime24{
    SLPTime24 *time24 = [[SLPTime24 alloc] init];
    time24.second = self.second;
    time24.minute = self.minute;
    NSInteger hour = self.hour;
    BOOL isAM = self.isAM;
    if (isAM){
        if (hour == 12){
            hour = 0;
        }else{
            hour = self.hour;
        }
    }else{
        hour = hour%12 + 12;
    }
    time24.hour = hour;
    
    return time24;
}

- (NSString *)timeStringWithFormat:(SLP_Time_String_Format)format{
    NSString *timeString = [NSString stringWithFormat:@"%02d:%02d",(int)self.hour,(int)self.minute];
    if (format == SLP_Time_String_Format_HMS){
        timeString = [NSString stringWithFormat:@"%@:%02d",timeString,(int)self.second];
    }
    
    NSString *ampm = self.isAM?@"AM":@"PM";
    timeString = [NSString stringWithFormat:@"%@ %@",timeString,ampm];
    return timeString;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%d:%d:%d %@",(int)self.hour,(int)self.minute,(int)self.second,self.isAM?@"AM":@"PM"];
}
@end
