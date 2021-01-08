//
//  UIButton+AutoScale.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIButton {
    
    /**
     根据375的屏幕宽度来缩放titleLabel的字体(NormalState)
     */
    @IBInspectable public
    var autoScaleFont: Bool {
        get {
            return self.titleLabel?.autoScaleFont ?? false
        }
        set {
            if newValue == autoScaleFont {
                return
            }
            self.titleLabel?.autoScaleFont = newValue
        }
    }
}
#endif
