//
//  SLPUtils+String.h
//  Sleepace
//
//  Created by mac on 5/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils.h"

@interface SLPUtils (String)
+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)width;
+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font;
+ (NSString *)addPathComponent:(NSString *)patchComponent toRoot:(NSString *)root;
+ (BOOL)checkEnterString:(NSString *)enterString isNotLimitString:(NSString *)limitString;

//是否为字母或数字
+ (BOOL)isCharacterNumberOrLetter:(unichar)character;

+ (NSString *)convertJasonDictionaryToString:(NSDictionary *)jasonDic;

+ (NSURL *)urlFromFilePath:(NSString *)path;

+ (NSString *)base64:(NSString *)string;
+ (NSString *)md5:(NSString *)string;
@end
