//
//  MLGOrderListModel.h
//  OrderList
//
//  Created by jianxin.li on 16/7/22.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FloatLayerModule;

@interface MLGOrderListModel : NSObject

@property (nonatomic, strong) NSArray  *orderList;
@property (nonatomic, strong) NSString *orderNoticeMsg;
@property (nonatomic, strong) NSString *orderNoticeUrl;
@property (nonatomic, strong) FloatLayerModule *floatLayerModule;

@end

@interface FloatLayerModule : NSObject

@end


@interface MLGOrderModel : NSObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) NSInteger state; ///< 订单状态
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *orderName; ///< 子订单名字
@property (nonatomic, strong) NSString *stateName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *parentOrderId;
@property (nonatomic, assign) NSInteger isNotNeedToPayOrder;
@property (nonatomic, strong) NSString *orderTips;
@property (nonatomic, assign) NSInteger goodsTotalCount;
@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, strong) NSString *shareRedPaperTitle;
@property (nonatomic, strong) NSString *shareRedPaperDescription;
@property (nonatomic, strong) NSString *shareRedPaperUrl;
@property (nonatomic, strong) NSString *shareRedPaperImg;
@property (nonatomic, strong) NSString *logisticsMsg;
@property (nonatomic, strong) NSString *logisticsTime;
@property (nonatomic, strong) NSString *logisticsUrl;
@property (nonatomic, strong) NSArray *goodsList;
@property (nonatomic, strong) NSArray *childOrderList;

@property (nonatomic, assign) BOOL isShowCommentButton;
@property (nonatomic, assign) BOOL isShowRedPaper;
@property (nonatomic, assign) BOOL isShare;

@end

@interface MLGGoods : NSObject

@property (nonatomic, assign) NSInteger goodsCount;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, strong) NSString *IsGroup;
@property (nonatomic, strong) NSString *goodsImg;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) NSInteger goodsStockDetailId;
@property (nonatomic, assign) NSInteger serviceGoodsSourceType;
@property (nonatomic, strong) NSString *goodsNorm;

@end