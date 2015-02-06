Pod::Spec.new do |s|
  s.name     = 'LSActionView'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'LSActionView is an alternative to UIActionSheet with a block-based API and a customizable look.'
  s.homepage = 'https://github.com/tinymind/LSActionView'
  s.author   = { "lslin" => "xappbox@gmail.com" }
  s.source   = { :git => 'https://github.com/tinymind/LSActionView.git', :tag => s.version.to_s}
  s.platform = :ios, '4.3'
  s.requires_arc = true  
  
  s.source_files = 'Classes/*'
  s.frameworks = 'Foundation', 'UIKit'
end