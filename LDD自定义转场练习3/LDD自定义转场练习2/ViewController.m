//
//  ViewController.m
//  LDD自定义转场练习2
//
//  Created by 李洞洞 on 20/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "SecController.h"
#import "LDDAnimation.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecController * sec = [[SecController alloc]init];
    sec.modalTransitionStyle = UIModalPresentationCustom;
    sec.transitioningDelegate = self;
    [self presentViewController:sec animated:YES completion:nil];
}
#pragma mark --- UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [LDDAnimation lddAnimation:LDDAnimationTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [LDDAnimation lddAnimation:LDDAnimationTypeDismiss];
}
@end
