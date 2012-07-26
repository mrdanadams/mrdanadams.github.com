---
comments: true
date: 2011-11-02 16:00:00
layout: post
slug: choosing-wordpress-theme-frameworks
title: 11 awesome WordPress theme frameworks (and how to choose one)
wordpress_id: 83
categories:
- Wordpress
tags:
- thematic
- wordpress
---

In creating this blog I did a lot of research on options for theming in WordPress including the best theme frameworks. Here are those that look the best and why I finally chose to go with [Thematic](http://themeshaper.com/thematic/).

<!-- more -->

## A brief intro to WordPress theming

There are a few ways to do a theme for WordPress:
	
1. Grab a free one from the theme gallery, buy a pre-made theme, or hire someone to make one.
2. Write one from scratch including all the PHP files and plugin hooks needed or start with one and modify it directly.
3. Use a theme framework and create a child theme extending only those things to make your theme unique.

Child themes allow you to start with a base theme and override / extend it with custom PHP, CSS, JavaScript, etc where needed to customize. The frameworks are typically built with a solid foundation, lots of extension points, and accomodate plugins, SEO, and other concerns. You can make small changes or (as I did) throw out all the existing styles and go from scratch.

Theme frameworks are also attractive over option #2 since they can be upgraded later without changing the child theme (much).

After considering the options, I decided to go with a theme framework. I want integration with existing plugins while still being able to customize. For doing multiple projects having a framework I'm familiar with means faster work on the next theme and more predictable results.

## Comparing theme frameworks

When comparing theme frameworks they tend to differ in these ways:

* **Price:** The theme framework itself, child themes, and support
* **Modern support:** Does it support the latest techniques and best practices?
* **Weight/flexibility:** Some tend to be minimal going for clean code while some tend to have bloated markup supporting any kind of design
* **Admin features:** How much can you change the theme in the admin?
* **Theme-specific plugins:** Some themes pre-package support for things like related/popular posts and Twitter
* **Extensibility:** Is the theme modular? Does it have extension points?
* **Popularity:** Do designers and developers know this framework? Is there a community around it?
* **Maturity:** Some frameworks are quite recent (which could be a good thing) but some have been battle-tested
* **Support:** For both free and commercial frameworks, are they updated frequently and maintained / improved actively?
* **Target user:** Is the framework targeted at individual developers? Large agencies? Non-technical users?

Commercial theme frameworks like [Genenis](http://www.studiopress.com/themes/genesis) are specifically targeted at agencies, developers, and designs working for clients who need a cheap, reliable way of producing lots of sites predictably. Many nice-looking child themes are provided at a low price as a starting point for custom client themes.

For my purposes I didn't need a lot of control in the admin since I preferred to have all design aspects in the code. For those with clients, however, having robust admin control over the UI and design could be very attractive.

What other criteria do you consider when choosing a theme framework?

## WP Theme Framework (paid)

{% img /images/wtf.jpg %}

[WP Theme Framework](http://wtf.dev7studios.com/) is $6 for a single license and $300 for themes you want to sell. It's got admin options, lots of theme-specific plugins for related posts, popular posts, Twitter, and more.

## Buffet (free)

{% img /images/buffett.jpg %}

[Buffet](http://www.zy.sg/the-buffet-framework/) is a minimal theme framework with support for SEO, microformats, extension points, and bundles CSS frameworks like [960gs](http://www.960.gs/) and [Blueprint](http://www.blueprintcss.org/).

## Starkers (free)

{% img /images/starkers.jpg %}

[Starkers](http://starkerstheme.com/) is a bare-bones, minimal framework to the point of eliminating all css classes that are presentational and not semantic. To quote the framework's site:

> if you want something super-simple to start out with, stripped down to the bare minimum of markup, use _Starkers_.

## Headway (paid)

{% img /images/headway.jpg %}

[Headway](http://headwaythemes.com/) goes for $164 for the developer license and $87 for personal. It's claim-to-fame is a comprehensive [visual editor](http://headwaythemes.com/features/visual-editor/). 

## Genesis (paid)

{% img /images/genesis.jpg %}

[Genesis framework](http://www.studiopress.com/features) is $60 for the framework and about $25 for each child theme (a $300 bundle is available for all current and future themes). There are a number of nice child themes to start with and is used by many prominent bloggers and the popularity means you could find a designer that already knows it.

## Thesis (paid)

{% img /images/thesis.jpg %}

[Thesis framework](http://diythemes.com/) is $164 for unlimited use and $87 for one-time use, offers lots of design options through the admin, and is very popular.

## Foghorn (free)

{% img /images/foghorn.jpg %}

[Foghorn](http://wptheming.com/foghorn/) is a fork of the Twenty Eleven theme modified to be responsive.

### Hybrid (free with paid support)

{% img /images/hybrid.jpg %}

[Hybrid](http://themehybrid.com) is popular, has a number of child themes, good support, and looks promising. Using the framework is free but joining the community and getting any kind of support is $25 / year.

## Roots (free)

{% img /images/roots.jpg %}

[Roots](http://www.rootstheme.com/) is based on the HTML5 boilerplate, Blueprint CSS, 960gs, and Starkers. It's aims to de-wordpress the market and URLs so your site is as close to hand-rolled as possible. Theme options are minimal so this framework is great if you want something that appears pure. Hosted on github and documentation looks pretty good.

## Whiteboard (free)

{% img /images/whiteboard.jpg %}

[Whiteboard](http://whiteboardframework.com/) is based on the [Less CSS grid framework](http://lessframework.com/) and offers easy responsive design from the start. It features clean, flexible markup, and moderate admin features.

## Thematic (free)

{% img /images/thematic.jpg %}

[Thematic](http://themeshaper.com/thematic/) is a mature, very popular theme framework with great documentation, a sample child theme that could be skinned for a great theme, a number of other child themes, SEO support, and compatible with many plugins.

## Why I chose Thematic

I chose Thematic for it's price, maturity, popularity, and extensibility. I found it to be a very flexible framework with many extension points that could be used to easily create some very different themes. The admin features are pretty minimal / typical so it may not be a fit for an agency or designer with clients they wish to be self-sufficient but it's great for the developer.

## Creating child themes for theme frameworks

Creating a child theme is actually quite simple. Starting with a parent theme, another theme you will be extending, create a style.css file which acts as the manifest providing basic info about the theme and the primary stylesheet.

The [Child Themes guide on the Wordpress Codex](http://codex.wordpress.org/Child_Themes) is an excellent start. Yoast has a [visual anatomy of a theme](http://yoast.com/wordpress-theme-anatomy/) which is excellent as well.

What has your experience been working with theme frameworks? What is your preferred framework?

