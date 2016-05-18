//
//  UIImageView+OPWebImage.m
//  用runtime和分类给系统类增加属性
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "UIImageView+OPWebImage.h"
#import "DownloadImageManager.h"
#import <objc/runtime.h>
#define HMCurrentURLStringKey @"currentURLString"
@interface UIImageView()
@property (nonatomic, copy) NSString *currentURLString;
@end

@implementation UIImageView (OPWebImage)

- (void)setImageWithURLString:(NSString *)URLString {
    
    // 如果新的url请求不同于上次,则需要取消上次的下载
    if (![URLString isEqualToString:self.currentURLString] && self.currentURLString) {
        [[DownloadImageManager sharedManager] cancelDownload:self.currentURLString];
    }
    
    // 调用下载管理器
    [[DownloadImageManager sharedManager] downloadImageWithURLString:URLString complete:^(UIImage *image) {
        if( image )
        {
            self.image = image;
        }
    }];
    
    // 记录正在下载的urlString
    self.currentURLString = URLString;
}

//属性的set方法
- (void)setCurrentURLString:(NSString *)currentURLString {
    objc_setAssociatedObject(self, HMCurrentURLStringKey, currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
//属性的get方法
- (NSString *)currentURLString {
    return objc_getAssociatedObject(self, HMCurrentURLStringKey);
}

@end
