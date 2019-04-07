//
//  SLPUtils+Path.m
//  Sleepace
//
//  Created by mac on 5/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils+Path.h"

@implementation SLPUtils (Path)

+ (NSString *)localRootPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];

    return documentPath;
}

+ (NSString *)localDataPath{
    NSString *documentPath = [self localRootPath];
    NSString *localDataPath = [documentPath stringByAppendingPathComponent:@"Data"];
    return localDataPath;
}

#pragma mark Music
+ (NSString *)musicRootPath{
    return [NSString stringWithFormat:@"%@/music",[self localRootPath]];
}

@end
