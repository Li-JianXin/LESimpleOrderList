//
//  MLGOrderListCell.h
//  OrderList
//
//  Created by jianxin.li on 16/7/22.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLGOrderListModel.h"

@interface MLGOrderListCell : UITableViewCell
@property (nonatomic, strong) MLGOrderListModel *orderListModel;
@property (nonatomic, strong) MLGGoods *goods;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
