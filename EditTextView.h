//
//  EditTextView.h
//  UItextView
//
//  Created by 朱公园 on 2017/5/12.
//  Copyright © 2017年 zhugongyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TEXTCOUNT @"TEXTCOUNT"

@interface EditTextView : UITextView

@property(nonatomic,strong)NSString * placeHolder; //占位文字
@property(nonatomic,strong)UIColor * textEditColor; //设置文本颜色
@property(nonatomic,strong)UIFont * fontEdit; //字体

@property(nonatomic, assign)CGFloat maxHeight; //textView最大高度设置，如果有，就设置，否则高度随着文字高度变化而变化

@property(nonatomic, assign)NSInteger textMaxCount; //设置最大输入文本个数

@property(nonatomic, assign)NSInteger textCount; //已经输入的文本个数,通过通知来获取

@end
