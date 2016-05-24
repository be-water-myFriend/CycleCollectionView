//
//  OPView.h
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OPView : UIView
/**
 *  自定义构造方法
 *  @param frame      传入collectionView的frame
 *  @param imageArray 要展示的图片数组
 *  @param block      点击图片后调用会用这个block
 */
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSArray *)imageNames picUrls:(NSArray *)URLStrings selectImageHandle:(void(^)(NSInteger index))process;

/**
 *  PageControl 你可以修改PageControl的样式
 */
@property (nonatomic, strong)UIPageControl *pageCtrl;

/**
 *  播放图片间隔时间
 */
@property (nonatomic, assign)float interval;
@end
