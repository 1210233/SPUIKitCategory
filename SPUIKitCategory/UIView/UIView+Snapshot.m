//
//  UIView+Snapshot.m
//  SPUIKitCategory
//
//  Created by LSP on 15/12/10.
//  Copyright © 2015年 LSP. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)
- (UIImage *)snapImage {
    return [self.layer snapImage];
}
@end


@implementation CALayer (Snapshot)

- (UIImage *)snapImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

