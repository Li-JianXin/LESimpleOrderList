//
//  MLGHeaderView.m
//  OrderList
//
//  Created by jianxin.li on 16/7/23.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "MLGHeaderView.h"
#import "MLGOrderHeaderDef.h"

@interface MLGHeaderView ()

@property (nonatomic, strong) UIView *topSpace;
@property (nonatomic, strong) UIView *topSpaceLine;
@property (nonatomic, strong) UIView *bottomSpaceLine;
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, strong) UIView *remindLine;
@property (nonatomic, strong) UIView *statusView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *statusLine;
@property (nonatomic, strong) UIView *logisticsView;
@property (nonatomic, strong) UILabel *logisticsAboutLabel;
@property (nonatomic, strong) UILabel *logisticsDateLabel;
@property (nonatomic, strong) UIImageView *logisticsArrow;
@property (nonatomic, strong) UIView *logisticsLine;

@property (nonatomic, strong) MLGOrderModel *orderModel;

@end

@implementation MLGHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.topSpace = [UIView new];
    self.topSpace.backgroundColor = RGBColor(246, 246, 246, 1);
    [self addSubview:self.topSpace];
    [self.topSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(HEIGHT_Space);
    }];
    
    self.topSpaceLine = [UIView new];
    self.topSpaceLine.backgroundColor = RGBColor(221, 221, 221, 1);
    [self.topSpace addSubview:self.topSpaceLine];
    [self.topSpaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.topSpace.mas_top).offset((1 / [UIScreen mainScreen].scale));
        make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
    }];
    
    self.bottomSpaceLine = [UIView new];
    self.bottomSpaceLine.backgroundColor = RGBColor(221, 221, 221, 1);
    [self.topSpace addSubview:self.bottomSpaceLine];
    [self.bottomSpaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.topSpace.mas_bottom).offset(-(1 / [UIScreen mainScreen].scale));
        make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
    }];
    
    self.remindLabel = [UILabel new];
    self.remindLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:self.remindLabel];
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topSpace.mas_bottom);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(HEIGHT_REMIND);
    }];
    
    self.remindLine = [UIView new];
    self.remindLine.backgroundColor = RGBColor(221, 221, 221, 1);
    [self.remindLabel addSubview:self.remindLine];
    [self.remindLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.remindLabel.mas_bottom).offset(-1);
        make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
    }];
    
    self.statusView = [UIView new];
    [self addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.remindLabel.mas_bottom);
        make.height.mas_equalTo(HEIGHT_STATUS);
    }];
    
    self.dateLabel = [UILabel new];
    self.dateLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.statusView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView).offset(10);
        make.centerY.mas_equalTo(self.statusView.mas_centerY);
    }];
    
    self.statusLabel = [UILabel new];
    self.statusLabel.font = [UIFont systemFontOfSize:13.0f];
    self.statusLabel.textColor = [UIColor redColor];
    [self.statusView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.statusView).offset(-5);
        make.centerY.mas_equalTo(self.statusView.mas_centerY);
    }];
    
    self.statusLine = [UIView new];
    self.statusLine.backgroundColor = RGBColor(221, 221, 221, 1);
    [self.statusView addSubview:self.statusLine];
    [self.statusLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.statusView.mas_bottom).offset(-1);
        make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
    }];
    
    self.logisticsView = [UIView new];
    [self addSubview:self.logisticsView];
    [self.logisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(HEIGHT_LOGISTICS);
        make.top.mas_equalTo(self.statusView.mas_bottom);
    }];
    
    self.logisticsAboutLabel = [UILabel new];
    self.logisticsAboutLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.logisticsView addSubview:self.logisticsAboutLabel];
    [self.logisticsAboutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logisticsView).offset(30);
        make.top.mas_equalTo(self.logisticsView).offset(5);
    }];
    
    self.logisticsDateLabel = [UILabel new];
    self.logisticsDateLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.logisticsView addSubview:self.logisticsDateLabel];
    [self.logisticsDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logisticsAboutLabel);
        make.top.mas_equalTo(self.logisticsAboutLabel.mas_bottom).offset(3);
    }];
    
    self.logisticsArrow = [UIImageView new];
    self.logisticsArrow.image = [UIImage imageNamed:@"MHArrowRight"];
    [self.logisticsView addSubview:self.logisticsArrow];
    [self.logisticsArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.right.mas_offset(-10);
        make.centerY.mas_equalTo(self.logisticsView);
    }];
    
    self.logisticsLine = [UIView new];
    self.logisticsLine.backgroundColor = RGBColor(221, 221, 221, 1);
    [self.logisticsView addSubview:self.logisticsLine];
    [self.logisticsLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.logisticsView.mas_bottom).offset(-1);
        make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
    }];
}


- (void)setLayout:(MLGLayout *)layout {
    _layout = layout;
    _orderModel = layout.orderModel;
    
    self.remindLabel.text = self.orderModel.orderTips;
    self.dateLabel.text = self.orderModel.createTime;
    self.statusLabel.text = self.orderModel.stateName;
    self.logisticsAboutLabel.text = self.orderModel.logisticsMsg;
    self.logisticsDateLabel.text  = self.orderModel.logisticsTime;
    
    self.topSpace.hidden = layout.isHiddenSpace;
    self.remindLabel.hidden = layout.isHiddenRemind;
    self.logisticsView.hidden = layout.hiddenLogistics;
    
    self.statusLine.hidden = layout.isHiddenStatusLine;
    self.logisticsLine.hidden = layout.isHiddenLogisticsLine;
    
    if (self.topSpace.hidden) {
        [self.topSpace mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        [self.topSpace mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HEIGHT_Space);
        }];
    }
    
    if (self.remindLabel.hidden) {
        [self.remindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        [self.remindLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HEIGHT_REMIND);
        }];
    }
        
}

@end
