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
    public
    class func loadNibNamed(nibName: String = String(describing: self), bundle: Bundle = Bundle.main) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    
    ///mark --------- XIB INSPECTABLE -----------
    @IBInspectable public
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable public
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable public
    var shadowColor: UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable public
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable public
    var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
}
