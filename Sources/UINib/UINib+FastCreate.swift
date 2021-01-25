//
//  UINib+FastCreate.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/18.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

/**
 *  从Main Bundle中加载NIB。
 *
 *  @param nibName XIB的文件名
 *  @return 对应的NIB对象
 */
extension UINib {
    convenience public
    init(_ nibName: String, bundle: Bundle = .main) {
        self.init(nibName: nibName, bundle: bundle)
    }
}

extension UIView {
    public
    class func nib(withName name: String = "", bundle: Bundle = .main) -> UINib {
        return UINib(name.isEmpty ? String(describing: self) : name, bundle: bundle)
    }
}

extension UIViewController {
    public
    class func nib(withName name: String = "", bundle: Bundle = .main) -> UINib {
        if name.isEmpty {
            return UINib(String(describing: self), bundle: bundle)
        }
        return UINib(name, bundle: bundle)
    }
}

extension String {
    
    public
    func nibInBundle(_ bundle: Bundle = .main) -> UINib? {
        if self.isEmpty {
            return nil
        }
        return bundle.loadNibNamed(self, owner: nil, options: nil)?.first as? UINib
    }
    
    public
    func nibInBundle(_ bundleName: String) -> UINib? {
        if self.isEmpty {
            return nil
        }
        return bundleName.bundle?.loadNibNamed(self, owner: nil, options: nil)?.first as? UINib
    }
    
    public var bundle: Bundle? {
        return Bundle(identifier: self)
    }
}
#endif
