//
//  DownloadImageOperation.m
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "DownloadImageOperation.h"
#import "NSString+Path.h"
@interface DownloadImageOperation ()
/**
 *  下载图片的URL
 */
@property (nonatomic, copy) NSString *URLString;


/**
 *  下载完成要执行的block
 */
@property (nonatomic, copy) void (^downloadFinished)(UIImage *image);
@end
@implementation DownloadImageOperation

+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString downloadFinished:(void (^)(UIImage *))downloadFinished {
    
    // 断言 - 预先判断是否符合某个条件
    NSAssert(downloadFinished != nil, @"下载完成执行的block不能为nil");
    
    // 1. 创建操作
    DownloadImageOperation *download = [[self alloc]init];
    
    //2. 保存数据值
    download.URLString = URLString;
    download.downloadFinished = downloadFinished;
    
    return download;
}

// 入口，操作入口、线程入口
- (void)main {
    @autoreleasepool {
        // 1. 把URLString 转成NSURL
        NSURL *url = [NSURL URLWithString:self.URLString];
        
        // 2. 接收二进制数据
        NSData *data = [NSData dataWithContentsOfURL:url];

        // 判断是否有二进制数据,把二进制写入到沙盒
        if (data) {
            [data writeToFile:[self.URLString appendCaches] atomically:YES];
        }
        
        if (self.isCancelled) {
            NSLog(@"取消下载");
            return;
        }
        
        // 3. 把二进制转换成图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.downloadFinished(image);
            
        }];
    }
}

@end
