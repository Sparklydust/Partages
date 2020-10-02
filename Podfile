# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

inhibit_all_warnings!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13'
    end
  end
end

target 'Partages' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Partage

  pod 'TableViewReloadAnimation'
  pod 'Firebase/Analytics'
  pod 'Firebase/Storage'
  pod 'Google-Mobile-Ads-SDK'

end
