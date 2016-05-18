//
//  DownloadImageOperation.h
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadImageOperation : NSOperation


/**
 *  创建下载图片操作
 *
 *  @param URLString        图片地址
 *  @param downloadFinished 完成执行block
 *
 *  @return 操作
 */
+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString downloadFinished:(void(^)(UIImage *image))downloadFinished;
@end
