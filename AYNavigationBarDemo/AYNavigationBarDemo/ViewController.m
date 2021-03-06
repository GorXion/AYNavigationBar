//
//  ViewController.m
//  AYNavigationBarDemo
//
//  Created by gaoX on 2017/12/1.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

#import "UIViewController+AYNavigationBar.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tipLabel];
    
    self.ay_navigation.item.title = @"首页";
    self.ay_navigation.item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBtnAction)];
    
    // remove blur effect
    self.ay_navigation.bar.translucent = NO;
    
    // if you need to set status bar style lightContent
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // if you want change navigation bar position
    self.ay_navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = YES;
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)rightBtnAction
{
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat statusBarHeight = CGRectGetMaxY(UIApplication.sharedApplication.statusBarFrame);
    CGFloat offsetY = -scrollView.contentOffset.y + statusBarHeight;
    CGFloat alpha = 1 - (scrollView.contentOffset.y) / CGRectGetMaxY(self.ay_navigation.bar.frame);
    if (offsetY <= statusBarHeight) {
        CGRect frame = self.ay_navigation.bar.frame;
        CGFloat offset = statusBarHeight - 44;
        BOOL flag = offsetY > offset;
        frame.origin.y = flag ? offsetY : offset;
        self.ay_navigation.bar.frame = frame;
        UIColor *color = [[UIColor blueColor] colorWithAlphaComponent:alpha];
        self.ay_navigation.bar.tintColor = color;
        self.ay_navigation.bar.titleTextAttributes = @{NSForegroundColorAttributeName: color};
    }
    else {
        CGRect frame = self.ay_navigation.bar.frame;
        frame.origin.y = CGRectGetMaxY(UIApplication.sharedApplication.statusBarFrame);
        self.ay_navigation.bar.frame = frame;
        self.ay_navigation.bar.tintColor = [UIColor blueColor];
        self.ay_navigation.bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
    }
}

#pragma mark - getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width + 500);
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _scrollView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
        _tipLabel.center = self.view.center;
        _tipLabel.text = @"上下滑动试试";
    }
    return _tipLabel;
}

@end
