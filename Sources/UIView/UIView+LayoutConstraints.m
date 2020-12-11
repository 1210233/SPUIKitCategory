//
//  UIView+LayoutConstraints.m
//  UIViewConstraints
//
//  Created by ZCGC on 2015/7/20.
//  Copyright © 2017年 LSP. All rights reserved.
//

#import "UIView+LayoutConstraints.h"
#import <objc/runtime.h>

#define RECOGNIZE_CONSTRAINTS_TO_PROPERTIES 0

@implementation UIView (LayoutConstraints)


- (NSLayoutConstraint *)leadingEqualToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"leading"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeLeading)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeLeading)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"leading"] =
        dic[@"leading"] = constraint;
    }
    return constraint;
}
- (NSLayoutConstraint *)trailingEqualToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"trailing"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:(NSLayoutAttributeTrailing)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:self
                                                  attribute:(NSLayoutAttributeTrailing)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"trailing"] =
        dic[@"trailing"] = constraint;
    }
    return constraint;
}
- (NSLayoutConstraint *)topEqualToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"top"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeTop)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeTop)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"top"] =
        dic[@"top"] = constraint;
    }
    return constraint;
}
- (NSLayoutConstraint *)bottomEqualToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"bottom"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:(NSLayoutAttributeBottom)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:self
                                                  attribute:(NSLayoutAttributeBottom)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"bottom"] =
        dic[@"bottom"] = constraint;
    }
    return constraint;
}

- (NSLayoutConstraint *)widthEqualToView:(UIView *)view {
    return [self widthEqualToView:view multiplier:1];
}
- (NSLayoutConstraint *)widthEqualToView:(UIView *)view multiplier:(CGFloat)multiplier {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"width"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeWidth)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeWidth)
                                                 multiplier:multiplier constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"width"] =
        dic[@"width"] = constraint;
    }
    return constraint;
}

- (NSLayoutConstraint *)heightEqualToView:(UIView *)view {
    return [self heightEqualToView:view multiplier:1];
}
- (NSLayoutConstraint *)heightEqualToView:(UIView *)view multiplier:(CGFloat)multiplier {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"height"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeHeight)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeHeight)
                                                 multiplier:multiplier constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"height"] =
        dic[@"height"] = constraint;
    }
    return constraint;
}

- (NSLayoutConstraint *)centerXEqualToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"centerX"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeCenterX)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeCenterX)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"centerX"] =
        dic[@"centerX"] = constraint;
    }
    return constraint;
}

- (NSLayoutConstraint *)centerYEqualToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"centerY"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeCenterY)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeCenterY)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"centerY"] =
        dic[@"centerY"] = constraint;
    }
    return constraint;
}



- (NSLayoutConstraint *)leadingSpacingToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"left_spacing"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeLeading)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeTrailing)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"left_spacing"] =
        dic[@"left_spacing"] = constraint;
    }
    return constraint;
}
- (NSLayoutConstraint *)trailingSpacingToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"right_spacing"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:(NSLayoutAttributeLeading)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:self
                                                  attribute:(NSLayoutAttributeTrailing)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"right_spacing"] =
        dic[@"right_spacing"] = constraint;
    }
    return constraint;
}
- (NSLayoutConstraint *)topSpacingToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"top_spacing"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeTop)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:view
                                                  attribute:(NSLayoutAttributeBottom)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"top_spacing"] =
        dic[@"top_spacing"] = constraint;
    }
    return constraint;
}
- (NSLayoutConstraint *)bottomSpacingToView:(UIView *)view {
    NSMutableDictionary *dic = [self constraintsDicForView:view];
    NSLayoutConstraint *constraint = dic[@"bottom_spacing"];
    if (!constraint) {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:(NSLayoutAttributeTop)
                                                  relatedBy:(NSLayoutRelationEqual)
                                                     toItem:self
                                                  attribute:(NSLayoutAttributeBottom)
                                                 multiplier:1 constant:0];
        [self.superview sp_addConstraint:constraint];
        [view constraintsDicForView:self][@"bottom_spacing"] =
        dic[@"bottom_spacing"] = constraint;
    }
    return constraint;
}




/* *********************************************************************************** */
/* ***** Getter ***** Getter ***** Getter ***** Getter ***** Getter ***** Getter ***** */
/* *********************************************************************************** */

- (BOOL)recognizeConstraintToPropeties {
    return [objc_getAssociatedObject(self, "recognizeConstraintToPropeties") boolValue];
}
// 宽度约束
- (NSLayoutConstraint *)widthConstraint {
#if DEBUG
    //    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeWidthConstraint:0];
    }
    return constraint;
}

- (NSLayoutConstraint *)makeWidthConstraint:(CGFloat)width {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:(NSLayoutAttributeWidth)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:nil
                                                                  attribute:(NSLayoutAttributeNotAnAttribute)
                                                                 multiplier:1 constant:width];
    [self sp_addConstraint:constraint];
    self.widthConstraint = constraint;
    return constraint;
}

// 高度约束
- (NSLayoutConstraint *)heightConstraint {
#if DEBUG
    //    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeHeightConstraint:0];
    }
    return constraint;
}

- (NSLayoutConstraint *)makeHeightConstraint:(CGFloat)height {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:(NSLayoutAttributeHeight)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:nil
                                                                  attribute:(NSLayoutAttributeNotAnAttribute)
                                                                 multiplier:1 constant:height];
    [self sp_addConstraint:constraint];
    self.heightConstraint = constraint;
    return constraint;
}

// 左边约束
- (NSLayoutConstraint *)leftConstraint {
#if DEBUG
    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeLeftConstraint:0];
    }
    return constraint;
}
- (NSLayoutConstraint *)makeLeftConstraint:(CGFloat)left {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:(NSLayoutAttributeLeading)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:self.superview
                                                                  attribute:(NSLayoutAttributeLeading)
                                                                 multiplier:1 constant:left];
    [self.superview sp_addConstraint:constraint];
    self.leftConstraint = constraint;
    return constraint;
}

// 顶部约束
- (NSLayoutConstraint *)topConstraint {
#if DEBUG
    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeTopConstraint:0];
    }
    return constraint;
}
- (NSLayoutConstraint *)makeTopConstraint:(CGFloat)top {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:(NSLayoutAttributeTop)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:self.superview
                                                                  attribute:(NSLayoutAttributeTop)
                                                                 multiplier:1 constant:top];
    [self.superview sp_addConstraint:constraint];
    self.topConstraint = constraint;
    return constraint;
}

// 右边约束
- (NSLayoutConstraint *)rightConstraint {
#if DEBUG
    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeRightConstraint:0];
    }
    return constraint;
}
- (NSLayoutConstraint *)makeRightConstraint:(CGFloat)right {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.superview
                                                                  attribute:(NSLayoutAttributeTrailing)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:self
                                                                  attribute:(NSLayoutAttributeTrailing)
                                                                 multiplier:1 constant:right];
    [self.superview sp_addConstraint:constraint];
    self.rightConstraint = constraint;
    return constraint;
}


// 底部约束
- (NSLayoutConstraint *)bottomConstraint {
#if DEBUG
    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeBottomConstraint:0];
    }
    return constraint;
}
- (NSLayoutConstraint *)makeBottomConstraint:(CGFloat)bottom {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.superview
                                                                  attribute:(NSLayoutAttributeBottom)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:self
                                                                  attribute:(NSLayoutAttributeBottom)
                                                                 multiplier:1 constant:bottom];
    [self.superview sp_addConstraint:constraint];
    self.bottomConstraint = constraint;
    return constraint;
}

- (NSLayoutConstraint *)centerXConstraint {
#if DEBUG
    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeCenterXConstraint:0];
    }
    return constraint;
}
- (NSLayoutConstraint *)makeCenterXConstraint:(CGFloat)centerX {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:(NSLayoutAttributeCenterX)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:self.superview
                                                                  attribute:(NSLayoutAttributeCenterX)
                                                                 multiplier:1 constant:centerX];
    [self.superview sp_addConstraint:constraint];
    self.centerXConstraint = constraint;
    return constraint;
}

- (NSLayoutConstraint *)centerYConstraint {
#if DEBUG
    NSParameterAssert(self.superview);
#endif
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    if (!constraint) {
        constraint = [self makeCenterYConstraint:0];
    }
    return constraint;
}
- (NSLayoutConstraint *)makeCenterYConstraint:(CGFloat)centerY {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:(NSLayoutAttributeCenterY)
                                                                  relatedBy:(NSLayoutRelationEqual)
                                                                     toItem:self.superview
                                                                  attribute:(NSLayoutAttributeCenterY)
                                                                 multiplier:1 constant:centerY];
    [self.superview sp_addConstraint:constraint];
    self.centerYConstraint = constraint;
    return constraint;
}

/* *********************************************************************************** */
/* ***** Setter ***** Setter ***** Setter ***** Setter ***** Setter ***** Setter ***** */
/* *********************************************************************************** */

- (void)setWidthConstraint:(NSLayoutConstraint *)widthConstraint {
    objc_setAssociatedObject(self, @selector(widthConstraint), widthConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setHeightConstraint:(NSLayoutConstraint *)heightConstraint {
    objc_setAssociatedObject(self, @selector(heightConstraint), heightConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setLeftConstraint:(NSLayoutConstraint *)leftConstraint {
    objc_setAssociatedObject(self, @selector(leftConstraint), leftConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setTopConstraint:(NSLayoutConstraint *)topConstraint {
    objc_setAssociatedObject(self, @selector(topConstraint), topConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setRightConstraint:(NSLayoutConstraint *)rightConstraint {
    objc_setAssociatedObject(self, @selector(rightConstraint), rightConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setBottomConstraint:(NSLayoutConstraint *)bottomConstraint {
    objc_setAssociatedObject(self, @selector(bottomConstraint), bottomConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setCenterXConstraint:(NSLayoutConstraint *)centerXConstraint {
    objc_setAssociatedObject(self, @selector(centerXConstraint), centerXConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setCenterYConstraint:(NSLayoutConstraint *)centerYConstraint {
    objc_setAssociatedObject(self, @selector(centerYConstraint), centerYConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Easily to get the constant of contraint.
- (CGFloat)widthConstant {
    return self.widthConstraint.constant;
}
- (CGFloat)heightConstant {
    return self.heightConstraint.constant;
}
- (CGFloat)leftConstant {
    return self.leftConstraint.constant;
}
- (CGFloat)topConstant {
    return self.topConstraint.constant;
}
- (CGFloat)rightConstant {
    return self.rightConstraint.constant;
}
- (CGFloat)bottomConstant {
    return self.bottomConstraint.constant;
}
- (CGFloat)centerXConstant {
    return self.centerXConstraint.constant;
}
- (CGFloat)centerYConstant {
    return self.centerYConstraint.constant;
}

// Easily to set the constant of contraint.
- (void)setWidthConstant:(CGFloat)widthConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(widthConstraint));
    if (!constraint) {
        [self makeWidthConstraint:widthConstant];
    }else{
        self.widthConstraint.constant = widthConstant;
    }
}
- (void)setHeightConstant:(CGFloat)heightConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(heightConstraint));
    if (!constraint) {
        [self makeHeightConstraint:heightConstant];
    }else{
        self.heightConstraint.constant = heightConstant;
    }
}
- (void)setLeftConstant:(CGFloat)leftConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(leftConstraint));
    if (!constraint) {
        [self makeLeftConstraint:leftConstant];
    }else{
        self.leftConstraint.constant = leftConstant;
    }
}
- (void)setTopConstant:(CGFloat)topConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(topConstraint));
    if (!constraint) {
        [self makeTopConstraint:topConstant];
    }else{
        self.topConstraint.constant = topConstant;
    }
}
- (void)setRightConstant:(CGFloat)rightConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(rightConstraint));
    if (!constraint) {
        [self makeRightConstraint:rightConstant];
    }else{
        self.rightConstraint.constant = rightConstant;
    }
}
- (void)setBottomConstant:(CGFloat)bottomConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(bottomConstraint));
    if (!constraint) {
        [self makeBottomConstraint:bottomConstant];
    }else{
        self.bottomConstraint.constant = bottomConstant;
    }
}
- (void)setCenterXConstant:(CGFloat)centerXConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(centerXConstraint));
    if (!constraint) {
        [self makeCenterXConstraint:centerXConstant];
    }else{
        self.centerXConstraint.constant = centerXConstant;
    }
}
- (void)setCenterYConstant:(CGFloat)centerYConstant {
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, @selector(centerYConstraint));
    if (!constraint) {
        [self makeCenterYConstraint:centerYConstant];
    }else{
        self.centerYConstraint.constant = centerYConstant;
    }
}


- (void)setRecognizeConstraintToPropeties:(BOOL)recognizeConstraintToPropeties {
    if (recognizeConstraintToPropeties == self.recognizeConstraintToPropeties)
        return;
    
    objc_setAssociatedObject(self, "recognizeConstraintToPropeties", recognizeConstraintToPropeties?@1:@0, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
