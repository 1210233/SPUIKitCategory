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
- (UIImage *)snapImage:(BOOL)opaque {
    return [self.layer snapImage:opaque];
}
@end


@implementation CALayer (Snapshot)

- (UIImage *)snapImage {
    return [self snapImage:NO];
}

- (UIImage *)snapImage:(BOOL)opaque {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, opaque, 0);
    
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

