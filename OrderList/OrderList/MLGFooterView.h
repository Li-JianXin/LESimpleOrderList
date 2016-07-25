//
//  MLGFooterView.h
//  OrderList
//
//  Created by jianxin.li on 16/7/23.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLGLayout;

@protocol MLGFooterDelegate <NSObject>

@optional
- (void)footerDidClick:(MLGLayout *)layout;
- (void)footerDidClickSendRedEnvelope:(MLGLayout *)layout;
- (void)footerDidClickDeleteOrder:(MLGLayout *)layout;
- (void)footerDidClickCommentOrder:(MLGLayout *)layout;
- (void)footerDidClickBuyAgain:(MLGLayout *)layout;

@end


@interface MLGFooterView : UIView
@property (nonatomic, strong) MLGLayout *layout;
@property (nonatomic, weak) id<MLGFooterDelegate> delegate;
@end
