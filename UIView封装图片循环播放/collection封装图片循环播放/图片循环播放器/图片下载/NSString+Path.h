//
//  NSString+Path.h
//  沙盒路径
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
- (NSString *)appendCaches;
- (NSString *)appendDocuments;
- (NSString *)appendTmp;

@end
