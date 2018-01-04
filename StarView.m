//
//  StarView.m
//  MiFengBangBangProject
//
//  Created by 朱公园 on 2018/1/4.
//  Copyright © 2018年 yixiuge. All rights reserved.
//

#import "StarView.h"
#define DEFAULT_STAR_NUMBER 5
#define DEFAULT_SCORE_PERCENT 1
#define STAR_GRAY @"pj_wjx2_icon"
#define STAR_YELLOW @"pj_icon_wjx"

@interface StarView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * frontView;
@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, assign) CGFloat fullScore; //评分的满分值，默认为5
@property (nonatomic, assign) CGFloat actualScore; //评分的实际分数，默认为0
@property(nonatomic,assign)CGFloat starsTotalWidth; //星星占据的总宽度和高度
@property(nonatomic,assign)CGFloat clickoffset; //记录点击的偏移量
@end
@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.starScore =2;//默认一个星星代表1分
        self.numberOfStars = 5; //默认最高星星数量5个
        self.actualScore = 0;//默认最低分0分
        self.currentScore = 0;
        self.starSpace = 0;
        self.starSize = 12;
        self.clickoffset = 0;
    }
    return self;
}

- (void)setModifyStarLevel:(BOOL)modifyStarLevel{
    _modifyStarLevel = modifyStarLevel;
    if (modifyStarLevel) {
        self.backgroundColor =[UIColor yellowColor];
        UIPanGestureRecognizer * swipe = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:swipe];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
}


- (void)setCurrentScore:(CGFloat)currentScore{
    _currentScore = currentScore;
    self.actualScore = currentScore;
}
- (void)setActualScore:(CGFloat)actualScore {
    if (_actualScore == actualScore) {
        return;
    }
    _actualScore = actualScore;
    [self setNeedsLayout];
}


- (CGFloat)fullScore{
    return  self.starScore*self.numberOfStars;
}

- (CGFloat)starsTotalWidth{
    return  self.starSize*_numberOfStars+ (self.numberOfStars-1)*self.starSpace;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.actualScore > self.fullScore) {
        _actualScore = self.fullScore;
    } else if (self.actualScore < 0) {
        _actualScore = 0;
    } else {
        _actualScore = self.actualScore;
    }
    
    CGFloat scorePercent = [self tranScoreToLength:self.actualScore];
    
    [self removeAllSubviews];
    self.backgroundView = [self createStarViewWithImage:STAR_GRAY];
    self.frontView = [self createStarViewWithImage:STAR_YELLOW];
    [self addSubview:self.backgroundView];
    [self addSubview:self.frontView];
    self.frontView.frame = CGRectMake(0, 0, self.starsTotalWidth * scorePercent,self.starSize);
    self.frame  =CGRectMake(0, 0, self.starsTotalWidth, self.starSize);
    
    
}

//将分数，比如4.7转化成比例
- (CGFloat)tranScoreToLength:(CGFloat)score{
    score = score/self.starScore;
    CGFloat width= (self.starSize + self.starSpace)* (int)score + (score-(int)score)*self.starSize;
    return width/self.starsTotalWidth;
}

//将x滑动距离变化成分数
- (CGFloat)ratitoTranScore:(CGFloat)x{
    if (x>= self.starsTotalWidth) {
        return self.numberOfStars*self.starScore;
    }else{
        int count = x/(self.starSpace+self.starSize);
        CGFloat scoreRiht =(x-count*(self.starSpace+self.starSize))-self.starSize;
        if (scoreRiht>=0) {
            return ((count+1)*self.starScore);
        }else{
            return (count*self.starScore+(x-count*(self.starSpace+self.starSize))/self.starSize*self.starScore);
        }
    }
}

- (void)tapClick:(UIGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    CGFloat offset = point.x;
    
    if (self.isOnlyHalfStarOrAllStar) {
        self.actualScore = [self changeToCompleteStar:offset];
    }else{
        self.actualScore = [self ratitoTranScore:offset];
    }
    
    if (self.handleStarChangeBlock) {
            NSString * actualStr = [NSString stringWithFormat:@"%.1f",self.actualScore];
        if (self.actualScore>self.numberOfStars*self.starScore) {
            actualStr = [NSString stringWithFormat:@"%d",(int)self.actualScore];
        }
        self.handleStarChangeBlock(actualStr);
    }
}

// 创建星星View
- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.starsTotalWidth, self.starSize)];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    for (NSInteger i = 0; i < self.numberOfStars; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i*(self.starSize+self.starSpace), 0, self.starSize, self.starSize);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    
    return view;
}

//将点击x的偏移量转化成半颗星或者整颗星的分数
- (CGFloat)changeToCompleteStar:(CGFloat)x {

    for (int i = 0; i<2*self.numberOfStars; i++) {
        if (x>i*(self.starSize+self.starSpace)&& x<=(self.starSize/2+i*(self.starSize+self.starSpace))) {
            return (self.starScore/2+self.starScore*i);
        }
        if (x>(self.starSize/2+i*(self.starSize+self.starSpace))&& x<= ((i+1)*self.starSize+ i*self.starSpace)) {
            return self.starScore*(i+1);
        }
    }
    return self.actualScore;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


@end
