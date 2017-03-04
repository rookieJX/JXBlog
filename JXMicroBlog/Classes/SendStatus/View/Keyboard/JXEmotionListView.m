//
//  JXEmotionListView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//



#import "JXEmotionListView.h"
#import "JXEmotionGridView.h" // 一页的表情


@interface JXEmotionListView ()<UIScrollViewDelegate>
/** 表情键盘 */
@property (nonatomic,weak) UIScrollView * emotionView;
/** 页码 */
@property (nonatomic,weak) UIPageControl * pageControl;
@end

@implementation JXEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *emotionView = [[UIScrollView alloc] init];
        emotionView.showsHorizontalScrollIndicator = NO;
        emotionView.showsVerticalScrollIndicator = NO;
        emotionView.pagingEnabled = YES;
        emotionView.delegate = self;
        emotionView.bounces = NO;
        [self addSubview:emotionView];
        self.emotionView = emotionView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl setValue:[UIImage resizedImage:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage resizedImage:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSInteger totalCounts = (emotions.count + JXEmotionMaxCountPerPage - 1) / JXEmotionMaxCountPerPage;
    
    self.pageControl.numberOfPages = totalCounts;
    self.pageControl.currentPage = 0;
    
    for (NSInteger i=0; i<totalCounts; i++) {
        JXEmotionGridView *gridView = nil;
        NSInteger currentCounts = self.emotionView.subviews.count;
        if (i >= currentCounts) {
            gridView = [[JXEmotionGridView alloc] init];
            [self.emotionView addSubview:gridView];
        } else {
            gridView = self.emotionView.subviews[i];
        }
        
        NSInteger len = JXEmotionMaxCountPerPage;
        NSInteger loc = i * JXEmotionMaxCountPerPage;
        if (loc + len > emotions.count) {
            len = emotions.count - loc;
        }
        NSRange range = NSMakeRange(loc, len);
        gridView.emotions = [emotions subarrayWithRange:range];
        gridView.hidden = NO;
    }
    
    // 隐藏多余控件
    for (NSInteger i=totalCounts; i < self.emotionView.subviews.count; i++) {
        JXEmotionGridView *gridView = self.emotionView.subviews[i];
        gridView.hidden = YES;
    }

    self.emotionView.contentOffset = CGPointZero;
    
    [self setNeedsLayout];

}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageControl.w = self.w;
    self.pageControl.h = 35;
    self.pageControl.y = self.h - self.pageControl.h;
    
    self.emotionView.w = self.w;
    self.emotionView.h = self.pageControl.y;
    
    NSInteger count = self.pageControl.numberOfPages;
    CGFloat w = self.w;
    CGFloat h = self.emotionView.h;
    self.emotionView.contentSize = CGSizeMake(w * count, 0);
    for (NSInteger i=0; i<count; i++) {
        JXEmotionGridView *gridView = self.emotionView.subviews[i];
        gridView.x = i * w;
        gridView.w = w;
        gridView.h = h;
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.w + 0.5;
}
@end
