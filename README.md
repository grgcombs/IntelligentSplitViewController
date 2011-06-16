IntelligentSplitViewController - It's almost omniscient!
=============
by **Gregory S. Combs**, based on work at:  
  
- [GitHub](https://github.com/grgcombs/IntelligentSplitViewController)  
- [TexLege](http://www.texlege.com)  

What Is This?
=============

This is a UISplitViewController subclass that will intelligently rotate it's contents when placed inside a UITabViewController.

Normally the standard UISplitViewController doesn't hear about rotations when it's not the frontmost UI element (selected tab). This is because Apple doesn't think split views should exist within any other view controller ... they think it should be the top-most. So when you rotate the device while switching back and forth between tabs of splitviews, your view controllers and UI elements start drawing in mismatched orientations, because your view hierarchy isn't "supported".  Users don't like this nonsense.  But what do you do if your app *needs*  split views in a tab view?  This.  This is what you do.

Note, as we've mentioned, this view controller hierarchy does not exactly fit with Apple's human interface guidelines, but I've successfully released an app to the App Store using this set up (almost exactly), as seen on [TexLege](http://www.texlege.com).

This class and the enclosed demo app assume that you are loading your tabBarController and splitViewControllers via Interface Builder (in a NIB/XIB file).  If you don't like using Interface Builder, then hopefully you know how to incorporate this class without much hand-holding.

I've also included (as a submodule) a more extensive implementation demo/template from Ziophase, [IntelligentTemplate](https://www.github.com/ziophase/IntelligentTemplate).

Change Log
=========================
- 	(6/16/11)  
	
	Added a more extensive template from Ziophase to help showcase more advanced controller hierarchies.  
		
- 	(5/23/11)  
	
	Added a demo application, to show you how I use it in my apps.  
	
	Improved the documentation (slightly).  
	
	Pointed out an alternative way to get a popover button without using `[super valueForKey:@"_barButtonItem"]`, in case that frightens you or irritates App Store reviewers.  (It hasn't proved problematic for me, yet).  

License
=========================

[Under a Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/)

![Creative Commons License Badge](http://i.creativecommons.org/l/by-sa/3.0/88x31.png "Creative Commons Attribution-ShareAlike")

Alternative, see the included license file for more information on appropriate use of this class.

