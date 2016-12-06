//
//  UIButton+AnimationClick.m
//  test-23-CoreAnimation-KeyAnimation
//
//  Created by Kyo on 14-4-29.
//  Copyright (c) 2014年 kyo. All rights reserved.
//

#import "UIButton+AnimationClick.h"

@implementation UIButton (AnimationClick)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CALayer *layer = [self.layer presentationLayer];
    //如果展示层的坐标包含当前点击的坐标
    if (CGRectContainsPoint(layer.frame, [touch locationInView:self.superview])) {
        [self setHighlighted:YES];  //设置高亮状态
    } else {
        [self cancelTrackingWithEvent:event];
        [touch setValue:@(UITouchPhaseCancelled) forKey:@"phase"];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CALayer *layer = [self.layer presentationLayer];
    //如果展示层的坐标包含当前点击的坐标
    if (CGRectContainsPoint(layer.frame, [touch locationInView:self.superview])) {
        [self setHighlighted:YES];  //设置高亮状态
    } else {
        [self setHighlighted:NO];  //取消高亮状态
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CALayer *layer = [self.layer presentationLayer];
    //如果展示层的坐标包含当前点击的坐标，说明是单击了按钮，则模拟单击
    if (CGRectContainsPoint(layer.frame, [touch locationInView:self.superview])) {
        [self cancelTrackingWithEvent:event];
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {    //反之相当于单击到了外面
        [self cancelTrackingWithEvent:event];
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setHighlighted:NO];  //设置高亮状态
}

@end
