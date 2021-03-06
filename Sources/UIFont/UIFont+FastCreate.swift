//
//  UIFont+FastCreate.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIFont {
    
    public
    class func regularPingFang(ofSize size: CGFloat) -> UIFont {
        if let f = UIFont(name: "PingFangSC-Regular", size: size) {
            return f
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    public
    class func mediumPingFang(ofSize size: CGFloat) -> UIFont {
        if let f = UIFont(name: "PingFangSC-Medium", size: size) {
            return f
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    public
    class func boldPingFang(ofSize size: CGFloat) -> UIFont {
        if let f = UIFont(name: "PingFangSC-Semibold", size: size) {
            return f
        }
        return UIFont.boldSystemFont(ofSize: size)
    }
}
#endif
