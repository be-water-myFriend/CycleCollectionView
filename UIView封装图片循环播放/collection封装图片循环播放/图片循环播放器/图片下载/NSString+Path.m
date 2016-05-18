//
//  NSString+Path.m
//  沙盒路径
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

//返回-缓存路径字符串
- (NSString *)appendCaches {
    // 获取缓存目录
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 获取路径的最后一部份(文件名)
    NSString *filename = [self lastPathComponent];
    
    return [cache stringByAppendingPathComponent:filename];
}

//返回-Documents路径字符串
- (NSString *)appendDocuments {
    // 获取缓存目录
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 获取路径的最后一部份(文件名)
    NSString *filename = [self lastPathComponent];
    
    return [document stringByAppendingPathComponent:filename];
}

//返回-tmp路径字符串
- (NSString *)appendTmp {
    // 获取缓存目录
    NSString *temp = NSTemporaryDirectory();
    // 获取路径的最后一部份(文件名)
    NSString *filename = [self lastPathComponent];
    
    return [temp stringByAppendingPathComponent:filename];
}
@end
