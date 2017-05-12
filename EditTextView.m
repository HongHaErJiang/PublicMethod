//
//  EditTextView.m
//  UItextView
//
//  Created by 朱公园 on 2017/5/12.
//  Copyright © 2017年 zhugongyuan. All rights reserved.
//

#import "EditTextView.h"


@interface EditTextView ()<UITextViewDelegate>


@property(nonatomic, assign)CGFloat width;

@property(nonatomic, assign)CGFloat height;

@end

@implementation EditTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addObserver];
        self.textColor = [UIColor grayColor];
        self.delegate = self;
        self.width = CGRectGetWidth(self.frame);
        self.height = CGRectGetHeight(self.frame);
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setFontEdit:(UIFont *)fontEdit{
    _fontEdit = fontEdit;
    self.font = fontEdit;
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.text = placeHolder;
}

- (void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
}


- (void)textViewDidBeginEditing:(NSNotification *)notification{
    
    if ([[super text] isEqualToString:self.placeHolder]) {
        [super setText:@""];
        [super setTextColor:self.textEditColor];
    }
}

- (void)textViewDidEndEditing:(NSNotification *)notification{
    
    if ([super text].length == 0) {
        [super setText:self.placeHolder];
        [super setTextColor: [UIColor grayColor]];
    }
}



- (void)textViewDidChange:(NSNotification *)notification{
    
    NSString * textString = self.text;
    
    
    //====================此处对输入字数限制
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
    if (!position){
        if (self.textMaxCount&& textString.length > self.textMaxCount){
            NSRange rangeRange = [textString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.textMaxCount)];
            self.text = [textString substringWithRange:rangeRange];
        }
    }
    
    // 此处限制高度
    CGRect rect = [textString boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.fontEdit,NSForegroundColorAttributeName:self.textEditColor} context:nil];
    
    CGRect newFrame = self.frame;
    if (rect.size.height> self.height) {
        // 如果外部设置了固定高度
        if (self.maxHeight && rect.size.height> self.maxHeight) {
            newFrame.size = CGSizeMake(self.width, self.maxHeight);
        }else{
            newFrame.size = CGSizeMake(self.width, rect.size.height);
        }
    }else{
        
        newFrame.size = CGSizeMake(self.width, self.height);
    }
    
    
    self.frame = newFrame;
    self.textCount = self.text.length;
    //发送通知，计算文本字数
    [[NSNotificationCenter defaultCenter] postNotificationName:TEXTCOUNT object:@(self.textCount)];
}



//获取文本时，一定要排除占位符的情况
- (NSString *)text{
    if ([[super text] isEqualToString:self.placeHolder]) {
        return @"";
    }
    return [super text];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
