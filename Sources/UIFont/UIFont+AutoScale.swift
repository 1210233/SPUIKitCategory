//
//  UIFont+AutoScale.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIFont {
    public
    var autoscaled: Bool {
        get {
            if let n = objc_getAssociatedObject(self, &sp_autoscaledKey) as? NSNumber {
                return n.boolValue
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &sp_autoscaledKey, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
#endif
