Pod::Spec.new do |s|
  s.name             = 'SwifterSwiftUI'
  s.version          = '0.3.1'
  s.summary          = 'SwifterSwiftUI is a collection of native SwiftUI extensions, with handy methods, syntactic sugar, and performance improvements'
  s.description      = <<-DESC
SwifterSwiftUI is a collection of native SwiftUI extensions, with handy methods, syntactic sugar, and performance improvements for wide range of SwiftUI classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.
                       DESC

  s.homepage         = 'https://github.com/asam139/SwifterSwiftUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'asam139' => '93sauu@gmail.com' }
  s.screenshot = 'https://raw.githubusercontent.com/asam139/SwifterSwiftUI/master/Assets/logo.png'

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'

  s.swift_version = '5.1'
  s.source = { :git => 'https://github.com/asam139/SwifterSwiftUI.git', :tag => s.version.to_s }
  s.source_files = 'Sources/SwifterSwiftUI/**/*'
  
  s.frameworks = 'SwiftUI', 'Combine'
end
