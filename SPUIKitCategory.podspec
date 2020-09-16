#
# Be sure to run `pod lib lint SPUIKitCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SPUIKitCategory'
    s.version          = '1.3.2'
    s.summary          = 'SPUIKitCategory是UIKit的分类的集合'
    s.description      = <<-DESC
    SPUIKitCategory是UIKit的分类 的集合
    DESC

    s.homepage         = 'https://gitee.com/1210233'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '1210233' => '1210233@163.com' }
    s.source           = { :git => 'https://gitee.com/1210233/SPUIKitCategory.git', :tag => s.version.to_s, :submodules => true  }
    s.requires_arc = true

    #//仅支持ios
    s.platform = :ios
    s.ios.deployment_target = '8.0'


    s.prefix_header_contents = <<-EOS
    //#ifdef __OBJC__
    //#import "SPUIKitCategory.h"    //包含了所有头文件
    //#endif
    EOS


    s.source_files = 'SPUIKitCategory/SPUIKitCategory.h'
    s.public_header_files = 'SPUIKitCategory/SPUIKitCategory.h'


    
    s.subspec 'UIView' do |ss|
        ss.source_files = 'SPUIKitCategory/UIView/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIView/*.h'
    end
    
    s.subspec 'UILabel' do |ss|
        ss.dependency 'SPUIKitCategory/UIView'
        ss.source_files = 'SPUIKitCategory/UILabel/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UILabel/*.h'
    end
    
    s.subspec 'UIButton' do |ss|
        ss.dependency 'SPUIKitCategory/UIView'
        ss.dependency 'SPUIKitCategory/UILabel'
        ss.source_files = 'SPUIKitCategory/UIButton/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIButton/*.h'
    end

    s.subspec 'UIColor' do |ss|
        ss.source_files = 'SPUIKitCategory/UIColor/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIColor/*.h'
    end

    s.subspec 'UIControl' do |ss|
        ss.source_files = 'SPUIKitCategory/UIControl/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIControl/*.h'
    end

    s.subspec 'UIFont' do |ss|
        ss.source_files = 'SPUIKitCategory/UIFont/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIFont/*.h'
    end

    s.subspec 'UIImage' do |ss|
        ss.source_files = 'SPUIKitCategory/UIImage/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIImage/*.h'
    end

    s.subspec 'UINib' do |ss|
        ss.source_files = 'SPUIKitCategory/UINib/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UINib/*.h'
    end

    s.subspec 'UITextView' do |ss|
        ss.dependency 'SPUIKitCategory/UIView'
        ss.source_files = 'SPUIKitCategory/UITextView/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UITextView/*.h'
    end

    s.subspec 'UIViewController' do |ss|
        ss.source_files = 'SPUIKitCategory/UIViewController/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIViewController/*.h'
    end

    s.subspec 'UIWindow' do |ss|
        ss.source_files = 'SPUIKitCategory/UIWindow/*.{h,m}'
        ss.public_header_files = 'SPUIKitCategory/UIWindow/*.h'
    end
    
end
