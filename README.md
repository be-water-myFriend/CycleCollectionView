# PicturePlaysCycle
一:功能
1:图片定时循环播放
2:支持占位图片
3:支持网络下载,下载图片器中已实现(图片沙盒缓存+内存缓存),原理类似SDWebImage.
4:支持图片点击事件处理block,可在创建OPView时传入block代码块.
5:由于图片播放器使用的是UICollectionView的cell重用机制完成,所以在播放大量图片时性能表现良好.

二:使用方法
  1>直接将示例demo项目中的"图片循环播放器"文件夹拖入到你的项目
  2>导入必须的头文件  #import "OPView.h"

使用方法如下,具体可参照demo项目:
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
