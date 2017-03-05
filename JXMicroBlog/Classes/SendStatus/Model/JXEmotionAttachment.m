//
//  JXEmotionAttachment.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionAttachment.h"

#import "HMEmotion.h"

@implementation JXEmotionAttachment
- (void)setEmotion:(HMEmotion *)emotion {
    _emotion = emotion;
    // 根据表情设置图片
    NSString *imageName = [NSString stringWithFormat:@"%@/%@",emotion.floder,emotion.png];
    self.image = [UIImage imageNamed:imageName];
}
@end
