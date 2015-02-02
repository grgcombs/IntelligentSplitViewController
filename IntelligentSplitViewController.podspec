Pod::Spec.new do |s|
  s.name         = 'IntelligentSplitViewController'
  s.version      = '1.2.0'
  s.license      =  { :type => 'Creative Commons' }
  s.homepage     = 'https://github.com/grgcombs/IntelligentSplitViewController'
  s.authors      =  { 'Greg Combs' => 'gcombs@gmail.com'}
  s.summary      = 'UISplitViewController subclass that works within a UITabBarController'
  s.description  = <<-DESC
                    This is a UISplitViewController subclass that will intelligently rotate it's contents when placed inside a UITabBarController.

                    Normally the standard UISplitViewController doesn't hear about rotations when it's not the frontmost UI element (selected tab). This is because Apple believes a UISplitViewController should be the top-most controller in the hierarchy. So when you rotate the device while switching back and forth between tabs of split views, your view controllers and UI elements start drawing in mismatched orientations.  Users don't like this nonsense.  But what do you do if your app *needs* split views within a tab view?  This.  This is what you do.
                   DESC
# Source Info
  s.platform     = :ios
  s.ios.deployment_target = '7.1'
  s.source       = { :git => "https://github.com/grgcombs/IntelligentSplitViewController.git", :tag => "v#{s.version}" }
  s.source_files = 'IntelligentSplitViewController.{h,m}'

  s.requires_arc = true
  
  s.xcconfig     = {
    'ONLY_ACTIVE_ARCH' => 'NO'
  }
end
