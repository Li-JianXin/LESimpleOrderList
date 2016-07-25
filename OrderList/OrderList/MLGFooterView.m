//
//  MLGFooterView.m
//  OrderList
//
//  Created by jianxin.li on 16/7/23.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "MLGFooterView.h"
#import "MLGOrderHeaderDef.h"

@interface MLGFooterView ()

@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIView  *bottomView;
@property (nonatomic, strong) UIButton *buyAgainBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) MLGOrderModel *orderModel;

@end

@implementation MLGFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.summaryLabel = [UILabel new];
    self.summaryLabel.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:self.summaryLabel];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(2);
        make.right.mas_offset(-5);
        make.height.mas_equalTo(HEIGHT_SUMMARY);
    }];
    
    self.bottomView = [UIView new];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.summaryLabel.mas_bottom);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(HEIGHT_BOTTOM);
    }];
    
    self.buyAgainBtn = [UIButton new];
    self.buyAgainBtn.tag = 1;
    [self.buyAgainBtn setTitle:@"再下一单" forState:UIControlStateNormal];
    [self setButtonStyle:self.buyAgainBtn];
    [self.bottomView addSubview:self.buyAgainBtn];
    [self.buyAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView).offset(0);
        make.right.mas_offset(-5);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(25);
    }];
    
    self.commentBtn = [UIButton new];
    self.commentBtn.tag = 2;
    [self.commentBtn setTitle:@"点评晒单" forState:UIControlStateNormal];
    [self setButtonStyle:self.commentBtn];
    [self.bottomView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.buyAgainBtn.mas_left).offset(-10);
        make.top.mas_equalTo(self.buyAgainBtn.mas_top);
        make.size.mas_equalTo(self.buyAgainBtn);
    }];
    
    self.deleteBtn = [UIButton new];
    self.deleteBtn.tag = 3;
    [self.deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [self setButtonStyle:self.deleteBtn];
    [self.bottomView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.commentBtn.mas_left).offset(-10);
        make.top.mas_equalTo(self.buyAgainBtn.mas_top);
        make.size.mas_equalTo(self.buyAgainBtn);
    }];
    
    self.shareBtn = [UIButton new];
    self.shareBtn.tag = 4;
    [self.shareBtn setTitle:@"发红包" forState:UIControlStateNormal];
    [self setButtonStyle:self.shareBtn];
    [self.bottomView addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.deleteBtn.mas_left).offset(-10);
        make.top.mas_equalTo(self.buyAgainBtn.mas_top);
        make.size.mas_equalTo(self.buyAgainBtn);
    }];
}

- (void)setButtonStyle:(UIButton *)button {
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.layer.cornerRadius = 4.0f;
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setLayout:(MLGLayout *)layout {
    _layout = layout;
    _orderModel = layout.orderModel;
    
    if (layout.orderCategory == 3) {
        self.bottomView.hidden = NO;
    } else {
        self.bottomView.hidden = YES;
    }
    
    NSString *summaryString = [NSString stringWithFormat:@"共%ld件, 实付: ¥%@",_orderModel.goodsList.count, _orderModel.total];
    NSDictionary *summary_attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};
    NSMutableAttributedString *summary_as = [[NSMutableAttributedString alloc] initWithString:summaryString attributes:summary_attrs];
    [summary_as addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[summaryString rangeOfString:[@"¥" stringByAppendingString:_orderModel.total]]];
    [summary_as addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[summaryString rangeOfString:[@"¥" stringByAppendingString:_orderModel.total]]];
    self.summaryLabel.attributedText = summary_as;
    
  
}

- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(footerDidClickBuyAgain:)]) {
                [self.delegate footerDidClickBuyAgain:self.layout];
            }
        }
            break;
        case 2:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(footerDidClickCommentOrder:)]) {
                [self.delegate footerDidClickCommentOrder:self.layout];
            }
        }
            break;
        case 3:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(footerDidClickDeleteOrder:)]) {
                [self.delegate footerDidClickDeleteOrder:self.layout];
            }
        }
            break;
        case 4:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(footerDidClickSendRedEnvelope:)]) {
                [self.delegate footerDidClickSendRedEnvelope:self.layout];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
