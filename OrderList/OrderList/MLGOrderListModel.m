//
//  MLGOrderListModel.m
//  OrderList
//
//  Created by jianxin.li on 16/7/22.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "MLGOrderListModel.h"

@implementation MLGOrderListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderList" : [MLGOrderModel class]};
}

@end


@implementation FloatLayerModule

@end

@implementation MLGOrderModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goodsList" : [MLGGoods class],
             @"childOrderList" : [MLGOrderModel class]};
}

@end

@implementation MLGGoods


@end