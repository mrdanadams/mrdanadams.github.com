---
comments: true
date: 2012-04-18 17:38:39
layout: post
slug: ios-universal-frameworks-xcode
title: Round-up of iOS universal frameworks with Xcode
wordpress_id: 414
categories:
- iOS
---

{% img featured http://mrdanadams.com/wp-content/uploads/2012/04/ios_xcode.jpg iOS universal frameworks with Xcode %}

If you are looking to share code between projects or distribute a 3rd party framework (such as a product API) a bit of googling will find you a solution. Or two. Or three. The solutions are all similar with some subtle differences. Here I've collected the best solutions I've found (going back to 2008) and which one worked well for me.

<!-- more -->
For the impatient, I recommend this [iOS universal framework](https://github.com/jverkoey/iOS-Framework) solution.


## The problem: dynamic linked libraries, architectures and performance


All the system libraries for iOS are dynamically linked. This allows dynamic loading and sharing of libraries between applications for more efficient memory management. In order to simplify the handling of applications, this is not allowed for libraries shipped with an app even if two apps use the same library. These libraries must be statically linked. This is an issue simply because Xcode 4 does not directly support creating static iOS frameworks.

Additionally, libraries need to support multiple architectures: arm6 / arm7 on the devices and[ i386 when run in the simulator](http://stackoverflow.com/questions/7874519/ios-simulator-on-mac-is-running-i386-architecture-not-armv7). Distributing a fat binary allows developers to drop the framework into their project but embedding the whole fat binary in the application should be avoided as it can substantially increase the size of the deployed app.

The developer experience is also important. For instance, if you are developing the framework in the context of an app that is using it, minimizing turn-around time for changes in the framework appearing in the app could be a big win (as it likely is for most).


## Documented solutions




### iOS-Framework by Jeff Verkoeyen


My preferred [solution is by Jeff Verkoeyen](https://github.com/jverkoey/iOS-Framework) (jverkoey). It's an evolution on the older solutions and focuses on an easier, faster build process while maintaining a good integration experience for users and optimal deployment. It still has some improvements to be made:



	
* A manual process. It's easy, but not exactly a 1-step process. He's documented it well enough that you could do it for a new project quickly if you couldn't remember all the steps.
* Bundling resources requires more work on the part of both the framework author and users. Code-only frameworks shouldn't have to deal with this, luckily.




### Blog post by Jonah Williams of Carbon Five


[This post](http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/) offers a well-written guide and explanation of the problem. However, it's not as comprehensive as the others. It also uses the framework in a way that isn't entirely representative of the way your users will. This increasing the risk that you might be missing something big when cutting a distribution. However, it's a good guide and shares a lot of similarities with jverkoey's approach.


### iOS-Universal-Framework by Karl Stenerud


[iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework) offers a way of bending Xcode to your will so it will produce a static framework by introducing a new project template, possibly making life better if you need to do this a lot. The solution by jverkoey specifically improves on the method in a some marginal, yet important, ways such as resource handling and compile time. As with [Chris Boyd](http://www.chrisboyd.net/2011/06/creating-ios-framework-projects/), this method has made some people very happy.

See [iOS-Universal-Library-Template](https://github.com/michaeltyson/iOS-Universal-Library-Template) for a similar project not focused on frameworks.


### Blog post by db-in


As noted by jverkoey, the approach in [this post](http://db-in.com/blog/2011/07/universal-framework-iphone-ios-2-0/) is essentially the same as iOS-Universal-Framework but not as good.


## Useful Links


An assortment of useful links related to this:

* [Compile, Build or Archive problems with Xcode 4](http://stackoverflow.com/questions/5584317/compile-build-or-archive-problems-with-xcode-4-and-dependancies)
* [Getting headers into frameworks in xcode](http://stackoverflow.com/questions/989738/how-to-get-headers-into-framework-in-xcode)
* [Xcode workspaces](http://developer.apple.com/library/ios/#featuredarticles/XcodeConcepts/Concept-Workspace.html) and [adding projects to workspaces](http://developer.apple.com/library/mac/#recipes/xcode_help-structure_navigator/articles/adding_a_project_to_a_workspace.html)
* [Xcode docs on dynamic libraries](http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/OverviewOfDynamicLibraries.html#//apple_ref/doc/uid/TP40001873-SW)
* [Creating Frameworks](https://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPFrameworks/Tasks/CreatingFrameworks.html#//apple_ref/doc/uid/20002258-BAJDHDAF)
* [Framework Programming Guide](http://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPFrameworks/Concepts/WhatAreFrameworks.html#//apple_ref/doc/uid/20002303-BBCEIJFI)
* [Bundle Programming Guide](https://developer.apple.com/library/mac/#documentation/CoreFOundation/Conceptual/CFBundles/AboutBundles/AboutBundles.html)
* [Creating static libraries for iOS](http://www.icodeblog.com/2011/04/07/creating-static-libraries-for-ios/)
* [Building a Universal Framework for iOS](http://spin.atomicobject.com/2011/12/13/building-a-universal-framework-for-ios/)


Older, probably totally out of date (but possibly informative):

	
* [Sharing code across iPhone apps](http://www.clintharris.net/2009/iphone-app-shared-libraries/)
* [Making your own iPhone framework](http://www.cocoanetics.com/2010/05/making-your-own-iphone-frameworks-in-xcode/)
* [Creating a framework for the iPhone](http://accu.org/index.php/articles/1594)
* [Building static libraries for the iPhone](http://blog.stormyprods.com/2008/11/using-static-libraries-with-iphone-sdk.html)
* [Universal Framework](http://the.ornyx.net/post/1222915969/universal-framework)
* [Building Static Libraries in Xcode for the iPhone](http://mobileorchard.com/sharing-compiled-code-building-static-libraries-in-xcode-for-the-iphone/)
* [Code sharing via static libraries and cross-project references](http://mobileorchard.com/code-sharing-via-static-libraries-and-cross-project-references/)



