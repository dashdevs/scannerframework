#
# Be sure to run `pod lib lint ScannerFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScannerFramework'
  s.version          = '0.1.15'
  s.summary          = 'ScannerFramework for GoodsScanner & ReceiptScan'
  s.homepage         = 'https://dashdevs.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dashdevs llc' => 'hello@dashdevs.com' }
  s.source           = { :git => 'https://bitbucket.org/itomych/ScannerFramework.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'ScannerFramework/Classes/**/*'
  
  s.resource_bundles = {
      'ScannerFramework' => ['ScannerFramework/Assets/**/*.{xcassets,storyboard,xib,otf}']
  }
  s.resource = 'ScannerFramework/Assets/**/*.{xcassets,storyboard,xib,otf}'

  s.swift_version = '5.0'
  
  s.dependency 'DashdevsNetworking'
  s.dependency 'SwiftGen'
end
