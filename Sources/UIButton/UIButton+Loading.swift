//
//  UIButton+Loading.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIButton {
    
    ///开始加载
    public
    func startLoading() {
        let aiv = UIActivityIndicatorView(style: .gray)
        aiv.center = self.center
        aiv.tag = 93546569
        aiv.startAnimating()
        self.isEnabled = false
        self.superview?.addSubview(aiv)
    }
    
    ///结束加载
    public
    func endLoading() {
        self.isEnabled = true
        
        if let aiv = self.superview?.viewWithTag(93546569) as? UIActivityIndicatorView {
            aiv.stopAnimating()
            aiv.removeFromSuperview()
        }
    }
}
#endif
