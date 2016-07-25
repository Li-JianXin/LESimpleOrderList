//
//  H5ViewController.m
//  OrderList
//
//  Created by jianxin.li on 16/7/25.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "H5ViewController.h"

@interface H5ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *htmlUrl;
@end

@implementation H5ViewController

- (instancetype)initWithHtmlUrl:(NSString *)htmlUrl {
    self = [super init];
    if (self) {
        _htmlUrl = htmlUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest
                             requestWithURL:[NSURL URLWithString:self.htmlUrl]
                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                             timeoutInterval:60];
    [self.webView loadRequest:request];
}


@end
