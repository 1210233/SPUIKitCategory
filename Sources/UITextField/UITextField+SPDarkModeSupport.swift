//
//  UITextField+SPDarkModeSupport.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

@objc
extension UITextField {
    /// 需要交换的方法名
    var UITextFieldDarkModeSupportExchangeMethodNames: [String] {
        return ["setTextColor:"]
    }
    
    func sp_setTextColor(_ color: UIColor?) {
        var txtColor = color
        if #available(iOS 13.0, *) {
            if let c = self.darkModeTextColor {
                txtColor = UIColor(dynamicProvider: { (collection) -> UIColor in
                    if collection.userInterfaceStyle == .dark {
                        return c
                    }
                    return txtColor?.resolvedColor(with: collection) ?? UIColor.black
                })
            }
        } else if #available(iOS 12.0, *) {
            if let c = self.darkModeTextColor, let window = UIApplication.shared.keyWindow, window.traitCollection.userInterfaceStyle == .dark {
                txtColor = c
            }
        }
        self.sp_setTextColor(txtColor)
    }
    
    @IBInspectable public
    var darkModeTextColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, "darkModeTextColor") as? UIColor
        }
        set {
            objc_setAssociatedObject(self, "darkModeTextColor", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            let normal = self.textColor!
            var color: UIColor? = normal
            if #available(iOS 13.0, *) {
                color = UIColor(dynamicProvider: { (collection) -> UIColor in
                    if collection.userInterfaceStyle == .dark {
                        return (newValue ?? normal.resolvedColor(with: collection))
                    }
                    return normal.resolvedColor(with: collection)
                })
            } else if #available(iOS 12.0, *) {
                if let window = UIApplication.shared.keyWindow, window.traitCollection.userInterfaceStyle == .dark {
                    color = newValue
                }
            }
            return self.sp_setTextColor(color)
        }
    }

}
#endif
