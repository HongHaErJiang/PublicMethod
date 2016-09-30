//
//  CustomAlertController.m
//  qinfubao
//
//  Created by chuzhaozhi on 16/9/19.
//  Copyright © 2016年 杭州格式科技有限公司. All rights reserved.
//
#define OnePixel     (1./[UIScreen mainScreen].scale)
#define animateTime  0.35f
#import "CustomAlertController.h"

@interface CustomAlertController ()
@property (nonatomic, assign) BOOL notifiKeyboardHide;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UITextField * inputTextField;  //输入框
@property (nonatomic, strong) UIView * operateView; //操作视图
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *comfireButton;
@property (nonatomic, copy) ClickBlock confirmBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;

@end

@implementation CustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(0, 0, 0, 0.5);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //必须在这里，否则动画无效
    [self showAlertView];
}
- (instancetype)initWithConfirmAction:(ClickBlock)confirmBlock andCancelAction:(CancelBlock)cancelBlcok
{
    if (self = [super init]) {
        self.confirmBlock = confirmBlock;
        self.cancelBlock = cancelBlcok;
        
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}
#pragma mark - 创建UI
- (void)showAlertView
{
    _notifiKeyboardHide = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    /**
     *  添加控件
     */
    [self.view addSubview:self.operateView];
    [self.operateView addSubview:self.titleLabel];
    [self.operateView addSubview:self.messageLabel];
    [self.operateView addSubview:self.inputTextField];
    [self.operateView addSubview:self.cancelButton];
    [self.operateView addSubview:self.comfireButton];
    [self autoLayout];
    [self shakeToShow:self.operateView];

}
-(void)autoLayout{
    [self.operateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ScreenH/2/2);
        make.left.equalTo(23.75);
        make.right.equalTo(-23.75);
        make.height.equalTo(205);

    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.operateView);
        make.left.equalTo(self.operateView);
        make.right.equalTo(self.operateView);
        make.height.equalTo(34);
    }];

    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.titleLabel.bottom).offset(20);
        make.left.equalTo(self.operateView.mas_left).offset(40);
        make.height.equalTo(30);
        make.right.equalTo(self.operateView.mas_right).offset(-40);
    }];

    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.bottom).offset(20);
        make.left.equalTo(self.messageLabel.mas_left);
        make.right.equalTo(self.messageLabel.mas_right);
        make.height.equalTo(34);
    }];

    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.operateView.mas_left).offset(40);
        make.right.mas_equalTo(self.comfireButton.mas_left).with.offset(-20);
        make.top.mas_equalTo(self.inputTextField.mas_bottom).offset(20);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(self.comfireButton);
    }];

    [self.comfireButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right).with.offset(20);
        make.right.equalTo(self.inputTextField.mas_right);
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(self.cancelButton);
        make.width.equalTo(self.cancelButton);
    }];
}
-(UIView *)operateView{
    if (!_operateView) {
        _operateView = [[UIView alloc] init];
        _operateView.backgroundColor = [UIColor whiteColor];
        _operateView.layer.cornerRadius = 5;
        _operateView.clipsToBounds = YES;
    }
    return _operateView;
}
-(UILabel *)titleLabel {
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = FONT(15);
        _titleLabel.text = @"操作确认";
        _titleLabel.backgroundColor = RGBA(162,170,177,1);
        _titleLabel.textColor = RGB(255,255,255);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)messageLabel {
    if (!_messageLabel){
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.font = FONT(14);
        _messageLabel.text = @"该操作为敏感操作需输入密码:";
        _messageLabel.textColor = RGB(255,80,0);
        _messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _messageLabel;
}
-(UITextField *)inputTextField {
    if(!_inputTextField){
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _inputTextField.delegate = self;
        _inputTextField.keyboardType = UIKeyboardTypeDefault;
        _inputTextField.returnKeyType = UIReturnKeyDone;
        _inputTextField.font = [UIFont systemFontOfSize:16];
        _inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:RGB(162,170,177), NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        _inputTextField.textColor = COLOR_TITLE;
        _inputTextField.secureTextEntry = YES;
        _inputTextField.textAlignment = NSTextAlignmentCenter;
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTextField.layer.borderColor = RGB(162,170,177).CGColor;
        _inputTextField.layer.borderWidth = 0.5;
    }
    return _inputTextField;
}
-(UIButton *)cancelButton {
    if (!_cancelButton){
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _cancelButton.backgroundColor = RGBA(162,170,177,1);
        _cancelButton.titleLabel.font = FONT(15);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 5;
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
-(UIButton *)comfireButton {
    if (!_comfireButton){
        _comfireButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _comfireButton.backgroundColor = COLOR_NAV;
        _comfireButton.titleLabel.font = FONT(15);
        [_comfireButton setTitle:@"确定" forState:UIControlStateNormal];
        [_comfireButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comfireButton.layer.masksToBounds = YES;
        _comfireButton.layer.cornerRadius = 5;
        [_comfireButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comfireButton;
}

#pragma mark - 移除视图
- (void)removeAlertView
{
    if ([_inputTextField isFirstResponder]) {
        [_inputTextField resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        _operateView.alpha = 0;
        _operateView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        if (_notifiKeyboardHide) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)confirmAction:(UIButton *)sender
{
    if (self.confirmBlock) {
        self.confirmBlock(_inputTextField.text);
    }
    
    [self removeAlertView];
}
- (void)cancelAction:(UIButton *)sender
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    [self removeAlertView];
}

#pragma mark - 监听键盘弹起，操作框动画
///键盘弹起，页面动画，监听
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 键盘的frame
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGFloat keyboardOriginY = ScreenH - keyboardHeight;
    CGFloat operateMaxY = ScreenH/2. + _operateView.bounds.size.height/2. + 16;
    //    DLog(@"--- %lf %lf", keyboardOriginY, operateMaxY);
    
    if (operateMaxY >= keyboardOriginY) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = _operateView.frame;
            rect.origin.y = keyboardOriginY - rect.size.height - 16;
            _operateView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        _notifiKeyboardHide = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    else {
        _notifiKeyboardHide = NO;
    }
}
///键盘收起，页面动画，监听
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = _operateView.frame;
        rect.origin.y = (ScreenH - rect.size.height)/2.;
        _operateView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 输入框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - 弹性震颤动画
- (void)shakeToShow:(UIView *)aView
{
    CAKeyframeAnimation * popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.35;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @0.8f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [aView.layer addAnimation:popAnimation forKey:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeAlertView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
