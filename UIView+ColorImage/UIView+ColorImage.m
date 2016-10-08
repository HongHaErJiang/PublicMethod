//
//  UIView+ColorImage.m
//  yyyy
//
//  Created by 朱公园 on 16/8/22.
//  Copyright © 2016年 朱公园. All rights reserved.
//

#import "UIView+ColorImage.h"

@implementation UIView (ColorImage)

+ (UIImage *)imageByColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //设置color填充上下文
    CGContextSetFillColorWithColor(ref, color.CGColor);
    //渲染上下文尺寸
    CGContextFillRect(ref, rect);
    //获取当前上下文中的图片
    UIImage * theImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
