//
//  ViewController.m
//  moveButton
//
//  Created by 朱公园 on 2016/12/6.
//  Copyright © 2016年 朱公园. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    
}

@property ( nonatomic , strong )  UIButton * beginBtn;

@property ( nonatomic , strong ) NSTimer * timer;
@property ( nonatomic , assign ) int i;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.i = 0;
    self.beginBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 200, 30)];
    _beginBtn.backgroundColor = [UIColor blueColor];
    [_beginBtn setTitle:@"点击开始红包" forState:UIControlStateNormal];
    [_beginBtn addTarget:self action:@selector(clickBeginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_beginBtn];
}

- (void)clickBeginBtn{
    NSLog(@"点击开始下红包");
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(move) userInfo:nil repeats:YES];
    [self.timer fire];
    
}

- (void)move{
    //  随机的横坐标
    float x = arc4random()%320;
    NSLog(@"%f",x);
    
    UIButton * moveBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, -50, 100, 37)];
    moveBtn.backgroundColor = [UIColor redColor];
    [moveBtn setTitle:@"红包" forState:UIControlStateNormal];
    moveBtn.tag = _i+1;
    _i++;
    [moveBtn addTarget:self action:@selector(clickMoveBtnOne:) forControlEvents:UIControlEventTouchUpInside];
    [moveBtn sizeToFit];
    [self.view addSubview:moveBtn];
    [UIView animateWithDuration:7 delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        CGRect rect = moveBtn.frame;
        rect.origin.y = self.view.frame.size.height-37;
        moveBtn.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [moveBtn removeFromSuperview];
        
    }];
    
    // 如果大于10个红包，就不下了
    if (_i>=10) {
        [self.timer invalidate];
        //赋值为0 ，方便下次再次点击
        _i = 0;
    }
    
}

- (void)dealloc{
    
    [self.timer invalidate];
}

- (void)clickMoveBtnOne:(UIButton *)sender{
    
    NSLog(@"抢到第个%ld红包",sender.tag);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
