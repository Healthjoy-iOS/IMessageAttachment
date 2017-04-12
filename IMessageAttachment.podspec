Pod::Spec.new do |s|

  s.name = 'IMessageAttachment'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Photo attachment control from iMessage app'
  s.homepage = 'https://github.com/nekromarko/IMessageAttachment'
  s.author = { 'Mark Prutskiy' => 'makroo@yandex.ru' }
  s.source = {
    :git => 'https://github.com/nekromarko/IMessageAttachment.git',
    :tag => '1.0.0'
  }
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.source_files = 'IMessageAttachment/Classes/**/*'
  s.resource_bundles = {
    'IMessageAttachment' => ['IMessageAttachment/**/*']
  }
  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit', 'AVFoundation', 'Photos'
end
