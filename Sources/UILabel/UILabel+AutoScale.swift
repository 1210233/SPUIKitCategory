//
//  UILabel+AutoScale.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

@objc
extension UILabel {
    /// 需要交换的方法名
    var autoScaleFontExchangeMethodNames: [String] {
        return ["setFont:"]
    }
    
    func sp_setFont(_ font: UIFont) {
        var f = font
        if !self.autoScaleFont {
            if !font.autoscaled {
                f = font.withSize(font.pointSize * screenWidthScaleBase375)
            }
        }else{
            if font.autoscaled {
                f = font.withSize(font.pointSize / screenWidthScaleBase375)
            }
        }
        return self.sp_setFont(f)
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
            
            if newValue {
                let font = self.font.withSize(self.font.pointSize * screenWidthScaleBase375)
                font.autoscaled = true
                self.sp_setFont(font)
            } else {
                let font = self.font.withSize(self.font.pointSize / screenWidthScaleBase375)
                font.autoscaled = false
                self.sp_setFont(font)
            }
        }
    }
}
#endif
