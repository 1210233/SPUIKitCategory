//
//  File.swift
//  
//
//  Created by Bee on 2020/12/12.
//

import UIKit

// 放在需要交换方法的文件中
#if !PRExchangeMethodFlag
/// 定义 `protocol`
@objc
public protocol PRExchangeMethod: class {
    optional
    static func exchangeMethodPrefix() -> String? // Default is "sp_"
}
#endif


// 放在AppDelegate中
#if NEVER_COMPILE


#if PRExchangeMethodFlag // 在other swift flags中添加 -D PRExchangeMethodFlag
/// 定义 `protocol`
//@objc
public protocol PRExchangeMethod: class {
    //    @objc optional
    //    static func ExchangeMethodNames()
    static func exchangeMethodPrefix() -> String? // Default is "sp_"
}
#endif

extension AppDelegate {
    
    func exchangeMethodFor(class cls: PRExchangeMethod.Type) {
        #if DEBUG // 打印类名
        print("----------\(cls)----------")
        #endif
        let prefix = cls.exchangeMethodPrefix() ?? "sp_"
        var cnt = UInt32()
        var names = [String]()
        if let c = cls as? NSObject.Type, let pts = class_copyPropertyList(cls, &cnt) {
            for i in 0 ..< Int(cnt) {
                let name = String(cString:property_getName(pts[i]))
                guard name.hasSuffix("ExchangeMethodNames") else {
                    continue
                }
                
                if let arr = c.init().perform(Selector(name)) {
                    
                    if let array = arr.takeUnretainedValue() as? [String] {
                        names += array
                    }
                    //                    arr.release()
                }
            }
        }
        
        //        names = []
        for name in names {
            print("[\(cls) "  + name + "] to [\(cls) " + prefix + name + "]")
            
            let originalSelector = Selector(name);
            let swizzledSelector = Selector(prefix + name)
            
            guard let originalMethod = class_getInstanceMethod(cls, originalSelector) else {
                #if DEBUG
                print("Method(" + name + ") not found for \(cls)")
                #endif
                continue
            }
            
            guard let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector) else {
                #if DEBUG
                print("Method(" + prefix + name + ") not found for \(class_getName(cls))")
                #endif
                continue
            }
            
            let didAddMethod =
                class_addMethod(cls,
                                originalSelector,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(cls,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
                
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    }

    @_dynamicReplacement(for:application(_:didFinishLaunchingWithOptions:))
    func sp_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG // 打印类名
            print("=============================================\n开始方法交换...")
        #endif
        let typeCount = Int(objc_getClassList(nil, 0))
        let  types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleaseintTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleaseintTypes, Int32(typeCount)) //获取所有的类
        
//        let types = objc_copyClassList(&typeCount)
        
        for index in 0 ..< typeCount {
            guard let cls = types[index] as? PRExchangeMethod.Type else {
                continue
            }
            self.exchangeMethodFor(class: cls)
        }
        let otherClasses = ["UIView"]
        for name in otherClasses {
            if let cls = objc_getClass(name) as? PRExchangeMethod.Type {
                self.exchangeMethodFor(class: cls)
            }
        }
        
        types.deallocate()
        #if DEBUG // 打印类名
            print("结束方法交换。\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=====================")
        #endif
        return self.application(application, didFinishLaunchingWithOptions:launchOptions)
    }
}

#endif
