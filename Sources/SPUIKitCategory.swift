//
//  File.swift
//  
//
//  Created by Bee on 2020/12/12.
//

import UIKit

// 放在需要交换方法的文件中
#if !PRExchangeMethod
/// 定义 `protocol`
public protocol PRExchangeMethod: class {
    static func exchangeMethodNames() -> [String]?
    static func exchangeMethodPrefix() -> String? // Default is "sp_"
}
#endif


// 放在AppDelegate中
#if NEVER_COMPILE

#if PRExchangeMethod // 在other swift flags中添加 -D PRExchangeMethod
/// 定义 `protocol`
public protocol PRExchangeMethod: class {
    static func exchangeMethodNames() -> [String]?
    static func exchangeMethodPrefix() -> String? // Default is "sp_"
}
#endif

extension AppDelegate {
    
    @_dynamicReplacement(for:application(_:didFinishLaunchingWithOptions:))
    func sp_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG // 打印类名
            print("=============================================\n开始方法交换...")
        #endif
        let typeCount = Int(objc_getClassList(nil, 0))
        let  types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleaseintTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleaseintTypes, Int32(typeCount)) //获取所有的类
        
        for index in 0 ..< typeCount {
            guard let cls = types[index] as? PRExchangeMethod.Type else {
                continue
            }
            
            let prefix = cls.exchangeMethodPrefix() ?? "sp_"
            
            #if DEBUG // 打印类名
                print("\(cls)")
            #endif
            
            guard let names = cls.exchangeMethodNames(), !names.isEmpty else {
                continue
            }
            
            for name in names {
                print("----------[\(cls) "  + name + "]")
                
                let originalSelector = Selector(name);
                let swizzledSelector = Selector(prefix + name)
                
                guard let originalMethod = class_getInstanceMethod(cls, originalSelector) else {
                    #if DEBUG
                    print("Method(" + name + ") not found for \(class_getName(cls))")
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
        types.deallocate()
        #if DEBUG // 打印类名
            print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=====================\n结束方法交换。")
        #endif
        return self.application(application, didFinishLaunchingWithOptions:launchOptions)
    }
}

#endif
