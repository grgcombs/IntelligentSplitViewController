A UISplitViewController class that will intelligently rotate when placed inside a UITabViewController.
Normally the standard UISplitViewController doesn't hear about rotations when it's not the frontmost UI element (selected tab).
Note, this doesn't exactly sit well with Apple's human interface guidelines, but I've successfully released an app to the App Store 
using it.  (Seen at TexLege.com)

This class assumes you're loading via Interface Builder (in a Nib).  If not, you'll want to replication the notification registrations from awakeFromNib: and stick those in an init: method. 

See the included license file for more information on appropriate use of this class.

Greg Combs
http://www.sleestacks.com
http://www.texlege.com
