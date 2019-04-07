//
//  SLPTime12.h
//  Sleepace
//
//  Created by mac on 4/7/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLPTime.h"
//12小时制
@class SLPTime24;
@interface SLPTime12 : NSObject
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;
@property (nonatomic,assign) NSInteger second;
@property (nonatomic,assign) BOOL isAM;

- (SLPTime24 *)convertToTime24;
- (NSString *)timeStringWithFormat:(SLP_Time_String_Format)format;
@end
