//
//  UIView+Snapshot.m
//  SPUIKitCategory
//
//  Created by LSP on 15/12/10.
//  Copyright © 2015年 LSP. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)
- (UIImage *)snapshot{
    //支持retina高分的关键
    if(/* DISABLES CODE */ (&UIGraphicsBeginImageContextWithOptions) != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }

    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end


@implementation CALayer (Snapshot)

- (UIImage *)snapshot{
    if(/* DISABLES CODE */ (&UIGraphicsBeginImageContextWithOptions) != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

