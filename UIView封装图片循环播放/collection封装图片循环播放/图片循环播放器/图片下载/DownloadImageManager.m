//
//  DownloadImageManager.m
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "DownloadImageManager.h"
#import "DownloadImageOperation.h"
#import "NSString+Path.h"
@interface DownloadImageManager ()
/**
 *  下载队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;

/**
 *  操作缓存
 */
@property (nonatomic, strong) NSMutableDictionary *operationCache;

/**
 * 内存缓存
 */
@property (nonatomic, strong) NSMutableDictionary *imageCache;
@end

@implementation DownloadImageManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static DownloadImageManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (void)downloadImageWithURLString:(NSString *)URLString complete:(void (^)(UIImage *))complete {
    
    // 判断字典中是否已经此下载操作
    if ([self.operationCache objectForKey:URLString]) {
        NSLog(@"此连接[%@]正在下载,请等待!", URLString);
        return;
    }
    
    // 在开始下载之前，去判断(内存缓存和沙盒)中是否保存有该连接对应的图片
    if ([self checkCache:URLString]) {
        
        // 读取缓存图片
        UIImage *image = [self.imageCache objectForKey:URLString];
        
        // 执行block
        complete(image);
        
        // 如果有缓存，直接返回，不用再去下载
        return;
    }
    
    // 1. 创建操作
    DownloadImageOperation *op = [DownloadImageOperation downloadImageOperationWithURLString:URLString downloadFinished:^(UIImage *image) {
        // 下载完成移除操作
        [self.operationCache removeObjectForKey:URLString];
        
        // 把下载好的图片保存到内存中
        if (image) {
            [self.imageCache setObject:image forKey:URLString];
        }
        
        // 调用完成回调把图片传回到控制器
        complete(image);
    }];
    
    // 2. 把操作添加到队列中
    [self.queue addOperation:op];
    
    // 把下载操作保存起来
    [self.operationCache setObject:op forKey:URLString];
    
}

- (BOOL)checkCache:(NSString *)URLString {
    // 1. 先判断内存缓存
    if ([self.imageCache objectForKey:URLString]) {
        //NSLog(@"在内存缓存中找到");
        return YES;
    }
    
    // 2. 判断沙盒缓存
    // 2.1 文件路径
    NSString *path = [URLString appendCaches];
    // 2.2 读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    if (image) {
        //NSLog(@"在沙盒缓存找到");
        // 把图片保存到内存中
        [self.imageCache setObject:image forKey:URLString];
        return YES;
    }
    
    return NO;
}

- (void)cancelDownload:(NSString *)URLString {
    // 1. 拿到操作
    [self.operationCache[URLString] cancel];
    // 2. 移除操作
    [self.operationCache removeObjectForKey:URLString];
}

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

- (NSMutableDictionary *)operationCache {
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

- (void)dealloc {
    //NSLog(@"dealloc");
}
@end
