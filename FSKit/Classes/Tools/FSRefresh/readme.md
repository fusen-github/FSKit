


/*
    使用说明：
 */

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    //     默认是在navigationController环境下，如果不是在此环境下，请设置
    //    refreshHeader.isEffectedByNavigationController = NO;
    
    [refreshHeader addToScrollView:self.tableView];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    
    __weak typeof(self) weakSelf = self;
    
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.totalRowCount += 3;
            [weakSelf.tableView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}


- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    
    [refreshFooter addToScrollView:self.tableView];
    
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    
    _refreshFooter = refreshFooter;
}

- (void)footerRefresh
{
    NSLog(@"下拉刷新的回调");
}








