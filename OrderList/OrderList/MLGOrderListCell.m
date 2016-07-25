//
//  MLGOrderListCell.m
//  OrderList
//
//  Created by jianxin.li on 16/7/22.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "MLGOrderListCell.h"
#import "MLGOrderHeaderDef.h"

@interface MLGOrderListCell ()

@property (nonatomic, strong) UIImageView *goodImageView;
@property (nonatomic, strong) UILabel *goodNameLabel;
@property (nonatomic, strong) UILabel *goodNumberLabel;
@property (nonatomic, strong) UILabel *goodPriceLabel;

@end

@implementation MLGOrderListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *Identifier = @"Identifier";
    MLGOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[MLGOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.goodImageView = [UIImageView new];
    [self.contentView addSubview:self.goodImageView];
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(66);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
        make.top.mas_offset(10);
    }];
    
    self.goodNameLabel = [UILabel new];
    self.goodNameLabel.numberOfLines = 2;
    self.goodNameLabel.lineBreakMode = NSLineBreakByClipping;
    self.goodNameLabel.font = [UIFont systemFontOfSize:14.0f];
    self.goodNameLabel.textColor = RGBColor(34, 34, 34, 1);
    [self.contentView addSubview:self.goodNameLabel];
    [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.goodImageView);
    }];
    
    self.goodPriceLabel = [UILabel new];
    self.goodPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    self.goodPriceLabel.textColor = RGBColor(34, 34, 34, 1);
    [self.contentView addSubview:self.goodPriceLabel];
    [self.goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-7);
        make.left.mas_equalTo(self.goodNameLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(60);
    }];
    
    self.goodNumberLabel = [UILabel new];
    self.goodNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    self.goodNumberLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.goodNumberLabel];
    [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodNameLabel);
        make.top.mas_equalTo(self.goodNameLabel.mas_bottom).offset(5);
    }];
}

- (void)setGoods:(MLGGoods *)goods {
    _goods = goods;
    
    [self.goodImageView setImageWithURL:[NSURL URLWithString:goods.goodsImg] options:YYWebImageOptionProgressive];
    self.goodNameLabel.text  = goods.goodsName;
    self.goodPriceLabel.text = [@"¥" stringByAppendingString:goods.price];
    self.goodNumberLabel.text = [NSString stringWithFormat:@"X %zd",goods.goodsCount];
}

@end
