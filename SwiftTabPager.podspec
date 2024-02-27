Pod::Spec.new do |s|
  s.name = 'SwiftTabPager'
  s.version = '2.0.2'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'SegmentedView with full UI control.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Tab Bar with full UI control. You can bind viewControllers and views with SegmentedView.  
                       DESC

  s.homepage         = 'https://github.com/artsimonyan23/SwiftTabPager'
  s.authors = { 'PROJECT_OWNER' => 'USER_EMAIL' }
  s.source = { :git => 'https://github.com/artsimonyan23/SwiftTabPager.git', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/*.{swift}'
  s.swift_version = '5.0'

  s.subspec 'Resources' do |re|
    re.ios.deployment_target = '10.0'
    re.source_files = 'Source/Resources/*.{swift}'
  end

  s.subspec 'Extensions' do |ext|
    ext.ios.deployment_target = '10.0'
    ext.source_files = 'Source/Extensions/*.{swift}'
  end

end
