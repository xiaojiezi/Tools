//
//  UIView+Swizzling.m
//  Sleepace
//
//  Created by mac on 3/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "UIView+Swizzling.h"
#import <objc/runtime.h>

@implementation UIView (Swizzling)

+ (void)load{
    SEL origSel = @selector(initWithCoder:);
    SEL swizSel = @selector(swiz_initWithCoder:);
    [[self class] swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];
    
    origSel = @selector(init);
    swizSel = @selector(swiz_init);
    [[self class] swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];
    
    origSel = @selector(initWithFrame:);
    swizSel = @selector(swiz_initWithFrame:);
    [[self class] swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];
}

+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel
{
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

- (id)swiz_initWithCoder:(NSCoder *)aDecoder{
    id ret = [self swiz_initWithCoder:aDecoder];
    [self setBackgroundColor:[UIColor clearColor]];
    return ret;
}

- (id)swiz_init{
    id ret = [self swiz_init];
    [self setBackgroundColor:[UIColor clearColor]];
    return ret;
}

- (id)swiz_initWithFrame:(CGRect)frame{
    id ret = [self swiz_initWithFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    return ret;
}
@end
