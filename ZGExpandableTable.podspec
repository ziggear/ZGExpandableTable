Pod::Spec.new do |s|
  s.name         = "ZGExpandableTable"
  s.version      = "1.0"
  s.summary      = "An iOS TableView component that can recursively expand JSON hierarchies."
  s.homepage     = "https://github.com/ziggear/ZGExpandableTable"
  s.author             = { "ziggear" => "ziggear@gmail.com" }
  s.description  = <<-DESC
  see github page
                   DESC
  s.license      = "MIT"
  s.platform     = :ios, "12.0"
  s.source       = { :git => "https://github.com/ziggear/ZGExpandableTable.git"}
  s.source_files  = "ZGExpandableTable/*.{h,m}"
  s.public_header_files = "ZGExpandableTable/*.h"
end
