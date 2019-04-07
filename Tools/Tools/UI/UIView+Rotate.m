//
//  UIView+Rotate.m
//  Sleepace
//
//  Created by mac on 3/24/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "UIView+Rotate.h"

#define kRotateAnimation @"_kRotateAnimation"
@implementation UIView (Rotate)

- (void)beginAnimationWithDuration:(CGFloat)duration
{
    CAAnimation *anim = [self.layer animationForKey:kRotateAnimation];
    if (anim) { // 如果动画存在就继续播放动画
        [self startRotateAnimation];
    }else{  // 如果动画不存在就创建动画
        [self addRotateAnimationDuration:duration];
    }
}

- (void)addRotateAnimationDuration:(CGFloat)duration{
    [self.layer removeAnimationForKey:kRotateAnimation];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = CGFLOAT_MAX;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.layer setSpeed:1.0];
    [self.layer addAnimation:rotationAnimation forKey:kRotateAnimation];
}

- (void)startRotateAnimation{
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

- (void)stopRotateAnimation{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}
@end
