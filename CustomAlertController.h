//
//  CustomAlertController.h
//  qinfubao
//
//  Created by chuzhaozhi on 16/9/19.
//  Copyright © 2016年 杭州格式科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(NSString * inputText);
typedef void(^CancelBlock)();
@interface CustomAlertController : UIViewController <UITextFieldDelegate>
- (instancetype)initWithConfirmAction:(ClickBlock)confirmBlock andCancelAction:(CancelBlock)cancelBlcok;
@end
