Pod::Spec.new do |s|

  s.name         = "HJArchitecture"
  s.version      = "0.0.2"
  s.summary      = "Base FMWK to make beautiful apps！"

  s.description  = <<-DESC
                   Groups the project,and you will see more clear,so you can use it more easyly.
                   DESC

  s.homepage     = "https://github.com/jixuhui/HJArchitecture"

  s.license      = "MIT"

  s.author       = { "jixuhui" => "hubbertji@163.com" }

  s.platform     = :ios, "7.0"

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/jixuhui/HJArchitecture.git", :tag => "0.0.2" }

  s.requires_arc = true
  
  s.source_files = 'HJArchitecture','*.{h}'

  s.subspec 'Common' do |cm|
  cm.source_files = 'HJArchitecture','Common/**/*.{h,m}'
  end

  s.subspec 'ThirdParty' do |tp|
  tp.source_files = 'HJArchitecture','ThirdParty/**/*.{h,m}'
  tp.dependency 'HJArchitecture/Common'
  tp.dependency 'Masonry'
  end

  s.subspec 'Task' do |tk|
  tk.source_files = 'HJArchitecture','Task/**/*.{h,m}'
  end

  s.subspec 'Service' do |ser|
  ser.source_files = 'HJArchitecture','Service/**/*.{h,m}'
  ser.dependency 'HJArchitecture/Task'
  ser.dependency 'HJArchitecture/Common'
  ser.dependency 'AFNetworking'
  end

  s.subspec 'DataSource' do |ds|
  ds.source_files = 'HJArchitecture','DataSource/**/*.{h,m}'
  ds.dependency 'HJArchitecture/Task'
  ds.dependency 'HJArchitecture/Service'
  end

  s.subspec 'DataController' do |dc|
  dc.source_files = 'HJArchitecture','DataController/**/*.{h,m}'
  dc.dependency 'HJArchitecture/DataSource'
  dc.dependency 'HJArchitecture/Common'
  dc.dependency 'MJRefresh'
  end

  s.frameworks = 'UIKit'
  
  s.resource_bundles = {
    'HJArchitecture' => ['Resources/*.png']
  }

end
