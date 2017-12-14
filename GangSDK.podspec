Pod::Spec.new do |s|
s.name         = "GangSDK"
s.version      = "1.0.0"
s.summary      = "GangSDK for ios"
s.description  = <<-DESC
                 GangSDK是为开发者提供的一套快速接入社群系统的开发框架，主要为了帮助开发者在自己的应用里快速构建社群系统。
                 社群系统包含两大功:
                 1、为用户们提供自己的社交圈，使他们交流更方便;
                 2、社群建设，使社群更具影响力，同时吸引更多的用户加入。
                 GangSDK包括三个部分：
                 GangCore：数据管理(所有网络请求接口管理理)
                 GangUI：界面展示(我们提供的UI布局)
                 GangUIResource：皮肤资源(我们为UI提供了多套资源,可选择替换使界面显示多样化)
                 DESC

s.homepage     = "http://www.gangsdk.com"
s.license      = "MIT"
s.author       = { "codone" => "593174331@qq.com" }

s.platform     = :ios, "8.0"
s.requires_arc = true
s.source       = { :git => "https://github.com/qunmeng/GangSDKiOS.git", :tag => s.version}

s.source_files  = 'GangCore/**/*', 'GangUIResource/*'
s.vendored_frameworks = 'GangCore/*.framework'
s.framework = 'libicucore'
s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

end
