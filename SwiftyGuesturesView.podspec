#
# Be sure to run `pod lib lint SwiftyGuesturesView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'SwiftyGuesturesView'
s.version          = '1.0.0'
s.summary          = 'SwiftyGuesturesView手势密码'

s.description      = <<-DESC
TODO: SwiftyGuesturesView是一个轻量级手势密码库.
DESC

s.homepage         = 'https://github.com/ALmanCoder/SwiftyGuesturesView'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'ALmanCoder' => '1099508857@qq.com' }
s.source           = { :git => 'https://github.com/ALmanCoder/SwiftyGuesturesView.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'SwiftyGuesturesView/Classes/*.swift'

end
