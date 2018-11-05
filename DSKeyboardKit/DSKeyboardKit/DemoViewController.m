//
//  DemoViewController.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/24.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import "DemoViewController.h"
#import "UIView+DSCategory.h"
#import "DSPageControl.h"

@interface DemoViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:self.tableView];
//
//    DSChatKeyboardConfig *config = [DSChatKeyboardConfig config];
//    DSChatKeyboardView *chatKeyboard = [[DSChatKeyboardView alloc] initWithFrame:CGRectMake(0, self.view.height - 54.5, self.view.width, 54.5) config:config];
//    chatKeyboard.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    [chatKeyboard refreshStatus:DSInputToolStatusText];
//
//
//
//    [self.view addSubview:chatKeyboard];
//    self.tableView.height -= chatKeyboard.toolView.height;

    
    DSPageControl *pageControl = [[DSPageControl alloc] initWithFrame:CGRectMake(0, 300, self.view.width, 40)];
    pageControl.pageCount = 28;
    pageControl.backgroundColor = [UIColor blackColor];
    [self.view addSubview:pageControl];
}



@end
