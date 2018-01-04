//
//  StarView.h
//  MiFengBangBangProject
//
//  Created by 朱公园 on 2018/1/4.
//  Copyright © 2018年 yixiuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

/**
 可以展示的星星数量,默认5个
 */
@property(nonatomic,assign)NSInteger numberOfStars;

/**
 每个星星代表的分值，默认1分
 */
@property(nonatomic,assign)CGFloat starScore;

/**
 是否可以修改星星级别,默认不可以
 */
@property(nonatomic,assign)BOOL modifyStarLevel;

/**
 是否只能选中半颗星或者整个星，默认NO
 */
@property(nonatomic,assign)BOOL isOnlyHalfStarOrAllStar;

/**
 // 当前分数，默认0
 */
@property(nonatomic,assign)CGFloat currentScore;

/**
 //星星间距，默认0
 */
@property(nonatomic,assign)CGFloat starSpace;

/**
 //星星尺寸，默认12
 */
@property(nonatomic,assign)CGFloat starSize;


/**
 回调实际分数
 */
@property (nonatomic, copy) void(^handleStarChangeBlock)(NSString * actualScore);

@end
