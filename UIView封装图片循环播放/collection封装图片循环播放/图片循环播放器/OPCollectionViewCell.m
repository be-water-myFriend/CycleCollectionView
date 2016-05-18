//
//  OPCollectionViewCell.m
//  图片循环播放
//
//  Created by 周颖 on 16/5/8.
//  Copyright © 2016年 周颖. All rights reserved.
//

#import "OPCollectionViewCell.h"
#import "UIImageView+OPWebImage.h"

@interface OPCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation OPCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        
        self.imageView.frame = self.bounds;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}

-(void)setURLString:(NSString *)URLString
{
    _URLString = URLString;
    //开始下载
    if( URLString )
    {
        [self.imageView setImageWithURLString:URLString];
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
