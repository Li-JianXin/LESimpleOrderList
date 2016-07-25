//
//  MLGLayout.m
//  OrderList
//
//  Created by jianxin.li on 16/7/23.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "MLGLayout.h"

@interface MLGLayout ()

/** Header子控件高度 */
@property (nonatomic, assign) CGFloat height_remind;
@property (nonatomic, assign) CGFloat height_status;
@property (nonatomic, assign) CGFloat height_logistics;
/** Footer 子控件高度 */
@property (nonatomic, assign) CGFloat height_summary;
@property (nonatomic, assign) CGFloat height_bottom;
@end

@implementation MLGLayout

- (instancetype)initWithOrderModel:(MLGOrderModel *)orderModel orderCategory:(NSUInteger)orderCategory{
    if (!orderModel) return nil;
    self = [super init];
    if (self) {
        _orderModel = orderModel;
        _orderCategory = orderCategory;
        [self layout];
    }
    return self;
}

- (void)layout {
    self.orderState = self.orderModel.state;
    
    if (self.orderModel.orderTips && self.orderModel.orderTips.length != 0) {
        self.height_remind = HEIGHT_REMIND;
        self.hiddenRemind = NO;
    } else {
        self.height_remind = 0.0f;
        self.hiddenRemind = YES;
    }
    
    self.height_status = HEIGHT_STATUS;
    
    if (self.orderModel.logisticsMsg && self.orderModel.logisticsMsg.length != 0 && (self.orderModel.state == 23 || self.orderModel.state == 26 || self.orderModel.state ==  30 || self.orderModel.state == 20 || self.orderModel.state == 21 || self.orderModel.state == 22)) {
        self.height_logistics = HEIGHT_LOGISTICS;
        self.hiddenLogistics = NO;
    }
    else {
        self.height_logistics = 0.0f;
        self.hiddenLogistics = YES;
    }
    
    self.headerHeight = self.height_remind + self.height_status + self.height_logistics;
    
    if (self.orderCategory == 3) {
        self.height_summary = HEIGHT_SUMMARY;
        self.height_bottom  = HEIGHT_BOTTOM;
        self.hiddenBottom   = NO;
    } else {
        self.height_summary = HEIGHT_SUMMARY;
        self.height_bottom  = 0.0f;
        self.hiddenBottom   = YES;
    }
    self.footerHeight = self.height_summary + self.height_bottom;
    
   
    
}

@end
