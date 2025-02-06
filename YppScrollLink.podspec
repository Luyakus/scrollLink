Pod::Spec.new do |s|
  s.name             = 'YppScrollLink'
  s.version          = '0.0.1'
  s.summary          = '这里是概要'
  s.description      = <<-DESC
  滑动联动轻量级解决方案
                       DESC

  s.homepage         = 'http://git.yupaopao.com/terminal/ios/component/YppScrollLink'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leigaopan' => 'leigaopan@yupaopao.cn' }
  s.source           = { :git => 'git@git.yupaopao.com:terminal/ios/component/YppScrollLink.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Pods/Classes/**/*.{h,m}'
  
end
