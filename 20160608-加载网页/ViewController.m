//
//  ViewController.m
//  20160608-加载网页
//
//  Created by devzkn on 6/8/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rewindItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (nonatomic,weak) UIWebView *webView;
@end

@implementation ViewController

- (UIWebView *)webView{
    if (nil == _webView) {
       UIWebView *tmpWebView = [[UIWebView alloc]init];
        CGRect frame = self.view.bounds;
        frame.origin.y = 64;
        tmpWebView.frame = frame;
        tmpWebView.delegate = self;
        _webView = tmpWebView;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载请求
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"login" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}
- (IBAction)rewindAction:(id)sender {
    NSLog(@"%s",__func__);
    [self.webView goBack];
}

- (IBAction)forwardAction:(UIBarButtonItem *)sender {
    NSLog(@"%s",__func__);
    [self.webView goForward];
}

/** 
 作用：Sent before a web view begins loading a frame. 一般用于拦截webView发出的所有请求
 1.navigationType： The type of user action that started the load request.
 typedef NS_ENUM(NSInteger, UIWebViewNavigationType) {
 UIWebViewNavigationTypeLinkClicked, －－点击连接
 UIWebViewNavigationTypeFormSubmitted,
 UIWebViewNavigationTypeBackForward,－－goBack 或者goForward
 UIWebViewNavigationTypeReload,
 UIWebViewNavigationTypeFormResubmitted,
 UIWebViewNavigationTypeOther
 } __TVOS_PROHIBITED;
 2、YES true if the web view should begin loading content 允许发送这个请求; otherwise, NOfalse .
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%s－－－－－navigationType：%ld    －－－request：%@",__func__,(long)navigationType,request);
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"%s",__func__);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"%s",__func__);
    if ([webView canGoBack]) {
        [self.rewindItem setEnabled:YES];
    }else{
        [self.rewindItem setEnabled:NO];
    }
    if ([webView canGoForward]) {
        [self.forwardItem setEnabled:YES];
    }else{
        [self.forwardItem setEnabled:NO];
    }
}
- (void)webView:(UIWebView *)webView{
    NSLog(@"%s",__func__);
    
}


@end
