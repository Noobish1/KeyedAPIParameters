Pod::Spec.new do |s|
    s.name                      = "KeyedAPIParameters"
    s.version                   = "2.0.0"
    s.summary                   = "A concept for API parameters in Swift"
    s.homepage                  = "https://github.com/Noobish1/KeyedAPIParameters"
    s.license                   = "MIT"
    s.author                    = { "Blair McArthur" => "blair.mcarthur@icloud.com" }
    s.platform                  = :ios, '10.0'
    s.source                    = { :git => "https://github.com/Noobish1/KeyedAPIParameters.git", :tag => s.version.to_s }
    s.requires_arc              = true
    s.source_files              = "KeyedAPIParameters/**/*.swift"
    s.module_name               = "KeyedAPIParameters"
    s.swift_version             = "5.0"
end
