Pod::Spec.new do |spec|
  spec.name     = 'StandardForm'
  spec.version  = '0.1.1'
  spec.license  = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage = 'https://github.com/StandardForm/StandardForm'
  spec.authors  = { 'Jason Nam' => 'contact@jasonnam.com' }
  spec.summary  = 'Form builder.'
  spec.source   = { :git => 'https://github.com/StandardForm/StandardForm.git', :tag => spec.version.to_s }
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '11.0'
  spec.source_files = 'Sources/StandardForm/**/*.swift'
end
