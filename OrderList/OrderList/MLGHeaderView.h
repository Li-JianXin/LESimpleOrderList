//
//  MLGHeaderView.h
//  OrderList
//
//  Created by jianxin.li on 16/7/23.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLGLayout;

@protocol MLGHeaderDelegate <NSObject>

@optional
- (void)headerDidClick:(MLGLayout *)layout;
/** 点击物流 */
- (void)headerDidClickLogistics:(MLGLayout *)layout;


@end

@class MLGLayout;
@interface MLGHeaderView : UIView
@property (nonatomic, strong) MLGLayout *layout;
@property (nonatomic, weak) id<MLGHeaderDelegate> delegate;
@end
