//
//  File.swift
//  
//
//  Created by LSP on 2021/1/7.
//

import Foundation

extension UITextView {
    public
    func rangeFrom(textRange: UITextRange) -> NSRange {
        let loc = self.offset(from: self.beginningOfDocument, to: textRange.start)
        let len = self.offset(from: textRange.start, to: textRange.end)
        return NSRange(location: loc, length: len)
    }
}
