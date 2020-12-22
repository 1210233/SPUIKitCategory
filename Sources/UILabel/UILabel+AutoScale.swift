//
//  UILabel+AutoScale.swift
//  WenYanWen
//
//  Created by LSP on 2020/12/22.
//

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
    @IBInspectable
    var autoScaleFont: Bool {
        get {
            if let v = objc_getAssociatedObject(self, "autoScaleFont") as? NSNumber {
                return v.boolValue
            }
            return false
        }
        set {
            if newValue == autoScaleFont {
                return
            }
            objc_setAssociatedObject(self, "autoScaleFont", NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
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
