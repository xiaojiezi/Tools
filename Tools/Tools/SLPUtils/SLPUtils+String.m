//
//  SLPUtils+String.m
//  Sleepace
//
//  Created by mac on 5/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils+String.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation SLPUtils (String)

+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)width{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font{
    CGSize textSize = {CGFLOAT_MAX, CGFLOAT_MAX };
    CGRect rect = [string boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    return rect.size;
}

+ (NSString *)addPathComponent:(NSString *)patchComponent toRoot:(NSString *)root{
    if (patchComponent.length == 0){
        return root;
    }
    
    if (root.length == 0){
        return patchComponent;
    }
    
    NSString *protocalString = nil;
    NSString *rootPath = nil;
    
    NSString *http = @"http://";
    NSString *https = @"https://";
    if ([root hasPrefix:http]){
        protocalString = http;
    }
    
    if ([root hasPrefix:https]){
        protocalString = https;
    }
    
    if (!protocalString){
        return [root stringByAppendingPathComponent:patchComponent];
    }
    
    NSInteger rootLength = root.length;
    if (rootLength == protocalString.length){
        return root;
    }
    
    rootPath = [root substringFromIndex:protocalString.length];
    
    return [NSString stringWithFormat:@"%@%@",protocalString,[rootPath stringByAppendingPathComponent:patchComponent]];
}

+ (BOOL)checkEnterString:(NSString *)enterString isNotLimitString:(NSString *)limitString
{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitString] invertedSet];
    NSString*filtered = [[enterString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [enterString isEqualToString:filtered];
    if(!basicTest) {
        return NO;
        
    }
    else
    {
        return  YES;
    }
}

+ (BOOL)isCharacterNumber:(unichar)ch{
    BOOL ret = (ch >= '0' && ch <= '9');
    return ret;
}

+ (BOOL)isCharacterLetter:(unichar)ch{
    BOOL ret = (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z');
    return ret;
}

+ (BOOL)isCharacterNumberOrLetter:(unichar)ch{
    BOOL ret = ([self isCharacterNumber:ch] || [self isCharacterLetter:ch]);
    return ret;
}

+ (NSString *)convertJasonDictionaryToString:(NSDictionary *)jasonDic{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jasonDic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSString *nullString = @"\\u0000";
    jsonString = [jsonString stringByReplacingOccurrencesOfString:nullString withString:@""];
    return jsonString;
}

+ (NSURL *)urlFromFilePath:(NSString *)path{
    if (path.length == 0){
        return nil;
    }
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    return url;
    
}


+ (NSString *)md5:(NSString *)string{
    if (string.length == 0){
        return string;
    }
    
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
@end
