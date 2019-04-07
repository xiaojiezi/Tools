//
//  SLPUtils+UI.h
//  Sleepace
//
//  Created by mac on 5/16/17.
//  Copyright © 2017 YJ. All rights reserved.
//

#import "SLPUtils.h"

@interface SLPUtils (UI)
+ (void)addSubView:(UIView *)subView suitableTo:(UIView *)superView;
+ (void)removeAllSubViewsFrom:(UIView *)view;
+ (UIWindow *)keyWindow;
+ (UIFont *)boldFontWithSize:(CGFloat)size;
+ (UIFont *)fontWithSize:(CGFloat)size;
+ (UIColor*)colorWithIRed:(NSInteger)red iGreen:(CGFloat)green iBlue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha;
+ (UIImage *)imageFromColor:(UIColor *)color;

+ (void)setView:(UIView *)view cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth color:(UIColor *)color;
+ (void)reloadTableView:(UITableView *)tableView rowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
+ (void)reloadTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

//自定义textfield placeholder的颜色的字体
+ (void)setTextField:(UITextField *)textField placeHolder:(NSString *)placeHolder font:(UIFont *)font color:(UIColor *)color;

//通过cell的nib name创建可复用的tableViewCell
+ (UITableViewCell *)tableView:(UITableView *)tableView cellNibName:(NSString *)nibName;

//设置label的字体 行高 和内容
+ (void)setLable:(UILabel *)label text:(NSString *)text font:(UIFont *)font lineGap:(CGFloat)lineGap;

//画虚线
+ (CAShapeLayer *)fillStrokeLineToView:(UIView *)view color:(UIColor *)color lineWidth:(NSInteger)width gap:(NSInteger)gap;
//设置Label的默认行间距
+ (void)setLableNormalAttributes:(UILabel *)label text:(NSString *)textStr fontSize:(CGFloat)fontSize height:(CGFloat)height;

+ (CGFloat)getLabelHeight:(UILabel *)label constraint:(CGSize)constraint lineGap:(CGFloat)lineGap;
//顶部ViewController
+ (UIViewController *)topViewController;
+ (UIFont *)plusSize:(CGFloat)size fromFont:(UIFont *)font;

+ (void)setWebView:(UIWebView *)webView backgroundColor:(UIColor *)color;
@end
