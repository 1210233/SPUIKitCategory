//
//  UITextView+SPExtensions.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/7.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UITextView {
    public
    func rangeFrom(textRange: UITextRange) -> NSRange {
        let loc = self.offset(from: self.beginningOfDocument, to: textRange.start)
        let len = self.offset(from: textRange.start, to: textRange.end)
        return NSRange(location: loc, length: len)
    }
}
#endif
