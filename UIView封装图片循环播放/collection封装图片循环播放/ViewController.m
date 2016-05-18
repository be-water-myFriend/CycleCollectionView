//
//  ViewController.m
//  collection封装图片循环播放
//
//  Created by 周颖 on 16/5/11.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "ViewController.h"
#import "OPView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //占位图片组
    NSArray *images = @[@"Snip20160511_7",@"Snip20160511_8",@"Snip20160511_9",@"Snip20160511_10",@"Snip20160511_11"];
    
    //要显示的图片下载链接
    NSArray *urls = @[
                      @"http://eimg.smzdm.com/201605/17/573b15eb463445149.png",
                      @"http://eimg.smzdm.com/201605/17/573aec361b4df1149.jpg",
                      @"http://eimg.smzdm.com/201605/17/573aebe95cb3b5329.png",
                      @"http://eimg.smzdm.com/201605/17/573b165983aa63667.png",
                      @"http://eimg.smzdm.com/201605/16/5739ae8a13bdf8919.png"
                      ];
    //图片播放器的frame大小
    CGRect frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
    
    //调用构造方法生成图片播放器
    OPView *view = [[OPView alloc]initWithFrame:frame placeholder:images picUrls:urls selectImageHandle:^(NSInteger index) {
        NSLog(@"拖拽的是第%zd图片",index);
    }];

    [self.view addSubview:view];
}

@end
