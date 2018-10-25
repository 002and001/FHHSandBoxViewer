#
#  Be sure to run `pod spec lint FHHSandBoxViewer.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "FHHSandBoxViewer"
  s.version      = "1.0.4"
  s.summary      = "沙盒查看器，可以浏览App的沙盒文件和使用AirDrop进行分享"
  s.homepage     = "https://github.com/002and001/FHHSandBoxViewer"
  s.license      = "MIT"
  s.author       = { "002and001" => "xxewz1@163.com" }
  s.source       = { :git => "https://github.com/002and001/FHHSandBoxViewer.git", :tag => "#{s.version}" }
  s.module_name = 'FHHSandBoxViewer'
  s.ios.deployment_target = '8.0'
  s.frameworks   = "Foundation", "UIKit"
  s.source_files  = "FHHSandBoxViewer/**/*.swift"
  s.requires_arc = true

end