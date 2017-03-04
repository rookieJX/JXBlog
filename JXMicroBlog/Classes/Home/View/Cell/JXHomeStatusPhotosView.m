//
//  JXHomeStatusPhotosView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStatusPhotosView.h"
#import "JXHomeStatusPhotoView.h"
#import "JXPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define JXStatusPhotosMaxCount 9
#define JXStatusPhotoW (kWidth-40)/3
#define JXStatusPhotoH JXStatusPhotoW
#define JXStatusPhotoMargin 10
#define JXStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)

@interface JXHomeStatusPhotosView ()

@end

@implementation JXHomeStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 预先创建9个图片控件
        for (int i = 0; i<JXStatusPhotosMaxCount; i++) {
            JXHomeStatusPhotoView *photoView = [[JXHomeStatusPhotoView alloc] init];
            // 添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [photoView addGestureRecognizer:tap];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)tap:(UIGestureRecognizer *)recognizer {
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photos = [NSMutableArray array];
    for (NSInteger i=0; i<self.pic_urls.count; i++) {
        JXPhoto *photoView = self.pic_urls[i];
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url= [NSURL URLWithString:photoView.tbmiddle_pic];
        mjPhoto.srcImageView = self.subviews[i];
        [photos addObject:mjPhoto];
    }
    
    browser.currentPhotoIndex = recognizer.view.tag;
    browser.photos = photos;
    [browser show];
    
}


+ (CGSize)sizeWithPhotosCount:(NSInteger)count {
    // 单个图片宽度
    CGFloat photoW = JXStatusPhotoW;
    CGFloat photoH = photoW;
    CGFloat photoMargin = 10;
    
    // 列数
    NSInteger maxCols = 3;
    // 总列数
    NSInteger totalCols  = count >=3 ? maxCols : count;
    // 总行数
    NSInteger totalRows = (count + maxCols - 1) / maxCols;
    
    CGFloat photosW = totalCols * photoW + (totalCols - 1) * photoMargin;
    CGFloat photosH = totalRows * photoH + (totalRows - 1) * photoMargin;

    return CGSizeMake(photosW, photosH);
}

- (void)setPic_urls:(NSArray *)pic_urls {
    _pic_urls = pic_urls;
    
    // 显示
    for (NSInteger i=0; i<JXStatusPhotosMaxCount; i++) {
        JXHomeStatusPhotoView *photoView = self.subviews[i];
        if (i<pic_urls.count) {
            photoView.hidden = NO;
            photoView.photo = pic_urls[i];
            photoView.tag = i;
        } else {
            photoView.hidden = YES;
        }
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.pic_urls.count;
    int maxCols = JXStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        JXHomeStatusPhotoView *photoView = self.subviews[i];
        photoView.w = JXStatusPhotoW;
        photoView.h = JXStatusPhotoH;
        photoView.x = (i % maxCols) * (JXStatusPhotoW + JXStatusPhotoMargin);
        photoView.y = (i / maxCols) * (JXStatusPhotoH + JXStatusPhotoMargin);
    }
}

@end
