//
//  UIView+Nib.m
//  SPKit
//
//  Created by 李双鹏 on 15/10/04.
//  Copyright (c) 2015 LSP. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (SPNib)

+ (UINib *)loadNib
{
    return [self loadNibNamed:NSStringFromClass([self class])];
}

+ (UINib *)loadNibNamed:(NSString*)nibName
{
    return [self loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}

+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}



#pragma mark ------ XIB INSPECTABLE ------
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}
- (CGFloat)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}
- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}
- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}
- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setMaskToBounds:(BOOL)maskToBounds {
    self.layer.masksToBounds = maskToBounds;
}
- (BOOL)maskToBounds {
    return self.layer.masksToBounds;
}

@end
