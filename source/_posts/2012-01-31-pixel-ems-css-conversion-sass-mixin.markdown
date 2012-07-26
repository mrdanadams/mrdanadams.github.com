---
comments: true
date: 2012-01-31 14:00:00
layout: post
slug: pixel-ems-css-conversion-sass-mixin
title: Better pixel to EMs CSS conversion with a Sass mixin
wordpress_id: 271
categories:
- CSS
tags:
- sass
- scss
---

{% img featured /images/sass.png %}

While working on a project (to be announced) creating [responsive design](/2011/fluid-grids-responsive-design-thematic-wordpress/) templates from PSDs, I wanted to structure the positions and sizings in a way that allowed the greatest flexibility and sanity. Enter [EMs](http://www.alistapart.com/articles/howtosizetextincss). A great technique but requires conversion of pixels to EMs based on the current font size leaving you with cryptic "0.875em" and "1.125em" expressions throughout your CSS. Not the most maintainable code. A [Sass mixin](http://sass-lang.com/) allows expressing measurements in pixels in code while using EMs in the final output.

**UPDATE:** I've published the code I use in a bunch of projects as a gist: [PX to EMs conversion](https://gist.github.com/2237465)

<!-- more -->


## Motivation and Usage



Say you have a base font size of 16 pixels and want something 25 pixels. You could express it this way:

```css
width: 1.5625em /* 25 / 16 */
```

Perhaps a better version would be the following:

```scss
@include scale(width: 25);
```

Which would result in the same output.

In fact, we can create a version allowing us to express any CSS expression where we use pixels to do the conversion:

```scss
/* the simplest version */
@include scale(line-height, 30)

/* overrides the default 16px with a different base font size */
@include scale(line-height, 30, 25)

/* short-hand specifying 2 properties with the same value */
@include scale(width height, 125);

/* a property taking multiple values. output: padding: 0em 1.5625em; */
@include scale(padding, 0 25, 16);

/* A property allowing non-size values (passed through unchanged) accepting multiple properties
output: text-shadow: #0d6e28 0.0625em 0.0625em, #777 0em 0em 0.125em;
*/
@include scale(text-shadow, (#0d6e28 1 1) (#777 0 0 2), 16);
```



## scale Sass mixin (and function)



The following is the mixin and function I ended up with allowing each of the given usages:

{% gist 2237465 %}

Moving this out into a custom extension in Ruby would have made the code cleaner but would have added an external dependency. Having the mixin in the same .scss makes it easier to work with (for now).

The largest improvement I would make to this is it's dependence on the base font size. Ideally, whenever you call `scale()` it could inspect the current font size in the stylesheet and automatically pick the best one rather than assuming 16px or having to specify it.



## A new unit



Another approach could be to introduce a new Sass unit: pem (px + em = pem). This would allow extending Sass to automatically interpret a measurement in this unit and translate to EMs in the final output based on the current font size:

```css
#foo { font-size: 18pem; width: 50pem; }
```

Assuming a base font size of 16 this would result in:

```css
#foo { font-size: 1.125em; 2.778em; }
```

What approaches have you taken to deal with the pixel / EM relationship?
