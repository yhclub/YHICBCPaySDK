
Pod::Spec.new do |s|

  s.name         = "YHICBCPaySDK"
  s.version      = "1.1.0"
  s.summary      = "工行e支付SDK"

  s.description  = "工行e支付SDK，包含微信支付SDK、支付宝支付; update SDK支付接入文档20200904 "

  s.homepage     = "https://github.com/XmYlzYhkj/YHICBCPaySDK"

  s.license      = "MIT"

  s.author       = { "XmYhkj" => "yhkj_xm@163.com" }

  s.platform     = :ios, "9.0"

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '$(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_$(EFFECTIVE_PLATFORM_SUFFIX)__NATIVE_ARCH_64_BIT_$(NATIVE_ARCH_64_BIT)__XCODE_$(XCODE_VERSION_MAJOR))',
    'EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200' => 'arm64 arm64e armv7 armv7s armv6 armv8'
  }

  s.source       = { :git => "https://github.com/XmYlzYhkj/YHICBCPaySDK.git", :tag => s.version.to_s }

  #s.source_files  = "Classes", "Classes/*"

  s.requires_arc = true

  s.frameworks       = 'SystemConfiguration', 'CoreMotion','CFNetwork', 'CoreTelephony', 'QuartzCore', 'CoreText', 'CoreGraphics', 'UIKit', 'Foundation'

  s.libraries        = 'z', 'c++', 'sqlite3'

  s.vendored_frameworks = ["Frameworks/ICBCPaySDK.framework"]
  
  s.resources    = 'Resources/ICBCPaySDK.bundle'

  s.dependency     'AlipaySDK-iOS'
      
  s.dependency     'WechatOpenSDK'

  s.dependency     'AFNetworking', '~> 4.0'

  s.dependency     'Toast', '~> 4.0.0'

  #s.dependency     'GTMBase64', '1.0.1'

end
