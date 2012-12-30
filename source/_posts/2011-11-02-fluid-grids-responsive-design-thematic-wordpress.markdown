---
comments: true
date: 2011-11-02 10:00:00
layout: post
slug: fluid-grids-responsive-design-thematic-wordpress
title: Fluid grids and responsive design with the Thematic WordPress theme framework
wordpress_id: 82
keywords: Fluid grids, Responsive Design, Thematic, Wordpress, WordPress theme framework, CSS
categories:
- CSS
- Wordpress
tags:
- css
- fluid grids
- responsive design
- wordpress
---

[Fluid grids and responsive design](http://cantina.co/2011/10/31/responsive-design-resources/) are great techniques for improving user experience at differing screen sizes and devices. With a little CSS magic and an extension, Thematic can easily support this over the fixed-width layouts it ships with.

One of my goals when creating the theme for this blog was to not only end up with a nice theme but also learn something new and exhibit some best practices. After looking over many paid and free wordpress theme frameworks (as well as creating themes from scratch) I finally decided on using [Thematic](http://themeshaper.com/thematic/) (and I'm glad I did). Not leaving good enough alone, I threw in some Sass (including the Compass framework) and responsive design for a nicer user experience and wider device support.

<!-- more -->

## Fluid grids? Responsive design?

Fluid grids is a HTML and CSS technique for creating designs that respond to the users screen size and other parameters. As the screen size changes the design layout, font sizes, etc can adjust 
to give the user a better experience. This A List Apart article provides [a great intro to fluid grids](http://www.alistapart.com/articles/fluidgrids/).

[Responsive design](http://www.alistapart.com/articles/responsive-web-design/) goes further using mechanisms such as [CSS media queries](http://trentrichardson.com/2011/03/11/effective-example-of-css-media-queries/) to specifically support different devices and screens sizes to the point of effectively offering multiple interfaces over the same HTML with the same stylesheets.

## Supporting a fluid layout with Thematic

This theme uses as 2-column layout similar to the default shipped with Thematic: the main content on the left and the sidebar on the right with a header on top.

{% img /images/site_columns.jpg %}

The effect we are going for is to have the design max out at a certain width but adjust when the window is narrow. In a fixed-width layout the content would simply be cut off.

The trick is essentially to set the page div to adjust to the width available but max out at the fixed width. As for the columns, their width is based on a percentage of the parent width. In fact, everything in the page is expressed in either percent or "em"s allowing us to control the size and proportion of everything at once. If expressed in pixels we could not dynamically change the layout or font sizes.

## Adding a container DIV for the sidebars

I was surprised to find that the 2 column layout didn't have 2 outer column divs: there was one div for the entry content and multiple for the sidebars with no div around all the sidebars. While not strictly necessary to create the look we want, the CSS was simpler to have the sidebars organized into a single div (and made more sense semantically). With Thematic this requires a small extension in functions.php.

Looking in sidebar-extensions.php in the Thematic sources you'll find this:

```php
// Located in sidebar.php 
// Just before the main asides (commonly used as sidebars)
function thematic_abovemainasides() {
    do_action('thematic_abovemainasides');
} // end thematic_abovemainasides

// Located in sidebar.php 
// after the main asides (commonly used as sidebars)
function thematic_belowmainasides() {
    do_action('thematic_belowmainasides');
} // end thematic_belowmainasides
```

Looking in sidebar.php, you'll see these are extension points called before and after all the sidebars are rendered making it a perfect point to inject our new tag. We'll add `add_actions()` calls corresponding to the `do_action()` calls above in our functions.php in the child theme.

```php
<?php
// create functions to make the opening and closing tag of our container div
function childtheme_abovemainasides() { ?>
  <div id="aside-container">
<?php }

function childtheme_belowmainasides() { ?>
  </div><!-- #aside-container -->
<?php }

// add the action into the extension points
add_action('thematic_abovemainasides', 'childtheme_abovemainasides', 10);
add_action('thematic_belowmainasides', 'childtheme_belowmainasides');
?>
```

## Fluid grid CSS

We can now style the outer page div and the two inner content wrapping divs to respond to the page width.

```css
/* sets the max width and centers the contents */
#wrapper { max-width: 960px; margin: 0px auto; }

/* our 2 column containers expressed as % of the container width */
#container { float: left; width: 72.5%; margin-right: 2%; }
#aside-container { float: left; width: 24.25%; }
```

## Responsive design CSS

Now let's get it looking good at other screen resolutions. When the screen width is under a certain size we'll lay out the columns differently so it becomes a one-column layout with the sidebar coming after the main content.

If we resize the window to make it narrow you can see it changes to a single column (with the header also changing to fit a smaller width):

{% img /images/single_column.jpg %}

and the sidebar contents are now after the main content above the footer:

{% img /images/single_column_footer.jpg %}

The CSS for this is remarkably simple.

```css
@media screen and (max-width: 650px) {
	#container, #aside-container, #blog-title, #access { display: block; float: none; width: auto; margin: 0 3% 3% 3%; }
	body { font-size: 14px; line-height: 16px; }
}
```

We've changed all the container divs to take up the whole width of the available space except for a 3% margin. The base font size has also changed.

Are fluid grids and responsive design techniques you have tried or are familiar with? Did you have trouble adapting them?
