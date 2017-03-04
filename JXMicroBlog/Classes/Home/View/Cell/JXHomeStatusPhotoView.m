//
//  JXHomeStatusPhotoView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStatusPhotoView.h"
#import "JXPhoto.h"

@interface JXHomeStatusPhotoView ()
/** gif图片 */
@property (nonatomic,weak) UIImageView * gifImageView;
@end

@implementation JXHomeStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        UIImageView *gifImageView = [[UIImageView alloc] init];
        gifImageView.image = [UIImage imageNamed:@"timeline_image_gif"];
        [self addSubview:gifImageView];
        self.gifImageView = gifImageView;
    }
    return self;
}

- (void)setPhoto:(JXPhoto *)photo {
    _photo = photo;
    
    NSURL *url = [NSURL URLWithString:photo.thumbnail_pic];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifImageView.hidden = ![extension isEqualToString:@"gif"];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gifImageView.frame = CGRectMake(self.w-27, self.h-20, 27, 20);
}
@end
