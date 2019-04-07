//
//  SLPUtils+Path.h
//  Sleepace
//
//  Created by mac on 5/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils.h"

typedef NS_ENUM(NSInteger,SLPMusicPurpose) {
    SLPMusicPurpose_Assist = 0,//助眠
    SLPMusicPurpose_Alarm,//闹铃
};

@interface SLPUtils (Path)

+ (NSString *)localRootPath;
+ (NSString *)localDataPath;
#pragma mark Music
+ (NSString *)musicRootPath;

@end
