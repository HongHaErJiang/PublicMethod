//
//  UIView+AnimationClick.m
//  test-23-CoreAnimation-KeyAnimation
//
//  Created by Kyo on 4/30/14.
//  Copyright (c) 2014 kyo. All rights reserved.
//

#import "UIView+AnimationClick.h"

@implementation UIView (AnimationClick)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CALayer *layer = [self.layer hitTest:point];
    layer = [self realDelegateLayer:layer]; //得到能响应的layer
    
    if (!layer || !layer.delegate || layer.delegate == [NSNull null]) {   //如果为空
        return nil;
    }
    
    UIView *view = layer.delegate;
    
    if ([view isKindOfClass:[UIWindow class]]) {  //如果是UIStatusWIndow或继承自UIScrollView
        return view;
    }
    
    //先得到当前点击控件的展示层左上角到window的frame
    CALayer *viewPresentationLayer = view.layer.presentationLayer;
    CGRect viewPresentationLayerRect = [self.layer convertRect:CGRectMake(0, 0, viewPresentationLayer.frame.size.width, viewPresentationLayer.frame.size.height) fromLayer:viewPresentationLayer];
    //如果view是UIScrollView,则要＋上contentoff，不然计算不准确
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        viewPresentationLayerRect = CGRectMake(viewPresentationLayerRect.origin.x + scrollView.contentOffset.x, viewPresentationLayerRect.origin.y + scrollView.contentOffset.y, viewPresentationLayerRect.size.width, viewPresentationLayerRect.size.height);
    }
    //如果当前点击的view不能响应事件或展示层不匹配坐标,则得到当前坐标能响应事件且展示层匹配坐标的控件
    if (view.userInteractionEnabled == NO || !CGRectContainsPoint(viewPresentationLayerRect, point)) {
        view = [self realInteractionView:view point:point];
    }
    
    if (view.layer.sublayers.count <= 0) {  //如果没有子layer
        return view;
    }
    
    for (int i = view.layer.sublayers.count - 1; i >= 0; i--) { //递归子layer，如果子layer的delegate的展示层layer坐标跟当前点击坐标匹配且可以接受事件，则返回这个匹配的layer
        CALayer *subLayer = view.layer.sublayers[i];
        
        if (!subLayer.delegate && subLayer.delegate == [NSNull null]) { //如果子layer所在控件为空，继续下一循环
            continue;
        }
        
        UIView *subView = subLayer.delegate;    //得到子layer所在控件
        CALayer *subViewPresentationLayer = (CALayer *)subView.layer.presentationLayer;
        CGRect subViewPresentationLayerRect = [self.layer convertRect:CGRectMake(0, 0, subViewPresentationLayer.frame.size.width, subViewPresentationLayer.frame.size.height) fromLayer:subViewPresentationLayer];
        //如果view是UIScrollView,则要＋上contentoff，不然计算不准确
        if ([subView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subView;
            subViewPresentationLayerRect = CGRectMake(subViewPresentationLayerRect.origin.x + scrollView.contentOffset.x, subViewPresentationLayerRect.origin.y + scrollView.contentOffset.y, subViewPresentationLayerRect.size.width, subViewPresentationLayerRect.size.height);
        }
        if (CGRectContainsPoint(subViewPresentationLayerRect, point)) {   //如果子layer所在控件的展示层坐标匹配当前点击坐标
            return subLayer.delegate;
        }
    }
    
    return view;
}

//得到能够接收到事件的view
- (UIView *)realInteractionView:(UIView *)tempView point:(CGPoint)point
{
    UIView *supView = tempView.superview;
    if (!supView || (id)supView == [NSNull null]) { //如果没有父视图
        return tempView;
    }
    
    //递归父视图中的控件，如果有其它能相应事件的控件在这位置，则返回能响应事件的控件
    for (int i = supView.subviews.count - 1; i >= 0; i--) {
        UIView *subView = supView.subviews[i];
        CALayer *subViewPresentationLayer = subView.layer.presentationLayer;
        CGRect subViewPresentationLayerRect = [self.layer convertRect:CGRectMake(0, 0, subViewPresentationLayer.frame.size.width, subViewPresentationLayer.frame.size.height) fromLayer:subViewPresentationLayer];
        if (CGRectContainsPoint(subViewPresentationLayerRect, point)) {    //如果匹配坐标
            if (subView.userInteractionEnabled) {   //如果能响应事件
                return subView;
            }
        }
    }
        return [self realInteractionView:supView point:point];
}

//得到能响应的layer(有delegate就说明能响应)
- (CALayer *)realDelegateLayer:(CALayer *)tempLayer
{
    if (!tempLayer.delegate || tempLayer.delegate == [NSNull null]) {   //如果为空
        CALayer *supLayer = tempLayer.superlayer;   //得到父layer
        if (!supLayer) {
            return nil;
        } else {
            return [self realDelegateLayer:supLayer];
        }
    } else {
        return tempLayer;
    }
}

@end
