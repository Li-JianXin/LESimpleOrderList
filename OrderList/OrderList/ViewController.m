//
//  ViewController.m
//  OrderList
//
//  Created by jianxin.li on 16/7/22.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ViewController.h"
#import "MLGOrderHeaderDef.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MLGHeaderDelegate,MLGFooterDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *layouts;
@property (nonatomic, strong) MLGOrderListModel *orderListModel;

@end

@implementation ViewController

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (NSMutableArray *)layouts {
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            [idleImages addObject:image];
        }
        [header setImages:idleImages forState:MJRefreshStateIdle];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [refreshingImages addObject:image];
        }
        [header setImages:refreshingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        
        _tableView.mj_header = header;
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __weak UITableView *tableView = self.tableView;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tableView reloadData];
                [tableView.mj_footer endRefreshing];
            });
        }];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OrderList" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.orderListModel = [MLGOrderListModel modelWithJSON:[dataDict objectForKey:@"msg"]];
    
    /*
    for (MLGOrderModel *orderModel in self.orderListModel.orderList) {
        MLGLayout *layout = [[MLGLayout alloc] initWithOrderModel:orderModel orderCategory:2 index:1];
        [layout layout];
        [self.layouts addObject:layout];
    }
     */
    __block NSUInteger totalIdx = 0;
    [self.orderListModel.orderList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MLGOrderModel *orderModel = (MLGOrderModel *)obj;
        if (orderModel.childOrderList.count != 0) {
            [orderModel.childOrderList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger childIdx, BOOL * _Nonnull stop) {
                MLGLayout *layout = [[MLGLayout alloc] initWithOrderModel:(MLGOrderModel *)obj orderCategory:childIdx index:totalIdx];
                [layout layout];
                [self.layouts addObject:layout];
                totalIdx++;
            }];
        } else {
            MLGLayout *layout = [[MLGLayout alloc] initWithOrderModel:(MLGOrderModel *)obj orderCategory:idx index:totalIdx];
            [layout layout];
            [self.layouts addObject:layout];
            totalIdx++;
        }
     
    }];
    
    self.tableView.backgroundColor = RGBColor(246, 246, 246, 1);
    
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.layouts.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((MLGLayout *)self.layouts[section]).skus;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLGOrderListCell *cell = [MLGOrderListCell cellWithTableView:tableView];
    MLGOrderModel *orderModel = ((MLGLayout *)self.layouts[indexPath.section]).orderModel;
    MLGGoods *goods = orderModel.goodsList[indexPath.row];
    [cell setGoods:goods];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ((MLGLayout *)self.layouts[section]).headerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MLGHeaderView *header = [[MLGHeaderView alloc] init];
    header.delegate = self;
    [header setLayout:((MLGLayout *)self.layouts[section])];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ((MLGLayout *)self.layouts[section]).footerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MLGFooterView *footer = [[MLGFooterView alloc] init];
    footer.delegate = self;
    [footer setLayout:((MLGLayout *)self.layouts[section])];
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailViewController *orderDetailVc = [[OrderDetailViewController alloc] initWithOrderID:((MLGLayout *)self.layouts[indexPath.section]).orderModel.orderId];
   // [orderDetailVc setLayout:((MLGLayout *)self.layouts[indexPath.section])];
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

#pragma mark - <MLGHeaderDelegate>
- (void)headerDidClick:(MLGLayout *)layout {
    
}
- (void)headerDidClickLogistics:(MLGLayout *)layout {
    H5ViewController *h5Vc = [[H5ViewController alloc] initWithHtmlUrl:layout.orderModel.logisticsUrl];
    [self.navigationController pushViewController:h5Vc animated:YES];
}

#pragma mark - <MLGFooterDelegate>
- (void)footerDidClick:(MLGLayout *)layout {
    NSLog(@"点击Footer");
}

- (void)footerDidClickBuyAgain:(MLGLayout *)layout {
    NSLog(@"再下一单 %@",layout.orderModel.orderId);
}

- (void)footerDidClickCommentOrder:(MLGLayout *)layout {
    NSLog(@"点评晒单 %@",layout.orderModel.orderId);
}

- (void)footerDidClickDeleteOrder:(MLGLayout *)layout {
    NSLog(@"删除订单 %@",layout.orderModel.orderId);
}

- (void)footerDidClickSendRedEnvelope:(MLGLayout *)layout {
    NSLog(@"发红包 %@",layout.orderModel.orderId);
}

#pragma mark - 下拉
- (void)loadNewData {
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    });

}


@end
