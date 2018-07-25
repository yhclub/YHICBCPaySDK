
Pod::Spec.new do |s|

  s.name         = "YHICBCPaySDK"
  s.version      = "1.0.0"
  s.summary      = "工行e支付SDK"

  s.description  = "工行e支付SDK "

  s.homepage     = "https://github.com/XmYlzYhkj/YHICBCPaySDK"

  s.license      = "MIT"

  s.author       = { "XmYhkj" => "yhkj_xm@163.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/XmYlzYhkj/YHICBCPaySDK.git", :tag => "1.0.0" }

  #s.source_files  = "Classes", "Classes/*"

  s.resources    = 'Resources/ICBCPaySDK.bundle'

  s.requires_arc = true

  s.vendored_frameworks = ["Frameworks/ICBCPaySDK.framework"]
  
end
