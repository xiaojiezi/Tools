//
//  UITextField+ClearMode.m
//  Sleepace
//
//  Created by mac on 4/11/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "UITextField+ClearMode.h"
#import <objc/runtime.h>

@implementation UITextField (ClearMode)
+ (void)load{
    SEL origSel = @selector(clearButtonRectForBounds:);
    SEL swizSel = @selector(swiz_clearButtonRectForBounds:);
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

- (void)customTextFiledCursorColor{
    [self setTintColor:[UIColor grayColor]];
}

- (CGRect)swiz_clearButtonRectForBounds:(CGRect)bounds{
    CGRect rect = [self swiz_clearButtonRectForBounds:bounds];
    
    [self customTextFiledCursorColor];
    [self customClearButtonMode];
    return rect;
}

- (void)customClearButtonMode{
    [self performSelectorOnMainThread:@selector(_customClearButtonMode) withObject:nil waitUntilDone:NO];
}

- (void)_customClearButtonMode{
    NSArray *subViews = self.subviews;
    for (UIView *aSubView in subViews){
        if ([aSubView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)aSubView;
            [button setImage:[UIImage imageNamed:@"device_btn_delete_text.png"] forState:UIControlStateNormal];
        }
    }
}
@end
