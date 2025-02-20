# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'


target 'Alixy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Alixy
  pod 'MMKV'
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'FBSDKCoreKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxGesture'
  pod 'RxDataSources'
  pod 'NSObject+Rx'
  pod 'SwifterSwift'
  pod 'BRPickerView'
  pod 'SVProgressHUD'
  pod 'HandyJSON'
  pod 'SwiftyStoreKit'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # 设置所有 Pods 的最低 iOS 部署版本
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'

      # 设置 Swift 版本
      config.build_settings['SWIFT_VERSION'] = '5.0'

      # 统一设置 Swift 优化级别为 -Onone
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
    end
  end
end


