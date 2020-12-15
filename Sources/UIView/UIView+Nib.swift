//
//  UIView+Nib.swift
//  WenYanWen
//
//  Created by Bee on 2020/12/15.
//

import UIKit

extension UIView {
    /**
     *  加载nib
     *
     *  @param nibName nib名字 [默认本类的类名]
     *  @param bundle  nib文件包（目录）[默认mainBundle]
     */
    public func loadNibNamed(nibName: String = String(describing: self), bundle: Bundle = Bundle.main) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    
    ///mark --------- XIB INSPECTABLE -----------
    //@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
    //@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
    //@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
    //@property (nonatomic, assign) IBInspectable UIColor *shadowColor;
    //@property (nonatomic, assign) IBInspectable CGSize  shadowOffset;
    //@property (nonatomic, assign) IBInspectable BOOL    maskToBounds;

}
