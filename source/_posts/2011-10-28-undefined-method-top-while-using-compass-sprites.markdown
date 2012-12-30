---
comments: true
date: 2011-10-28 01:58:23
layout: post
slug: undefined-method-top-while-using-compass-sprites
title: '"Undefined method ''top''" while using Compass sprites'
wordpress_id: 21
keywords: Compass, Spriting, Sprites, SASS, SCSS, Undefined method top, Wordpress, CSS
categories:
- CSS
- Wordpress
tags:
- compass
- css
- sass
- sprites
- wordpress
---

I ran into the error `undefined method 'top' for nil:NilClass` while attempting to use the sprites feature of [Compass](http://compass-style.org/) in Wordpress. After a bit of digging through the Compass sources I found the solution.

<!-- more -->

The error you get is this:

```
NoMethodError on line ["17"] of /Users/dadams/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/compass-0.11.5/lib/compass/sass_extensions/sprites/sprite_methods.rb: undefined method `top' for nil:NilClass
Run with --trace to see the full backtrace
```

If your settings are aren't correct Compass will attempt to loop through a bunch of images (which it can't find) and one of them is null thus the error. You are also likely to see this error:

```
NoMethodError on line ["68"] of /Users/dadams/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/compass-0.11.5/lib/compass/sprite_importer.rb: undefined method `Error' for Compass:Module
```

I found the following to be true and important while configuring your project:

* All icons are relative to your images path and can't be outside of it.
* You can't sprite the images directly under images/. They must be a in subfolder such as images/icons.
* You can't have your scss file(s) in the root directory (which I did for simplicity since I only had one file). Make a "sass" directory and put it in there.
* Make sure you are using relative assets in your config file, especially for Wordpress. Otherwise it creates an absolute path to the images which is a pain if it's in a theme.

Here's the final config I ended up with:

```ruby
http_path = "/"
css_dir = "."
sass_dir = "sass"
images_dir = "images"
javascripts_dir = "scripts"
relative_assets = true
```

See [this thread](http://groups.google.com/group/compass-users/browse_thread/thread/8e655d6706ca6d2d) for more info.

