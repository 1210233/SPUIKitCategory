#
# Be sure to run `pod lib lint SPUIKitCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SPUIKitCategory'
  s.version          = '1.0.0'
  s.summary          = 'SPUIKitCategory是UIKit的分类的集合'
  s.description      = <<-DESC
    SPUIKitCategory是UIKit的分类 的集合
                       DESC

  s.homepage         = 'https://gitee.com/1210233'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1210233' => '1210233@163.com' }
  s.source           = { :git => 'https://gitee.com/1210233/SPUIKitCategory.git', :tag => s.version.to_s }
  
  
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  
  #//仅支持ios
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  

  s.prefix_header_contents = <<-EOS
  #ifdef __OBJC__
  #import "SPUIKitCategory.h"    //SGExtension包含了所有头文件
  #endif
  EOS
  
  
  s.source_files = 'SPUIKitCategory/SPUIKitCategory.h'
#  s.source_files = 'SPUIKitCategory/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SPUIKitCategory' => ['SPUIKitCategory/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
#  s.weak_framework = 'MessageUI'


# *匹配所有文件
#
# c*匹配以名字C开头的文件
#
# *c匹配以名字c结尾的文件
#
# *c*匹配所有名字包含c的文件
#
# ** 文件夹以及递归子文件夹
#
# ?任意一个字符(注意是一个字符)
#
# [set]匹配多个字符,支持取反
#
# {p,q}匹配名字包括p 或者 q的文件


#"JSONKit.?"    #=> ["JSONKit.h", "JSONKit.m"]   //JSONKit.字符
#"*.[a-z][a-z]" #=> ["CHANGELOG.md", "README.md"]//.两个a-z的字母
#"*.[^m]*"      #=> ["JSONKit.h"]                //.不是m的字符
#"*.{h,m}"      #=> ["JSONKit.h", "JSONKit.m"]   //包含.h或者.m
#"*"            #=> ["CHANGELOG.md", "JSONKit.h", "JSONKit.m", "README.md"]//所有文件



end
