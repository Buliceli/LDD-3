//
//  LDDAnimation.h
//  LDD自定义转场练习2
//
//  Created by 李洞洞 on 20/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LDDAnimationType) {
    LDDAnimationTypePresent,
    LDDAnimationTypeDismiss
};
@interface LDDAnimation : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)lddAnimation:(LDDAnimationType)type;
- (instancetype)initWithAnimation:(LDDAnimationType)type;
@end
