source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
project 'KeyedAPIParameters'

target 'KeyedAPIParameters' do
    pod 'SwiftLint', '0.20.1', :configurations => 'Debug'
end

target 'KeyedAPIParametersTests' do
    use_frameworks!
    inherit! :search_paths

    pod 'Quick', '1.1.0'
    pod 'Nimble', '6.0.1', :inhibit_warnings => true
    pod 'Fakery', '2.0.0'
end

swift_32 = ['SwiftLint', 'Quick', 'Nimble', 'Fakery']
swift4 = []

post_install do |installer|
    installer.pods_project.targets.each do |target|
        swift_version = nil
        
        if swift_32.include?(target.name)
            swift_version = '3.2'
        end
        
        if swift4.include?(target.name)
            swift_version = '4.0'
        end
        
        if swift_version
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = swift_version
            end
        end
    end
end
