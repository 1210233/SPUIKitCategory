//
//  UIButton+Loading.m
//  Transport
//
//  Created by LSP on 15/5/3.
//  Copyright (c) 2015年 LSP. All rights reserved.
//

#import "UIButton+Loading.h"

@implementation UIButton (Loading)

-(void)startLoading{
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    aiv.center = self.center;
    
    aiv.tag = 97561;
    [aiv startAnimating];
    
    self.enabled = NO;
    
    [self.superview addSubview:aiv];
}

-(void)endLoading{
    self.enabled = YES;
    
    UIActivityIndicatorView *aiv = (UIActivityIndicatorView *)[self.superview viewWithTag:97561];
    [aiv stopAnimating];
    
    [aiv removeFromSuperview];
}

@end
