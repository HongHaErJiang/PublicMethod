//
//  UIView+ColorImage.h
//  yyyy
//
//  Created by 朱公园 on 16/8/22.
//  Copyright © 2016年 朱公园. All rights reserved.
//
//传入颜色值，获取颜色生成的图像
#import <UIKit/UIKit.h>

@interface UIView (ColorImage)

+ (UIImage *)imageByColor:(UIColor *)color;

@end
