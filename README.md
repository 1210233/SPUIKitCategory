# SPUIKitCategory

[![CI Status](https://img.shields.io/travis/1210233/SPUIKitCategory.svg?style=flat)](https://travis-ci.org/1210233/SPUIKitCategory)
[![Version](https://img.shields.io/cocoapods/v/SPUIKitCategory.svg?style=flat)](https://cocoapods.org/pods/SPUIKitCategory)
[![License](https://img.shields.io/cocoapods/l/SPUIKitCategory.svg?style=flat)](https://cocoapods.org/pods/SPUIKitCategory)
[![Platform](https://img.shields.io/cocoapods/p/SPUIKitCategory.svg?style=flat)](https://cocoapods.org/pods/SPUIKitCategory)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SPUIKitCategory is available through [SPM](Swift-Package-Manager). 
　
 
　
 
Add SPUIKitCategory by your project dependency, In XCode:

　Step 1, open your project and click menus by `File -> Swift Packages -> Add Package Dependency...`.
  
　Step 2, in the "Enter package repository URL" field, fill `https://github.com/1210233/SPUIKitCategory.git` into it.
  
　Step 3, select a version rule which you want and click `next`, then click `Finish`.



Add SPUIKitCategory by your `package dependency`, In File `Package.swift`:

    
    let package = Package(name: "SomePackage",
                          platforms: [],
                          products: [.library(name: "SomePackage",
                                              targets: ["SomePackage"])],  
                          dependencies: [
                              // Dependencies declare other packages that this package depends on.
                            .package(url: "https://github.com/1210233/SPUIKitCategory.git", from: Version(1, 0, 0)),
                          ],

                          targets: [.target(name: "SomePackage",
                                            dependencies: ["SPUIKitCategory"],
                                            path: "Sources")
                                    ]  
                            )
                        
                        

                        
## Author

LSP, 1210233@163.com

## License

SPUIKitCategory is available under the MIT license. See the LICENSE file for more info.
