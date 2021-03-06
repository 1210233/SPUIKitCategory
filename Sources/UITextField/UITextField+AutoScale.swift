//
//  UITextField+AutoScale.swift
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
    var UITextFieldAutoScaleFontExchangeMethodNames: [String] {
        return ["setFont:"]
    }
    
    func sp_setFont(_ font: UIFont?) {
        if font != nil {
            var f = font!
            if !self.autoScaleFont {
                if !f.autoscaled {
                    f = f.withSize(f.pointSize * screenWidthScaleBase375)
                }
            }else{
                if f.autoscaled {
                    f = f.withSize(f.pointSize / screenWidthScaleBase375)
                }
            }
            return self.sp_setFont(f)
        }
        return self.sp_setFont(nil)
    }
    
    /**
     根据375屏幕宽度的比例自动缩放字体大小.
     */
    @IBInspectable public
    var autoScaleFont: Bool {
        get {
            if let v = objc_getAssociatedObject(self, &sp_autoScaleFontKey) as? NSNumber {
                return v.boolValue
            }
            return false
        }
        set {
            if newValue == autoScaleFont {
                return
            }
            objc_setAssociatedObject(self, &sp_autoScaleFontKey, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            var f: UIFont
            if newValue {
                if let font = self.font {
                    f = font.withSize(font.pointSize * screenWidthScaleBase375)
                }else{
                    f = UIFont.systemFont(ofSize: 15 * screenWidthScaleBase375)
                }
                f.autoscaled = true
            } else {
                if let font = self.font {
                    f = font.withSize(font.pointSize / screenWidthScaleBase375)
                    f.autoscaled = false
                }else{
                    f = UIFont.systemFont(ofSize: 15)
                }
            }
            return self.sp_setFont(f)
        }
    }
}
#endif
