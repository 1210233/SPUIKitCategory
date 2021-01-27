//
//  UIViewController+XIBCreation.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

@objc
extension UIViewController {
    /// 需要交换的方法名
    var UIViewControllerXibCreationExchangeMethodNames: [String] {
        return ["init"]
    }
    
    func sp_init() -> UIViewController {
        let vc = self.sp_init()
        vc.modalPresentationStyle = .fullScreen;
        vc.modalPresentationCapturesStatusBarAppearance = true
        return vc;
    }
}

extension UIViewController {
    
    public enum NibLoadType {
        case nib(_ name: String = "")
        case storyboard(_ name: String = "", _ identifier: String = "")
    }
    
    /**
     *  从XIB文件（与类名相同的xib）初始化。
     */
    public
    class func load(from type: NibLoadType, bundle: Bundle = .main) -> Self {
        switch type {
        case .nib(let nib):
            let name = nib.isEmpty ? String(describing: self) : nib
            if let _ = Bundle.main.path(forResource: name, ofType: "xib") {
                return self.init(nibName: name, bundle: bundle)
            }
            break
        case .storyboard(var name, var identy):
            if name.isEmpty {
                name = "Main"
            }
            if identy.isEmpty {
                identy = self.storyboardIndentifier
            }
            if identy.isEmpty {
                identy = String(describing: self)
            }
            if let vc = UIStoryboard(name: name, bundle: bundle).instantiateViewController(withIdentifier: identy) as? Self {
                return vc
            }
        }
        return self.init()
    }
    
    open class var storyboardName: String {
        return "Main"
    }
    
    open class var storyboardIndentifier: String {
        return String(describing: self)
    }
}

@objc
extension UINavigationController {
    /// 需要交换的方法名
    var UINavigationControllerXibCreationExchangeMethodNames: [String] {
        return ["initWithRootViewController:"]
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
        return ["instantiateInitialViewController"]
    }
    
    func sp_instantiateInitialViewController() -> UIViewController? {
        let vc = self.sp_instantiateInitialViewController()
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalPresentationCapturesStatusBarAppearance = true
        return vc
    }
    
    public static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
#endif
