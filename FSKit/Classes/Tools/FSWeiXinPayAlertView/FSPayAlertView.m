//
//  FSPayAlertView.m
//  DCPayAlertDemo
//
//  Created by 四维图新 on 16/4/3.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "FSPayAlertView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define keyboardHeight 216

#define kAlertViewHeight 200

#define kPasswordCount 6

#define kAlertViewX 40

#define kInputViewX 15

#define kInputViewH  44


@interface FSPayAlertView ()<UITextFieldDelegate>

@property (nonatomic, weak) UIView *coverView;

@property (nonatomic, weak) UIView *alertView;

@property (nonatomic, weak) UIView *inputView;

@property (nonatomic, strong) UILabel *titleLabel, *line, *detailLabel, *amountLabel;

@property (nonatomic, weak) UIButton *closeButton;

@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic, weak) UITextField *textField;

//@property (nonatomic, copy)  NSString *totalStr;

@end

@implementation FSPayAlertView

+ (instancetype)getPayAlertView
{
    return [[FSPayAlertView alloc] init];
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        
//        self.backgroundColor = [UIColor blackColor];
        
//        self.alpha = 0.25;
        
//        self.totalStr = @"";
        
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView
{
    if (self.alertView == nil)
    {
        UIView *coverView = [[UIView alloc] initWithFrame:self.bounds];
        
        coverView.backgroundColor = [UIColor blackColor];
        
        coverView.alpha = 0.4;
        
        self.coverView = coverView;
        
        [self addSubview:coverView];
        
        
        UIView *alertView = [[UIView alloc] init];
        
        self.alertView = alertView;
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        alertView.layer.cornerRadius = 5;
        
        alertView.layer.masksToBounds = YES;
        
        [self addSubview:alertView];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        
        self.titleLabel = titleLabel;
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.font = [UIFont systemFontOfSize:16];
        
        titleLabel.textColor = [UIColor darkTextColor];
        
        [alertView addSubview:titleLabel];
        
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        self.closeButton = closeBtn;
        
        [closeBtn setTitle:@"X" forState:UIControlStateNormal]; // ╳
        
        [closeBtn setTitleColor:[UIColor darkTextColor]
                       forState:UIControlStateNormal];
        
        closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [closeBtn addTarget:self
                     action:@selector(didClickCloseButton)
           forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:closeBtn];
        
        
        UILabel *line = [[UILabel alloc] init];
        
        self.line = line;
        
        line.backgroundColor = [UIColor darkGrayColor];
        
        [alertView addSubview:line];
        
        
        
        UILabel *detailLabel = [[UILabel alloc] init];
        
        self.detailLabel = detailLabel;
        
        detailLabel.textColor = [UIColor darkTextColor];
        
        detailLabel.font = [UIFont systemFontOfSize:14];
        
        detailLabel.textAlignment = NSTextAlignmentCenter;
        
        [alertView addSubview:detailLabel];
        
        
        UILabel *amountLabel = [[UILabel alloc] init];
        
        self.amountLabel = amountLabel;
        
        amountLabel.textAlignment = NSTextAlignmentCenter;
        
        amountLabel.font = [UIFont systemFontOfSize:33];
        
        amountLabel.textColor = [UIColor darkTextColor];
        
        [alertView addSubview:amountLabel];
        
        
        UIView *inputView = [[UIView alloc] init];
        
        self.inputView = inputView;
        
        inputView.backgroundColor = [UIColor whiteColor];
        
        inputView.layer.borderWidth = 1;
        
        inputView.layer.borderColor = [UIColor colorWithRed:0.9 green:.9 blue:.9 alpha:1].CGColor;
        
        [alertView addSubview:inputView];
        
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        UITextField *textField = [[UITextField alloc] init];
        
        self.textField = textField;
        
        textField.hidden = YES;
        
        textField.delegate = self;
        
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.inputView addSubview:textField];
        
        
        CGFloat pwdW = ((kScreenWidth - kAlertViewX * 2) - 2 * kInputViewX) / kPasswordCount;
        
        CGFloat pwdH = kInputViewH;
        
        CGFloat dotWH = 10;
        
        for (int i = 0; i < kPasswordCount; i++)
        {
            UILabel *dotLable = [[UILabel alloc] init];
            
            dotLable.hidden = YES;
            
            [tmpArray addObject:dotLable];
            
            CGFloat dotX = i * pwdW + (pwdW - dotWH) * 0.5;
            
            CGFloat dotY = (pwdH - dotWH) * 0.5;
            
            dotLable.frame = CGRectMake(dotX, dotY, dotWH, dotWH);
            
            dotLable.layer.cornerRadius = dotWH * 0.5;
            
            dotLable.layer.masksToBounds = YES;
            
            dotLable.backgroundColor = [UIColor blackColor];
            
            [inputView addSubview:dotLable];
            
            if (i < kPasswordCount - 1)
            {
                UILabel *lineV = [[UILabel alloc] init];
                
                lineV.frame = CGRectMake((i + 1) * pwdW - 0.25, 0, 0.5, pwdH);
                
                lineV.backgroundColor = [UIColor colorWithRed:0.9 green:.9 blue:.9 alpha:1];
                
                [inputView addSubview:lineV];
            }
        }
        
        self.resultArray = tmpArray;
    }
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.transform = CGAffineTransformMakeScale(1.21, 1.21);
    
    self.alertView.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [self.textField becomeFirstResponder];
                         
                         self.alertView.alpha = 1;
                         
                         self.alertView.transform = CGAffineTransformIdentity;
                         
                     } completion:nil];
}


- (void)dismiss
{
    [self didClickCloseButton];
}


- (void)didClickCloseButton
{
    [self.textField resignFirstResponder];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alertView.transform = CGAffineTransformMakeScale(1.2, 1.20);
        
        self.alertView.alpha = 0;
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length + 1 > kPasswordCount && string.length) return NO;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    
    if (![predicate evaluateWithObject:string])
    {
        return NO;
    }
    
    NSString *totalStr = @"";
    
    if (string.length)
    {
        totalStr = [textField.text stringByAppendingString:string];
    }
    else
    {
        totalStr = [textField.text substringToIndex:textField.text.length - 1];
    }
    
    for (int i = 0; i < self.resultArray.count; i++)
    {
        UILabel *label = self.resultArray[i];
        
        if (i < totalStr.length)
        {
            label.hidden = NO;
        }
        else
        {
            label.hidden = YES;
        }
    }
    
    if (totalStr.length == kPasswordCount && self.completionBlock)
    {
        self.completionBlock(totalStr);
    }
    
    return YES;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setDetailTitle:(NSString *)detailTitle
{
    _detailTitle = detailTitle;
    
    self.detailLabel.text = detailTitle;
}

- (void)setAmount:(double)amount
{
    _amount = amount;
    
    self.amountLabel.text = [NSString stringWithFormat:@"¥ %.2f",amount];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat alertX = kAlertViewX;
    
    CGFloat alertY = (kScreenHeight - keyboardHeight - kAlertViewHeight) * 0.5;
    
    CGFloat alertW = kScreenWidth - 2 * alertX;
    
    CGFloat alertH = 44;
    
    _alertView.frame = CGRectMake(alertX, alertY, alertW, kAlertViewHeight);
    
    _titleLabel.frame = CGRectMake(0, 0, alertW, alertH);
    
    _closeButton.frame = CGRectMake(0, 0, alertH, alertH);
    
    _line.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), alertW, 0.5);
    
    _detailLabel.frame = CGRectMake(0, CGRectGetMaxY(_line.frame) + 10, alertW, 20);
    
    _amountLabel.frame = CGRectMake(0, CGRectGetMaxY(_detailLabel.frame) + 10, alertW, 30);
    
    _inputView.frame = CGRectMake(kInputViewX, CGRectGetMaxY(_amountLabel.frame) + 15, alertW - 2 * kInputViewX, kInputViewH);
    
    _textField.frame = _inputView.bounds;
}





@end
