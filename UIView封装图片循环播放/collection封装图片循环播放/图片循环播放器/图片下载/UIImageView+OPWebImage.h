//
//  UIImageView+OPWebImage.h
//  用runtime和分类给系统类增加属性
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (OPWebImage)
- (void)setImageWithURLString:(NSString *)URLString ;
@end
