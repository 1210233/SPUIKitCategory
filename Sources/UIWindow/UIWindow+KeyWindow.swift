//
//  UIWindow+KeyWindow.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIWindow {
    public
    class var window: UIWindow {
        get {
            if let v = UIApplication.shared.keyWindow {
                return v
            }
            if let v = UIApplication.shared.windows.first {
                return v
            }
            return UIWindow()
        }
    }
}
#endif
