//
//  DownloadImageManager.h
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadImageManager : NSObject
+ (instancetype)sharedManager;

/**
 *  下载图片
 *
 *  @param URLString 图片URL
 *  @param complete  完成回调
 */
- (void)downloadImageWithURLString:(NSString *)URLString complete:(void(^)(UIImage *image))complete;

/**
 *  取消某一个图片的下载
 *
 *  @param URLString 图片地址
 */
- (void)cancelDownload:(NSString *)URLString;
@end
