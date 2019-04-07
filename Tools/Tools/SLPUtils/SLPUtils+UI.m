//
//  SLPUtils+UI.m
//  Sleepace
//
//  Created by mac on 5/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils+UI.h"

@implementation SLPUtils (UI)

+ (void)addSubView:(UIView *)subView suitableTo:(UIView *)superView{
    if (!subView || !superView){
        return;
    }
    
    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superView addSubview:subView];
    NSDictionary *subViews = NSDictionaryOfVariableBindings(subView,superView);
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:nil views:subViews]];
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:subViews]];
}

+ (void)removeAllSubViewsFrom:(UIView *)view{
    if (!view){
        return;
    }
    NSArray *subViews = [view subviews];
    for (UIView *subView in subViews){
        [subView removeFromSuperview];
    }
}

+ (UIWindow *)keyWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window){
        window = [[[UIApplication sharedApplication] delegate] window];
    }
    return window;
}

+ (UIFont *)boldFontWithSize:(CGFloat)size{
    return [UIFont boldSystemFontOfSize:size];
}

+ (UIFont *)fontWithSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size];
}

+ (UIColor*)colorWithIRed:(NSInteger)red iGreen:(CGFloat)green iBlue:(CGFloat)blue alpha:(CGFloat)alpha{
    CGFloat iRed = red;
    CGFloat iGreen = green;
    CGFloat iBlue = blue;
    return [UIColor colorWithRed:iRed/255.0 green:iGreen/255.0 blue:iBlue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha{
    NSInteger red = (rgb >> 16 ) & 0xff;
    NSInteger green = (rgb >> 8 ) & 0xff;
    NSInteger blue = rgb & 0xff;
    return [self colorWithIRed:red iGreen:green iBlue:blue alpha:alpha];
}

+ (UIImage *)imageFromColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat r,g,b,alpha;
    [color getRed:&r green:&g blue:&b alpha:&alpha];
    
    if (alpha == 1.0){
        return theImage;
    }
    
    UIGraphicsBeginImageContextWithOptions(theImage.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, theImage.size.width, theImage.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, theImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (void)setView:(UIView *)view cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth color:(UIColor *)color{
    //设置layer
    CALayer *layer=[view layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    [layer setCornerRadius:radius];
    //设置边框线的宽
    //
//    [layer setBorderWidth:borderWidth];
    if (color){
        //设置边框线的颜色
        [layer setBorderColor:[color CGColor]];
    }
}

+ (void)reloadTableView:(UITableView *)tableView rowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    if (animation == UITableViewRowAnimationNone){
        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }else{
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        [tableView endUpdates];
    }
}

+ (void)reloadTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation{
    [self reloadTableView:tableView rowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
}

+ (void)setTextField:(UITextField *)textField placeHolder:(NSString *)placeHolder font:(UIFont *)font color:(UIColor *)color{
    if (!placeHolder){
        placeHolder = @"";
    }
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    [textField setAttributedPlaceholder:attr];
}

+ (UITableViewCell *)tableView:(UITableView *)tableView cellNibName:(NSString *)nibName{
    if (!tableView || [nibName length] == 0){
        return nil;
    }
    
    NSString *cellID = nibName;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell){
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellID];
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    return cell;
}

+ (void)setLable:(UILabel *)label text:(NSString *)text font:(UIFont *)font lineGap:(CGFloat)lineGap{
    if (!label){
        return;
    }
    
    if (text.length == 0){
        text = @"";
    }
    NSRange range = NSMakeRange(0, [text length]);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    if (font){
        [attributedString addAttribute:NSFontAttributeName value:font range:range];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineGap];//调整行间距
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    label.attributedText = attributedString;
}

+ (CAShapeLayer *)fillStrokeLineToView:(UIView *)view color:(UIColor *)color lineWidth:(NSInteger)width gap:(NSInteger)gap{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGSize size = view.bounds.size;
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[color CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:size.height];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInteger:width],
      [NSNumber numberWithInteger:gap],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width,0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[view layer] addSublayer:shapeLayer];
    
    return shapeLayer;
}

+ (void)setLableNormalAttributes:(UILabel *)label text:(NSString *)textStr fontSize:(CGFloat)fontSize height:(CGFloat)height {
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    paragraphStyle.minimumLineHeight = fontSize + height;
    paragraphStyle.maximumLineHeight = paragraphStyle.minimumLineHeight;
    paragraphStyle.hyphenationFactor = 0.97;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[SLPUtils fontWithSize:fontSize],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSRange rang = NSMakeRange(0, textStr.length);
    [attributedStr addAttributes:attributes range:rang];
    [label setAttributedText:attributedStr];
}

+ (CGFloat)getLabelHeight:(UILabel *)label constraint:(CGSize)constraint lineGap:(CGFloat)lineGap {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    paragraphStyle.minimumLineHeight = label.font.pointSize + lineGap;
    paragraphStyle.maximumLineHeight = paragraphStyle.minimumLineHeight;
    paragraphStyle.hyphenationFactor = 0.97;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:label.font,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:context].size;
    
    CGSize size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIFont *)plusSize:(CGFloat)size fromFont:(UIFont *)font{
    CGFloat pointSize = font.pointSize;
    NSString *name = font.fontName;
    
    pointSize += size;
    UIFont *newFont = [UIFont fontWithName:name size:pointSize];
    return newFont;
}

+ (void)setWebView:(UIWebView *)webView backgroundColor:(UIColor *)color{
    CGFloat r,g,b;
    [color getRed:&r green:&g blue:&b alpha:nil];
    NSInteger iR = r*0xff;
    NSInteger iG = g*0xff;
    NSInteger iB = b*0xff;
    
    NSString *colorString = [NSString stringWithFormat:@"%02x%02x%02x",(int)iR,(int)iG,(int)iB];
    NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.background='#%@'",colorString];
    [webView stringByEvaluatingJavaScriptFromString:js];
}
@end
