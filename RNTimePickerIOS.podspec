package = JSON.parse(File.read(File.join(__dir__, "package.json")))
version = package['version']

Pod::Spec.new do |s|
  s.name             = "RNTimePickerIOS"
  s.version          = version
  s.summary          = package["description"]
  s.requires_arc = true
  s.license      = 'MIT'
  s.homepage     = 'n/a'
  s.authors      = { "goncharov_denis" => "" }
  s.source       = { :git => "https://github.com/botwy/react-native-time-picker-ios" }
  s.source_files = 'ios/TimePickerIOS/*.{h,m}'
  s.platform     = :ios, "8.0"
  s.dependency 'React-Core'
end