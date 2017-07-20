//
//  LDDAnimation.m
//  LDD自定义转场练习2
//
//  Created by 李洞洞 on 20/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDDAnimation.h"
#import "UIView+Extension.h"
#import "ViewController.h"
#import "SecController.h"

@interface LDDAnimation ()
@property(nonatomic,assign)LDDAnimationType type;
@end
@implementation LDDAnimation
+ (instancetype)lddAnimation:(LDDAnimationType)type
{
    return [[self alloc]initWithAnimation:type];
}
- (instancetype)initWithAnimation:(LDDAnimationType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case LDDAnimationTypePresent:
        {
            [self doPresentAnimataion:transitionContext];
        }
            break;
        case LDDAnimationTypeDismiss:
         {
             [self doDismissAnimataion:transitionContext];
         }
           break;
        default:
            break;
    }
}
- (void)doPresentAnimataion:(id <UIViewControllerContextTransitioning>)transitionContext
 {
#if 0
     ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
     SecController *toVC = (SecController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     
     UIImageView * smaillImV = fromVC.smallImV;
     UIView *containerView = [transitionContext containerView];
     UIView *tempView = [smaillImV snapshotViewAfterScreenUpdates:NO];
     
     tempView.frame = [smaillImV convertRect:smaillImV.bounds toView: containerView];//转换到containerView的坐标系上来;
     
     //设置动画前的各个控件的状态
     smaillImV.hidden = YES;
     toVC.view.alpha = 0;
     toVC.bigImV.image = smaillImV.image;
     
     //tempView 添加到containerView中，要保证在最前方，所以后添加
     [containerView addSubview:toVC.view];
     [containerView addSubview:tempView];
     //开始做动画
     [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.45 initialSpringVelocity:1/0.55 options:0 animations:^{
         
         tempView.frame = [toVC.view convertRect:toVC.bigImV.bounds toView:containerView];//把toVC.view上的bigImg转换到containerView上来;
         
         toVC.view.alpha = 1;
     } completion:^(BOOL finished) {
         fromVC.smallImV.hidden = NO;
         [tempView removeFromSuperview];
         toVC.bigImV.hidden = NO;
         //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中断动画完成的部署，会出现无法交互之类的bug
         [transitionContext completeTransition:YES];
     }];
#endif
     /**
      (lldb) po tempView.frame
      (origin = (x = 116, y = 65), size = (width = 88, height = 89))
      
      (lldb) po tempView.frame
      (origin = (x = 0, y = 0), size = (width = 320, height = 200))
      
      (lldb)
      说白了本质->就是拿tempView做个中间过渡.....
      */
     
#if 1
     ViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
     UIImageView * smallImV = fromVC.smallImV;
     UIView * snapView = [smallImV snapshotViewAfterScreenUpdates:NO];
     UIView * containerView = [transitionContext containerView];
     snapView.frame = [fromVC.view convertRect:smallImV.bounds toView:containerView];//计算containerView上的snapView相对于fromVC.view的frame。
     snapView.frame = [smallImV convertRect:smallImV.bounds toView: containerView];
     SecController * secVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     
     fromVC.smallImV.hidden = YES;
     secVC.view.alpha = 0;
     secVC.bigImV.image = smallImV.image;
     secVC.bigImV.hidden = YES;
     [containerView addSubview:secVC.view];
     [containerView addSubview:snapView];
     
     [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
         secVC.view.alpha = 1;  //图片放大 更随的alpha的改变
         snapView.frame = [secVC.bigImV convertRect:secVC.bigImV.bounds toView:containerView];
     } completion:^(BOOL finished) {
         fromVC.smallImV.hidden = NO;
        // secVC.bigImV.image = fromVC.smallImV.image;
         [snapView removeFromSuperview];
         secVC.bigImV.hidden = NO;
         [transitionContext completeTransition:YES];
     }];
#endif
 }

- (void)doDismissAnimataion:(id <UIViewControllerContextTransitioning>)transitionContext
{
    SecController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    UIView * tempView = [fromVc.bigImV snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVc.bigImV convertRect:fromVc.bigImV.bounds fromView:containerView];
    
    toVc.view.alpha = 0;
    toVc.smallImV.hidden = YES;
    fromVc.bigImV.hidden = YES;
    [containerView addSubview:toVc.view];
    [containerView addSubview:tempView];
    toVc.smallImV.image = fromVc.bigImV.image;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVc.view.alpha = 1;
        tempView.frame = [toVc.smallImV convertRect:toVc.smallImV.bounds toView:containerView];
    } completion:^(BOOL finished) {
        toVc.smallImV.hidden = NO;
        [tempView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}
#pragma mark 自定义转场小动画
- (void)revolveAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finishFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finishFrame, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.45 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finishFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

















