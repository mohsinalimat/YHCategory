//
//  YHTextView.h
//  YHCategory
//
//  Created by 郭月辉 on 2016/11/15.
//  Copyright © 2016年 Theshy. All rights reserved.
//

#import "YHTextView.h"

@interface YHTextView ()
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation YHTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor= [UIColor clearColor];
        UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
        placeholderLabel.backgroundColor= [UIColor clearColor];
        placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel= placeholderLabel; //赋值保存
        self.myPlaceholderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
        self.font= [UIFont systemFontOfSize:16]; //设置默认的字体
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
    }
    return self;
}


#pragma mark -监听文字改变

- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGRect cframe = self.frame;
    //根据文字计算高度
    CGSize maxSize =CGSizeMake(self.placeholderLabel.frame.size.width, MAXFLOAT);
    CGFloat cheight = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = CGRectMake(8, 6, cframe.size.width - 16, cheight);
}

- (void)setMyPlaceholder:(NSString*)myPlaceholder{
    
    _myPlaceholder= [myPlaceholder copy];
    //设置文字
    self.placeholderLabel.text= myPlaceholder;
    //重新计算子控件frame
    [self setNeedsLayout];
}
- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor{
    
    _myPlaceholderColor= myPlaceholderColor;
    //设置颜色
    self.placeholderLabel.textColor= myPlaceholderColor;
}
//重写这个set方法保持font一致

- (void)setFont:(UIFont*)font {
    
    [super setFont:font];
    self.placeholderLabel.font= font;
    //重新计算子控件frame
    [self setNeedsLayout];
    
}

- (void)setText:(NSString*)text{
    
    [super setText:text];
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    
}
- (void)setAttributedText:(NSAttributedString*)attributedText {
    
    [super setAttributedText:attributedText];
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}

@end
