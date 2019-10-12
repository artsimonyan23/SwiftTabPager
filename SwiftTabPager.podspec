Pod::Spec.new do |s|
  s.name = 'SwiftTabPager'
  s.version = '0.1.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Test version'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This is a test version!!!
                       DESC

  s.homepage         = 'https://github.com/artsimonyan23/SwiftTabPager'
  s.authors = { 'PROJECT_OWNER' => 'USER_EMAIL' }
  s.source = { :git => 'https://github.com/artsimonyan23/SwiftTabPager.git', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/*.{swift}'
  s.swift_version = '5.0'
end