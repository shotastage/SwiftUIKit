Pod::Spec.new do |spec|
  spec.name         = "SwiftUIKit"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of SwiftUIKit."
  spec.description  = <<-DESC
This is description.
                   DESC

  spec.homepage     = "https://github.com/shotastage/SwiftUIKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Shota Shimazu" => "hornet.live.mf@gmail.com" }
  spec.social_media_url   = "https://twitter.com/shotastage"
  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"
  spec.source       = { :git => "http://EXAMPLE/SwiftUIKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/SwiftUIKit", "Sources/SwiftUIKit/**/*.{h,m}"
  spec.exclude_files = "Docs", "Example", "Tests", "Scripts"
end
