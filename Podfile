# Podfile
platform :ios, '9.0'

def include_testing_pods
    pod 'Quick'
    pod 'Nimble'
end

use_frameworks!

target 'FeedbackApp' do
  pod 'Kingfisher', '~> 4.6'
end

target 'FeedbackAppFileStore' do
  pod 'Marshal', '~> 1.2'
end

target 'FeedbackAppTests' do
  include_testing_pods
end

target 'FeedbackAppUITests' do
  include_testing_pods
end

target 'FeedbackAppDomainTests' do
  include_testing_pods
end

target 'FeedbackAppFileStoreTests' do
    include_testing_pods
end
