//
//  UIColor+SPCreate.swift
//  WenYanWen
//
//  Created by Bee on 2020/12/18.
//

import UIKit


extension String {
    /// string[NSRage(location: loc, length: len)]
    subscript(bounds: NSRange) -> String {
        if bounds.location < 0  || bounds.location >= self.count {
            return ""
        }
        var length = bounds.length
        if bounds.location + length > self.count {
            length = self.count - bounds.location
        }
        let sIndex = self.index(self.startIndex, offsetBy: bounds.location)
        let eIndex = self.index(sIndex, offsetBy: length)
        return String(self[sIndex..<eIndex])
    }
    /// string[x ..< y]
    subscript(r: Range<Int>) -> String {
        if r.lowerBound < 0 ||
            r.lowerBound >= self.count ||
            r.lowerBound < r.upperBound {
            return ""
        }
        var e = r.upperBound
        if e < r.lowerBound {
            e = r.lowerBound
        }else if r.lowerBound + e > self.count {
            e = self.count - r.lowerBound
        }
        let sIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let eIndex = self.index(self.startIndex, offsetBy: e)
        return String(self[sIndex..<eIndex])
    }
    /// string[x ... y]
    subscript(r: ClosedRange<Int>) -> String {
        if r.lowerBound < 0 ||
            r.lowerBound >= self.count ||
            r.lowerBound < r.upperBound {
            return ""
        }
        var e = r.upperBound
        if e < r.lowerBound {
            e = r.lowerBound
        }else if r.lowerBound + e >= self.count {
            e = self.count - r.lowerBound - 1
        }
        let sIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let eIndex = self.index(self.startIndex, offsetBy: e)
        return String(self[sIndex...eIndex])
    }
    /// string[x ...]
    subscript(r: PartialRangeFrom<Int>) -> String {
        return self[r.lowerBound...self.count - 1]
    }
    /// string[...y]
    subscript(r: PartialRangeThrough<Int>) -> String {
        if self.isEmpty {
            return ""
        }
        return self[0...r.upperBound]
    }
    /// string[..< y]
    subscript(r: PartialRangeUpTo<Int>) -> String {
        if self.isEmpty {
            return ""
        }
        return self[0..<r.upperBound]
    }
    /// string[loc, len]
    subscript(loc: Int, len: Int = 1) -> String {
        return self[NSRange(location: loc, length: len)]
    }
}


extension UIColor {
    
    /// 16进制数值初始化颜色
    /// - Parameter hex: 若长度4字节，第一字节为Alpha，二三四字节为RGB。
    ///                  若长度3自己，则三个字节分别为RGB，Alpha为1。
    convenience
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
    
    convenience
    init(RGB rgb: UInt, alpha: CGFloat = 1) {
        let red = CGFloat((rgb / 1000 / 1000) % 1000);
        let green = CGFloat((rgb / 1000) % 1000);
        let blue = CGFloat(rgb % 1000);
        self.init(red: CGFloat(red) / 999, green: CGFloat(green) / 999, blue: CGFloat(blue) / 999, alpha: alpha)
    }
    
    convenience
    init(hexString string: String) {
        var cString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        guard cString.count >= 6 else {
            self.init(white: 0, alpha:0)
            return
        }
        
        if let index = cString.firstIndex(of: Character("0X")) {
            cString = String(cString[index...])
        }
        if let index = cString.firstIndex(of: Character("0x")) {
            cString = String(cString[index...])
        }
        if let index = cString.firstIndex(of: Character("#")) {
            cString = String(cString[index...])
        }
        guard cString.count == 6 else {
            self.init(white: 0, alpha:0)
            return
        }
        
        let rString = cString[0, 2]
        let gString = cString[2, 2]
        
    }
}
