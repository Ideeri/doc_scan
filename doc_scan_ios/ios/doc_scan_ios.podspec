#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint doc_scan.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'doc_scan_ios'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin for scanning documents using native APIs.'
  s.description      = 'This plugin allows scanning documents using ML Kit on Android and VisionKit on iOS.'
  s.homepage         = 'https://github.com/Ideeri/doc_scan'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Martin STEFFEN' => 'mail@tiph.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.platform = :ios, '13.0'
  s.frameworks = 'VisionKit', 'UIKit'
  s.ios.deployment_target = '13.0'
end
