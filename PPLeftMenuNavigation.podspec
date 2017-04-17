Pod::Spec.new do |s|
s.name             = 'PPLeftMenuNavigation'
s.version          = '1.0.1'
s.summary          = 'Design left menu navigation with a blur animation.'

s.description      = <<-DESC
Ths project is a left menu navigation with a nice a smooth animation. A blur effect on the background a the viewcontroller could be added.
This left menu is simple to use.
DESC

s.homepage         = 'https://github.com/PierrePerrin/PPDesignLeftMenuNavigation'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '<YOUR NAME HERE>' => '<YOUR EMAIL HERE>' }
s.source           = { :git => 'https://github.com/PierrePerrin/PPDesignLeftMenuNavigation.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.2'
s.source_files = 'PPLeftMenuNavigation/PPLeftMenuNavigation/*.{swift,jpg}'

end
