#
# Be sure to run `pod lib lint ImageZoomViewer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ImageZoomViewer'
  s.version          = '0.1.9'
  s.summary          = 'ImageZoomViewer allow to view and zoom multiple images.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ImageZoomViewer is xib based code snippet that allows image viewing and zooming on window of the app
                       DESC

  s.homepage         = 'https://github.com/grofers/iOS-ImageZoomViewer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anubhav Mathur' => 'anubhav.mathur@grofers.com' }
  s.source           = { :git => 'https://github.com/grofers/iOS-ImageZoomViewer.git',:tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'ImageZoomViewer/Classes/**/*.{h,m}'
  s.requires_arc          = true

  s.resources = [ 'ImageZoomViewer/Classes/**/*.xib']
# s.resource_bundles = {
#  'ImageZoomViewer' => ['ImageZoomViewer/Assets/*.png']
#  }
#s.resource_bundles = {
#'ImageZoomViewer' => ['ImageZoomViewer/Classes/**/*.xib']
#}

# s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  #s.dependency 'AFNetworking', '~> 2.3'
end
