//
//  JXEmotionView.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/2.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMEmotion;

@interface JXEmotionView : UIButton
/** 表情模型 */
@property (nonatomic,strong) HMEmotion * emotion;
@end
