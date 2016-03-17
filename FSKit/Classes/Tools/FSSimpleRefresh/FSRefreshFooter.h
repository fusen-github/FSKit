//
//  FSRefreshFooter.h
//  FSSimpleRefresh
//
//  Created by 四维图新 on 16/3/15.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^FSRefreshFooterBlock)();

@interface FSRefreshFooter : NSObject


+ (instancetype)footerWithScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshWithFooterBlock:(FSRefreshFooterBlock)block;

- (void)endFooterRefreshing;


@end
