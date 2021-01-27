//
//  UIColor+SPCreate.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/18.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIColor {
    
    /// 16进制数值初始化颜色
    /// - Parameter hex: 若长度4字节，第一字节为Alpha，二三四字节为RGB。
    ///                  若长度3自己，则三个字节分别为RGB，Alpha为1。
    convenience public
    init(hex: UInt) {
        
        let c1 = UInt8(hex >> 24 & 0xFF)
        let c2 = UInt8(hex >> 16 & 0xFF)
        let c3 = UInt8(hex >> 8 & 0xFF)
        let c4 = UInt8(hex & 0xFF)
        
        if c1 != 0 {
            self.init(red: CGFloat(c1) / 255, green: CGFloat(c2) / 255, blue: CGFloat(c3) / 255, alpha: CGFloat(c4 - 1) / 254)
        }else{
            self.init(red: CGFloat(c2) / 255, green: CGFloat(c3) / 255, blue: CGFloat(c4) / 255, alpha: 1)
        }
    }
    
    /// r.g.b.a RRRGGGBBB eg:23056098 -> r=23 g=56 b=98
    convenience public
    init(RGB rgb: UInt, alpha: CGFloat = 1) {
        let red = CGFloat((rgb / 1000 / 1000) % 1000);
        let green = CGFloat((rgb / 1000) % 1000);
        let blue = CGFloat(rgb % 1000);
        self.init(red: CGFloat(red) / 999, green: CGFloat(green) / 999, blue: CGFloat(blue) / 999, alpha: alpha)
    }
    
    /// RGBA初始化颜色
    /// - Parameters:
    ///   - rgb: (red, green, blue).  valid value [0 ~ 1]
    ///   - alpha: alpha.  valid value [0 ~ 1].   defaults 1.
    convenience public
    init<T>(RGB rgb: (T, T, T), A alpha: T = 1) where T: BinaryFloatingPoint {
        self.init(red: CGFloat(rgb.0), green: CGFloat(rgb.1), blue: CGFloat(rgb.2), alpha: CGFloat(alpha))
    }
    
    /// RGBA初始化颜色
    /// - Parameters:
    ///   - rgb: (red, green, blue).  valid value [0 ~ 255]
    ///   - alpha: alpha.  valid value [0 ~ 1].   defaults 1.
    convenience public
    init<T, P>(RGB rgb: (T, T, T), A alpha: P = 1) where T: BinaryInteger, P: BinaryFloatingPoint {
        self.init(red: CGFloat(rgb.0) / 255, green: CGFloat(rgb.1) / 255, blue: CGFloat(rgb.2) / 255, alpha: CGFloat(alpha))
    }
    
    /**
     * @param color can be 0xAABBCC or 0XAABBCC, and or #AABBCC
     */
    convenience public
    init(hexString string: String, alpha: CGFloat = 1) {
        var cString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        guard cString.count >= 6 else {
            self.init(white: 0, alpha:0)
            return
        }
        
        if let range = cString.range(of: "0X") {
            cString = String(cString[range.upperBound...])
        }
        if let range = cString.range(of: "0x") {
            cString = String(cString[range.upperBound...])
        }
        if let index = cString.firstIndex(of: Character("#")) {
            cString = String(cString[index...])
        }
        guard cString.count == 6 else {
            self.init(white: 0, alpha:0)
            return
        }
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: String(cString[cString.startIndex ..< cString.index(cString.startIndex, offsetBy: 2)])).scanHexInt32(&r)
        Scanner(string: String(cString[cString.index(cString.startIndex, offsetBy: 2) ..< cString.index(cString.startIndex, offsetBy: 4)])).scanHexInt32(&g)
        Scanner(string: String(cString[cString.index(cString.startIndex, offsetBy: 4) ..< cString.endIndex])).scanHexInt32(&b)
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
    
    /// Color from another color.
    /// - Parameter color: another color
    public convenience
    init(color: UIColor) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    @available(*, unavailable, message: "init(mode: Modes) has been renamed to init(_: UIColor, _: UIColor = .lightGray)")
    public typealias Modes = (normal: UIColor, night: UIColor)
    @available(*, unavailable, renamed: "init(_:_:)")
    public convenience
    init(mode: (normal: UIColor, night: UIColor)) {
        self.init(white: 1, alpha: 1)
    }
    /// color with normal mode an dark mode colors.
    /// - Parameter mode: (normal mode color, dark mode color)
    public convenience
    init(_ lightMode: UIColor, _ darkMode: UIColor = .lightGray) {
        if #available(iOS 13.0, *) {
            self.init { (colletion) -> UIColor in
                if colletion.userInterfaceStyle == .dark {
                    return darkMode
                }
                return lightMode
            }
        } else {
            self.init(color: lightMode)
        }
    }
}
#endif
