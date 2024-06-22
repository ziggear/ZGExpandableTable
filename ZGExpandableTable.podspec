Pod::Spec.new do |s|
  s.name         = "ZGExpandableTable"
  s.version      = "1.0"
  s.summary      = "An iOS TableView component that can recursively expand JSON hierarchies."
  s.homepage     = "https://github.com/ziggear/ZGExpandableTable"
  s.author             = { "ziggear" => "ziggear@gmail.com" }
  s.description  = <<-DESC
  An collapsable (expandable) UITableView for showing JSON object iOS. 用于 iOS 的可展开/折叠展示JSON对象的 UITableView
                   DESC
  s.license      = "MIT"
  s.platform     = :ios, "12.0"
  s.source       = { :git => "https://github.com/ziggear/ZGExpandableTable.git", :tag => '1.0.1' }
  s.source_files  = "ZGExpandableTable/*.{h,m}"
  s.public_header_files = "ZGExpandableTable/*.h"
end
