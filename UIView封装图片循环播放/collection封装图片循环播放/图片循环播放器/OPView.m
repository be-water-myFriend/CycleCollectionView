//
//  OPView.m
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "OPView.h"
#import "OPCollectionViewCell.h"

#define IDENTIFIER @"CollectionViewCell"
@interface OPView()<UICollectionViewDelegate, UICollectionViewDataSource>
/**
 *  点击图片处理
 */
@property (nonatomic, copy) void(^process)(NSInteger index);
/**
 *  占位符图片组
 */
@property (nonatomic, strong)NSArray *imageArray;
/**
 *  图片下载链接url
 */
@property (nonatomic, strong)NSArray *picUrls;


@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIPageControl *pageCtrl;
@property (nonatomic, strong)NSTimer *timer;
@end
@implementation OPView

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSArray *)imageNames picUrls:(NSArray *)URLStrings selectImageHandle:(void(^)(NSInteger index))process
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        //保存数据
        self.process = process;
        self.imageArray = imageNames;
        self.picUrls = URLStrings;
        
        //检查数据
        if( self.picUrls )
        {
            NSAssert(self.imageArray.count == self.picUrls.count, @"如果需要从网络下载图片,请确保url数量和占位符图片数量一致!");
        }
        
        //创建添加collectionView
        [self addSubview:self.collectionView];
        
        //先滚动到第1组(中间组)
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        //创建页码
        [self addSubview:self.pageCtrl];
        [self addTimer];
    }
    return self;
}

#pragma mark - CollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //固定3个组
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //每组cell个数
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath];
    cell.imageName = self.imageArray[indexPath.row];
    cell.URLString = self.picUrls[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.process(indexPath.row);
}

#pragma maek - scrollView 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 计算第几页
    NSInteger index = offsetX / CGRectGetWidth(scrollView.frame);
    
    // 计算第几组
    NSInteger section = index / self.imageArray.count;
    
    // 计算item
    NSInteger item = index % self.imageArray.count;
    
    // 判断已经到第一组或者是最后一组
    if( (item==self.imageArray.count) || (item==0) )
    {
        if ( section == 0 || section == 2 )
        {
            // 滚动到第一组
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:1] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
    
    //设置页码器值
    self.pageCtrl.currentPage = item;
}

#pragma mark - 定时器操作
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage
{
    NSIndexPath *currentPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    //计算下一个位置
    NSInteger nextRow = currentPath.row + 1;
    NSInteger nextSection = currentPath.section;
    
    //滚动溢出时需要设置Row和Section
    if (nextRow == self.imageArray.count)
    {
        nextRow = 0;
        if( nextSection == 2 )
        {
            nextSection = 1;
        }
        else
        {
            nextSection++;
        }
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextRow inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 懒加载collectionView 和 pageCtrl
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        //设置流水布局属性
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.itemSize = self.frame.size;
        
        //创建CollectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册自定义cell类
        [_collectionView registerClass:[OPCollectionViewCell class] forCellWithReuseIdentifier:IDENTIFIER];
    }
    return _collectionView;
}

- (UIPageControl *)pageCtrl
{
    if (!_pageCtrl) {
        
        //设置frame
        CGFloat x = (self.frame.size.width - 100) * 0.5f;
        CGFloat y = self.frame.size.height - 40;
        CGFloat w = 100;
        CGFloat h = 20;
        
        //创建PageControl
        _pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _pageCtrl.numberOfPages = [self.imageArray count];
        _pageCtrl.currentPage = 0;
        _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageCtrl.pageIndicatorTintColor = [UIColor yellowColor];
    }
    return _pageCtrl;
}

@end
