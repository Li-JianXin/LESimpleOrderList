//
//  OrderDetailViewController.m
//  OrderList
//
//  Created by jianxin.li on 16/7/25.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "MLGOrderHeaderDef.h"

@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) NSString *orderID;
@end

@implementation OrderDetailViewController

- (instancetype)initWithOrderID:(NSString *)orderID {
    if (self = [super init]) {
        _orderID = orderID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailLabel.text = [NSString stringWithFormat:@"订单ID:%@",self.orderID];
    
}




@end
