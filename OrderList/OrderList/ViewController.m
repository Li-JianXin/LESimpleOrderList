//
//  ViewController.m
//  OrderList
//
//  Created by jianxin.li on 16/7/22.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ViewController.h"
#import "MLGOrderHeaderDef.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

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
                MLGLayout *layout = [[MLGLayout alloc] initWithOrderModel:(MLGOrderModel *)obj orderCategory:2 index:totalIdx];
                [layout layout];
                [self.layouts addObject:layout];
                totalIdx++;
            }];
        } else {
            MLGLayout *layout = [[MLGLayout alloc] initWithOrderModel:(MLGOrderModel *)obj orderCategory:2 index:totalIdx];
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
    [header setLayout:((MLGLayout *)self.layouts[section])];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ((MLGLayout *)self.layouts[section]).footerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MLGFooterView *footer = [[MLGFooterView alloc] init];
    [footer setLayout:((MLGLayout *)self.layouts[section])];
    return footer;
}


@end
