IntelligentSplitViewController - It's almost omniscient!
=============
by **Gregory S. Combs**, based on work at:  
  
- [GitHub](https://github.com/grgcombs/IntelligentSplitViewController)  
- [TexLege](http://www.texlege.com)  

[![Build Status](https://travis-ci.org/grgcombs/IntelligentSplitViewController.svg?branch=master)](https://travis-ci.org/grgcombs/IntelligentSplitViewController)

What Is This?
=============

This is a UISplitViewController subclass that will intelligently rotate it's contents when placed inside a UITabBarController.

Normally the standard UISplitViewController doesn't hear about rotations when it's not the frontmost UI element (selected tab). This is because Apple believes a UISplitViewController should be the top-most controller in the hierarchy. So when you rotate the device while switching back and forth between tabs of split views, your view controllers and UI elements start drawing in mismatched orientations.  Users don't like this nonsense.  But what do you do if your app *needs* split views within a tab view?  This.  This is what you do.

Note, as we've mentioned, this view controller hierarchy does not exactly fit with Apple's human interface guidelines, but I've successfully released an app to the App Store using this set up (almost exactly), as seen on [TexLege](http://www.texlege.com). Others have successfully released apps using InteeligentSplitViewController, including a few "big name" development companies.

This class and the enclosed demo app assume that you are loading your tabBarController and splitViewControllers via Interface Builder (in a storyboard).  If you don't like using storyboards, then hopefully you know how to incorporate this class without much hand-holding.

I've also included (as a submodule) an alternative implementation demo/template from Ziophase, [IntelligentTemplate](https://www.github.com/ziophase/IntelligentTemplate).

Change Log
=========================

- 	(8/5/14)  

	Refactored for iOS 7, storyboards, ARC, and more.  

- 	(6/16/11)  
	
	Added a more extensive template from Ziophase to help showcase more advanced controller hierarchies.  
		
- 	(5/23/11)  
	
	Added a demo application, to show you how I use it in my apps.  
	
	Improved the documentation (slightly).  
	
	Pointed out an alternative way to get a popover button without using `[super valueForKey:@"_barButtonItem"]`, in case that frightens you or irritates App Store reviewers.  (It hasn't proved problematic for me, yet).  

License
=========================

[Under a Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/)

![Creative Commons License Badge](http://i.creativecommons.org/l/by/3.0/88x31.png "Creative Commons Attribution")

Alternative, see the included license file for more information on appropriate use of this class.

