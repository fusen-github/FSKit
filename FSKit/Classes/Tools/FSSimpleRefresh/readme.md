//
//  readme.m
//  FSSimpleRefresh
//
//  Created by 四维图新 on 16/3/16.
//  Copyright © 2016年 四维图新. All rights reserved.
//

// 用法：

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefreshHeader];
    
    [self setupRefreshFooter];
    
}

- (void)setupRefreshFooter
{
    FSRefreshFooter *footer = [FSRefreshFooter footerWithScrollView:self.tableView];
    
    // 必须对footer进行强引用（用strong）否则该对象会被释放
    self.footer = footer;
    
    [footer beginRefreshWithFooterBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"完了");
            
            [footer endFooterRefreshing];
            
        });
        
    }];
}

- (void)setupRefreshHeader
{
    __block FSRefreshHeader *header = [FSRefreshHeader headerWithScrollView:self.tableView];
    
    // 必须对header进行强引用（用strong）否则该对象会被释放
    self.header = header;
    
    [header beginRefreshWithHeaderBlock:^{
        
        NSLog(@"请求网络。。");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"请求结束...");
            
            [self.header endHeaderRefreshing];
        });
    }];
    
    [header beginRefreshWhenViewWillAppear];
}







