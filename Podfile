platform :ios, '11.0'
inhibit_all_warnings!

def linter
  pod 'SwiftLint', '0.27.0'
end

target 'TimeTracker' do
  use_frameworks!
  
  linter

  target 'TimeTrackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TimeTrackerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Tracker' do
  use_frameworks!

  linter

  target 'TrackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
