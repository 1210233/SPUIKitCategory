//
//  UIViewController+XIBCreation.swift
//  WenYanWen
//
//  Created by LSP on 2020/12/22.
//

import UIKit

@objc
extension UIViewController {
    /// 需要交换的方法名
    var UIViewControllerXibCreationExchangeMethodNames: [String] {
        get {
            return ["init"]
        }
    }
    
    /**
     *  从XIB文件（与类名相同的xib）初始化。
     */
    class func loadFromNib() -> UIViewController {
        let name = String(describing: self)
        if let _ = Bundle.main.path(forResource: name, ofType: "xib") {
            return self.init(nibName: name, bundle: nil)
        }
        return self.init()
    }
    
    
    func sp_init() -> UIViewController {
        let vc = self.sp_init()
        vc.modalPresentationStyle = .fullScreen;
        vc.modalPresentationCapturesStatusBarAppearance = true
        return vc;
    }
}

@objc
extension UINavigationController {
    /// 需要交换的方法名
    var UINavigationControllerXibCreationExchangeMethodNames: [String] {
        get {
            return ["initWithRootViewController:"]
        }
    }
    func sp_initWithRootViewController(_ vc: UIViewController) -> UINavigationController {
        let navi = self.sp_initWithRootViewController(vc)
        navi.modalPresentationStyle = .fullScreen
        navi.modalPresentationCapturesStatusBarAppearance = true
        return navi
    }
}

@objc
extension UIStoryboard {
    /// 需要交换的方法名
    var UIStoryboardXibCreationExchangeMethodNames: [String] {
        get {
            return ["instantiateInitialViewController"]
        }
    }
    
    func sp_instantiateInitialViewController() -> UIViewController? {
        let vc = self.sp_instantiateInitialViewController()
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalPresentationCapturesStatusBarAppearance = true
        return vc
    }
}
