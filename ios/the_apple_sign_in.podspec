#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint the_apple_sign_in.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'the_apple_sign_in'
  s.version          = '1.0.0'
  s.summary          = 'Sign in With Apple for Flutter.'
  s.description      = <<-DESC
Sign in With Apple for Flutter. Native API bindings and a Flutter implementation of the sign in button.
                       DESC
  s.homepage         = 'https://github.com/beerstorm-net/the_apple_sign_in'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Beerstorm' => 'yg@beerstorm.net' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
