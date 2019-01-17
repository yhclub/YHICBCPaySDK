
Pod::Spec.new do |s|

  s.name         = "YHICBCPaySDK"
  s.version      = "1.0.1"
  s.summary      = "工行e支付SDK"

  s.description  = "工行e支付SDK，包含微信支付SDK、支付宝支付"

  s.homepage     = "https://github.com/XmYlzYhkj/YHICBCPaySDK"

  s.license      = "MIT"

  s.author       = { "XmYhkj" => "yhkj_xm@163.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/XmYlzYhkj/YHICBCPaySDK.git", :tag => "1.0.0" }

  #s.source_files  = "Classes", "Classes/*"

  s.requires_arc = true

  s.frameworks       = 'SystemConfiguration', 'CoreMotion','CFNetwork', 'CoreTelephony', 'QuartzCore', 'CoreText', 'CoreGraphics', 'UIKit', 'Foundation'

  s.libraries        = 'z', 'c++', 'sqlite3'

  s.vendored_frameworks = ["Frameworks/ICBCPaySDK.framework"]
  
  s.resources    = 'Resources/ICBCPaySDK.bundle'

  s.dependency     'YHAlipaySDK', '15.5.2'

  s.dependency     'AFNetworking', '~> 3.0'

  s.dependency     'Toast', '~> 4.0.0'

end
