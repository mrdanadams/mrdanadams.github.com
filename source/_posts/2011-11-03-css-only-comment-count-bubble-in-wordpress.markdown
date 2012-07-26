---
comments: true
date: 2011-11-03 16:30:00
layout: post
slug: css-only-comment-count-bubble-in-wordpress
title: CSS-only comment count bubble in WordPress
wordpress_id: 131
categories:
- CSS
- Wordpress
tags:
- css
- thematic
- wordpress
---

{% img featured /images/bubble.jpg CSS-only comment bubble showing the comment count %}

One of the customizations I made to the [Thematic framework](http://themeshaper.com/thematic/) for this theme was bubbles next to any post that had comments displaying the number of comments. And, just because I could and to keep the page weight down, I made the bubbles in CSS. The result is shown above and here's the code behind it.

<!-- more -->

## Adding the comment count markup

We'll add a filter that will add the markup we want just above the post title.

```php
// add the comment count to the title so we can style a  badge for it
function childtheme_filter_posttitle($title) {
	return '

[' . get_comments_number() . '](' . get_permalink() . ')

' . $title;
}

add_filter('thematic_postheader_posttitle', 'childtheme_filter_posttitle', 10, 1);
```

Something odd I ran into: if you have Disqus comments enabled and link to the Disqus thread div by id Disqus will hijack your link and change the text to something like "2 Comments and 0 Reactions". Anyone know how to disable this without hacking the Disqus js (it wasn't important to me so I didn't bother)?

## Adding a CSS class on whether the post has comments or not

In order to hide the comment bubble when there are not comments, I'll add a CSS class to the post as to whether it has comments or not. I could have simply omitted the comment count HTML itself but this is easier to change with CSS, will give me the option of restyling it later if I want to show it, and will allow me to style other things in the future based on the same class.

```php
// indicate if a post has comments or not
// note: $c is an array of strings
function childtheme_filter_post_class($c) {
	$c[] = get_comments_number() > 0 ? 'has-comments' : 'no-comments';
	return $c;
}

add_filter('post_class', 'childtheme_filter_post_class', 10, 1);
```

## Creating the CSS-only comment bubble

See this post for [creating CSS comment bubbles](http://nicolasgallagher.com/pure-css-speech-bubbles/) in detail. Here's the CSS (actually, Sass) I ended up with:

```css
/* okay, fine. so i just wanted to see if i could make a bubble in css... */
.comment-count {
	float: right;
	margin-top: -.5em;
	margin-right: -1.5em;

	a {
		font-size: 1em;
		font-weight: bold;
		display: block;
		color: #333;
		text-decoration: none;
		padding: .25em .75em;
		border: 2px solid #777;
		@include border-radius(.5em);
		background-color: white;
		@include single-box-shadow(black * .4, 1px, 1px, 7px, false, false);
	}
	&:before { /* outer triangle */
		content:' ';
		position: absolute;
		width:0; height:0;
		margin-top: 2em; margin-left: .5em;
		border: .35em solid;
		border-color: #777 transparent transparent #777;
	}
	a:before { /* inner triangle. using the outer element so they are both on the left */
		content:' ';
		position: absolute;
		width:0; height:0;
		margin-top: 1.5em; margin-left: -.31em;
		border: .25em solid;
		border-color: white transparent transparent white;
	}
}
/* don't show if there are no comments */
.no-comments .comment-count { display: none; }
```


