//
//  UIView+Nib.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/15.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIView {
    /**
     *  加载nib
     *
     *  @param nibName nib名字 [默认本类的类名]
     *  @param bundle  nib文件包（目录）[默认mainBundle]
     */
    public
    class func loadNibNamed(_ nibName: String = "", bundle: Bundle = .main) -> UINib {
        let name = nibName.isEmpty ? String(describing: self) : nibName
        return UINib(nibName: name, bundle: bundle)
    }

    
    ///mark --------- XIB INSPECTABLE -----------
    @IBInspectable public
    var corner_Radius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public
    var shadow_Opacity: Float {
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
    var shadow_Color: UIColor? {
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
    var shadow_Offset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable public
    var masks_ToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
}
#endif
