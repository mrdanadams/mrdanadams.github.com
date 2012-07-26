---
comments: true
date: 2011-11-01 16:00:00
layout: post
slug: wordpress-theme-sass-compass
title: Upgrade your WordPress theme CSS with Sass and Compass
wordpress_id: 39
categories:
- CSS
- Wordpress
tags:
- compass
- css
- sass
- wordpress
---

[Sass](http://sass-lang.com/) (particularly SCSS) could very well be the new CSS providing a better language for developers and designers to write better CSS faster than ever. [Compass](http://compass-style.org/) is a Sass framework offering many utilities for creating modern sites and cross-browser support. Although heavily tied to the Ruby world, both of these tools can easily be used in the context of a Wordpress theme to make your life (and the life of your users) better.

<!-- more -->

If you are looking for a slimmer alternative, [bourbon](https://github.com/thoughtbot/bourbon#readme) also provides many nice utilities. Have you used bourbon or alternatives? What did you think?

## What about compass-wordpress?

While there is a [compass-wordpress](https://github.com/pengwynn/compass-wordpress) plugin I gave it a shot and it simply didn't work. Since using compass directly isn't all that difficult I used compass directly as getting compass-wordpress up and running didn't seem worth the effort. Also the latest changes on github are from 2009 so I doubt it's still maintained.

## Install Compass

As shown on the [compass installation docs](http://compass-style.org/install/), installing Sass and Compass is pretty easy:

```sh
$ gem update --system
$ gem install sass
$ gem install rb-fsevent
$ gem install compass
```

(I installed rb-fsevent as it provides some platform-specific optimizations and Compass kept hinting I should.)

## Compass setup and configuration

Assuming you have an existing wordpress theme and want to use compass with it, you need only create a few files and folders. As posted previously on using [compass sprites with wordpress](/2011/undefined-method-top-while-using-compass-sprites/), there are some non-obvious details.

Here's the basic file and folder setup.

{% img /images/folder_setup.jpg %}
	
* **images/** is where you can put _non-sprite_ images
* **images/sprites** contains images to be combined into a sprite (such as icons)
* **sass/** contains any Sass files to be compiled to CSS. You likely only have one file but could also have IE- and print-specific stylesheets.
* **sass/style.scss** is your primary Sass to be compiled to your themes primary CSS file (which must be in the theme root)
* **config.rb** contains your compass configuration (see below)

Use the following for a basic config.rb:

```ruby
http_path = "/"
css_dir = "."
sass_dir = "sass"
images_dir = "images"
javascripts_dir = "scripts"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions.
# note: this is important in wordpress themes for sprites
relative_assets = true
```

To start, create the files and folders but move your existing style.css to sass/style.scss. This is probably a good start:

```css
@import "compass";
@import "compass/reset"; /* actually creates styles so put after all your imports*/
```

## Watch for and make changes

Now that your project is set up, open a terminal and have compass watch for changes:

```sh
$ cd yourproject
$ compass watch
```

This will watch for changes to your style.scss and create a new style.css. Did you have any problems setting this up or use it differently?


