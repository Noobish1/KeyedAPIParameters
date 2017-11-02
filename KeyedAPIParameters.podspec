Pod::Spec.new do |s|
    s.name                      = "KeyedAPIParameters"
    s.version                   = "0.2"
    s.summary                   = "A concept for API parameters in Swift"
    s.homepage                  = "https://github.com/Noobish1/KeyedAPIParameters"
    s.license                   = "MIT"
    s.author                    = { "Blair McArthur" => "blair.mcarthur@icloud.com" }
    s.platform                  = :ios, '8.0'
    s.source                    = { :git => "https://github.com/Noobish1/KeyedAPIParameters.git", :tag => s.version.to_s }
    s.requires_arc              = true
    s.source_files              = "KeyedAPIParameters/**/*.swift"
    s.module_name               = "KeyedAPIParameters"
end
