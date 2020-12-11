//
//  UITextView+AutoLayoutFitSize.m
//  SmartCity
//
//  Created by ZCGC on 2017/5/13.
//  Copyright © 2017年 NRH. All rights reserved.
//

#import "UITextView+AutoLayoutFitSize.h"
#import "UIView+LayoutConstraints.h"

@implementation UITextView (AutoLayoutFitSize)


- (CGFloat)fitWidth {
    return [self fitWidthOffset:0];
}

- (CGFloat)fitWidthOffset:(CGFloat)os {
    NSLayoutConstraint *cons = self.widthConstraint;
    if (!cons) {
        return 0;
    }
    return cons.constant = [self sizeThatFits:CGSizeMake(999, self.font.pointSize*1.5)].width + os;
}

- (CGFloat)fitHeightForWidth:(CGFloat)width {
    return [self fitHeightForWidth:width offset:0];
}

- (CGFloat)fitHeightForWidth:(CGFloat)width offset:(CGFloat)os {
    NSLayoutConstraint *cons = self.heightConstraint;
    if (!cons) {
        return 0;
    }
    return cons.constant = [self sizeThatFits:CGSizeMake(width, 999)].height + os;
}


@end
