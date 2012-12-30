---
comments: true
date: 2011-11-03 10:00:00
layout: post
slug: tips-thematic-wordpress-theme-framework
title: Tips for working with the Thematic WordPress theme framework
wordpress_id: 130
keywords: Thematic, WordPress, Wordpress theme framework, Wordpress theme
categories:
- Wordpress
tags:
- thematic
- wordpress
---

Based on my experience making a child theme on the <a href="http://themeshaper.com/thematic/" target="_blank">Thematic Wordpress theme framework</a>, here's some examples of extending the framework from adding dynamic CSS classes to entire new sections of content.

<!--more-->

## Enabling better post and body classes

Thematic has support for tagging your body tag and post wrapper div with lots of classes around the content. You can use these classes to target your styles based on tags, categories, and even post slug.

```php
// Unleash the power of Thematic's dynamic classes
define('THEMATIC_COMPATIBLE_BODY_CLASS', true);
define('THEMATIC_COMPATIBLE_POST_CLASS', true);
```

## Overriding the blog title and disabling the tagline

In my theme I wanted the blog title in the header to be different than the overall blog title and to hide the tagline.

```php
<?php
// hides the tagline
function childtheme_override_blogdescription() {}

function childtheme_override_blogtitle() { ?>
  <div id="blog-title"><span><a href="<?php bloginfo('url') ?>/" title="Dan Adams" rel="home">Dan Adams</a></span></div>

<?php }

add_action('thematic_header', 'childtheme_override_blogtitle', 3);
?>
```

## Adding a new section of content

Above the sidebar I wanted to add a new section of content without having to edit it in the admin. Also, by having it in the skin it would be in version control and I could migrate it from development to production without having to touch the database or make manual changes.

```php
<?php
// function that creates my new content
function childtheme_about_box() { ?>
  <div id="about-box" class="aside">
    <h3>About Dan</h3>
    <span class="avatar"></span>
    <!-- ... -->
  </div>
<?php }

// add the action to the extension point for content above the main sidebars
add_action('thematic_abovemainasides', 'childtheme_about_box', 20);
```

## Overriding the footer

Similar to the header, I preferred the footer content be in the theme.

```php
<?php
// note: optimally the date would be dynamic
function childtheme_override_siteinfo() { ?>
  &copy; 2011 Dan Adams
<?php }
add_action('thematic_footer', 'thematic_siteinfo', 30);
?>
```

## Making image captions variable width

This is a case where I simply did not like the default implementation and wanted to replace it entirely. For some reason, Thematic sets a fixed width on the image styles when inserting images with captions. This means the caption won't adjust to the width of it's container as images do and you can't change it via CSS because it's an inline style.

```php
<?php
// don't allow setting a width on the caption as it can't be styled. what were they thinking?
// see img_caption_shortcode()
// note: you could also use regex to strip it out of the original content rather than copy/pasting. but which is grosser?
function childtheme_caption_shortcode($str, $attr, $content=null) {
  extract(shortcode_atts(array(
    'id'  => '',
    'align' => 'alignnone',
    'width' => '',
    'caption' => ''
  ), $attr));

  if ( 1 > (int) $width || empty($caption) )
    return $content;

  if ( $id ) $id = 'id="' . esc_attr($id) . '" ';

  // we omit the width style at this point
  return '<div ' . $id . 'class="wp-caption ' . esc_attr($align) . '">'
  . do_shortcode( $content ) . '<p class="wp-caption-text">' . $caption . '</p></div>';
}

add_filter('img_caption_shortcode', 'childtheme_caption_shortcode', 10, 3);
?>
```

## Customizing the post meta (above and below content)

The post meta is the info about author, date, tags, category, etc listed just below the post title and below the post contents. In my theme, I wanted to omit the top meta info altogether and simplify the info at the bottom.

```php
// disables the top metadata block entirely
// note: these functions are detected and called automatically by thematic. no add_action() or add_filter() needed.
function childtheme_override_postheader_postmeta() { }

function childtheme_override_postfooter() {
  // creates a "Posted October 30, 2011 in Category" format with links o the category(s)
  echo '<div class="entry-utility">Posted ' . get_the_time(thematic_time_display()) . ' in ' . get_the_category_list(', ') . '</div>';
}
```

Anything you've had trouble with working with Thematic? What kinds of customizations have you made?