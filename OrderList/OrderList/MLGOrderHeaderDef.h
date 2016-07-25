//
//  MLGOrderHeaderDef.h
//  OrderList
//
//  Created by jianxin.li on 16/7/23.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#ifndef MLGOrderHeaderDef_h
#define MLGOrderHeaderDef_h

#import <YYKit.h>
#import <Masonry.h>

#import "MLGOrderListCell.h"

#import "MLGFooterView.h"
#import "MLGHeaderView.h"

#import "MLGOrderListModel.h"

#import "MLGLayout.h"

#import "H5ViewController.h"
#import "OrderDetailViewController.h"

#define HEIGHT_Space 10.0f
#define HEIGHT_REMIND 30.0f
#define HEIGHT_STATUS 30.0f
#define HEIGHT_LOGISTICS 40.0f
#define HEIGHT_SUMMARY 30.0f
#define HEIGHT_BOTTOM 30.0f

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]


#endif /* MLGOrderHeaderDef_h */
