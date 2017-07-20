//
//  SecController.m
//  LDD自定义转场练习2
//
//  Created by 李洞洞 on 20/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "SecController.h"

@interface SecController ()

@end

@implementation SecController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * label = ({
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 44)];
        label.center = self.view.center;
        label.text = @"第二个控制器";
        label;
    });
    _bigImV = ({
        UIImageView * imV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        imV.backgroundColor = [UIColor lightGrayColor];
        imV;
    });
    [self.view addSubview:_bigImV];
    [self.view addSubview:label];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
