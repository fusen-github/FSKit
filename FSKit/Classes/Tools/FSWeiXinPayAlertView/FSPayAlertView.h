//
//  FSPayAlertView.h
//  DCPayAlertDemo
//
//  Created by 四维图新 on 16/4/3.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FSCompletionBlock)(NSString *result);

@interface FSPayAlertView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detailTitle;

/**
 *  金额
 */
@property (nonatomic, assign) double amount;

@property (nonatomic, copy) FSCompletionBlock completionBlock;

+ (instancetype)getPayAlertView;

- (void)show;

- (void)dismiss;

@end
