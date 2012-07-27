---
layout: post
title: "Migrating a WordPress custom theme to Octopress / Jekyll"
date: 2012-07-26 16:51
comments: true
categories: 
---

I decided to move from a VPS-hosted Wordpress with a custom theme to Octopress. Here's how I did it, why, some things to watch out for, and a comparison of the experience.

<!-- more -->

## Why are you hating on Wordpress?

I'm not. Wordpress is popular for good reason and I've used it for a while. However, it's not without it's warts and I was often left wanting. Here's what I require from whatever is running my blog:

* Creating posts should be easy
* Hosting should be [very cheap](how-to-host-all-your-projects-for-6-per-month) ($s / month or even free)
* It should be fast. The output should be optimized for better user experience and SEO. Page load times should be low. [Google PageSpeed](https://developers.google.com/speed/pagespeed/) rating should be > 90%.
* I want to spend time authoring, not maintaining. I don't want to think about if my blog is running or not. I certainly don't want to spend my evening repairing a hacked Wordpress or fixing a failed upgrade.
* I want to be able to customize the theme or functionality if needed.

It's easy to get most of these with Wordpress but difficult to get all. For instance, you could get a cheap and fast hosting service but you may be limited in what you can customize (themes and plugins). [Managed services](http://wpengine.com/pricing/) that provide this often start in the range of [$27 / mo](https://purchase.websynthesis.com/plans.aspx?o=non).

A VPS with nice specs can be had for $6 / mo but you may still have performance issues in a shared environment. This also requires you to setup (and maintain) everything yourself.

Octopress gets much closer to meeting all the requirements:

* Hosting static files is fast, secure, and cheap or even free (with [github pages](http://pages.github.com/) or the [AWS free usage tier](http://aws.amazon.com/free/))
* Once it's up and running, it's set and forget
* Octopress themes are easy to customize and writing plugins for Jekyll or Liquid is easier than for Wordpress.

### Optimization & performance

[W3 Total Cache](http://wordpress.org/extend/plugins/w3-total-cache/) is a great plugin. It's a one-stop-shop for best practices in client-side optimization. Despite this, getting performance on par with static files with a self-hosted Wordpress isn't trivial.

Consider asset combination and minification, for instance. You need to know which scripts can be combined and which can't (such as the lightbox library that, when combined, simply broke).

With a single download for each asset, using image sprites or data-uri images, the correct caching headers, and a CDN for static assets you'd think that would be enough. But it's not. I found my VPS suffering odd latencies upwards of 500ms establishing a connection to the server. A simple test with [ab](http://httpd.apache.org/docs/2.2/programs/ab.html) proved failure to handle large traffic spikes. The VPS provided [great RAM for the money](http://vpsfuze.com/pricing.html) but the Wordpress content caching ate that up quickly.

Let's back up for a second. The vast majority of Wordpress blogs consist of static content. Rendering PHP or hitting a MySQL db on each view is foolish. Why not use something like [this plugin](http://wordpress.org/extend/plugins/static-html-output-plugin/) to export all content to S3 or some other service for cheap and scalable hosting? I could have thrown [varnish](https://www.varnish-cache.org/) in the mix but that's a lot of moving parts for rendering static content. It's simply the wrong tool.

Sometimes the old tech works best. Simplify. For blogs, serving static HTML is an elegant and simply solution. Most of the features Wordpress provides are focused on the editorial side. Why let that dictate how the content is served?

### Post editing

When editing posts in Wordpress I would often write in HTML mode due to bugs in the WYSIWYG editor. For instance, it would sometimes insert errant P tags or start inserting DIVs instead of Ps altogether. It makes a difference in the rendered markup and how the post displays. It also makes the content less semantic.

There are some nice features such as inserting and thumbnailing images. As you'll see, however, a more minimalist approach using Octopress is even easier.

### Trackbacks

I don't really care about them. It was an interesting idea in the blog world for cross promotion but I care about real comments from real users. Trackbacks are spam at this point.

### Remote / mobile posting

Not currently supported with Octopress. However, it's conceivable to have a REST API talking to authoring apps that does a git clone / pull, authors a single post, and publishes. Log in with your github account and use your existing editors. It could certainly be done. I never did this anyway so I don't miss it.

Octopress, unlike Wordpress, does allow offline authoring thanks to git.

### Post scheduling

The [editorial calendar plugin](http://wordpress.org/extend/plugins/editorial-calendar/) is great if you author posts ahead of time and want them auto-published on a schedule.

This is another instance where things often just don't work. After one of the Wordpress upgrades I noticed my posts weren't published as scheduled. Awesome. A little googling, cron jobs, and editing of PHP later it was working again. It's a great feature, when it works (which is true of a lot in Wordpress).

## Making the move

### Wordpress custom theme to Octopress theme

Octopress ships with a default theme. At first glance, it feels like working with a Wordpress theme framework. Here, however, you copy the entire theme down and edit the files directly rather than overriding base files in the parent theme that can be upgraded later (essentially the way WP was before parent themes were introduced).

The default Octopress theme is well coded and nicely structured. Like any theme, it has it's own markup structure and styles. Migrating from a custom theme (child theme based on the Thematic theme framework), I already had my own markup and CSS that, since I'm just moving the site, should ideally stay the same.

So that's what I did.

I started with the default theme and stripped it down to something minimal enough to fit my needs (you can also copy in files later if needed). Grabbing the rendered HTML for the pages on my WP site I made the page markup conform to that. I was able to move the SCSS in without any changes at all.

### Featured images

Some posts have a featured image at the top. I include the images with a specific CSS class so they can be targeted:

```
img featured /images/ios_xcode.jpg iOS universal frameworks with Xcode
```

### Image thumbnails

Creating thumbnails in Wordpress is quite easy. With a little help, they are even easier in Octopress. I want to take a source image and say "insert this image, optimized, into my content and make it a certain size while keeping the aspect ratio". Nothing I found did exactly that so I created a Jekyll plugin, [jekyll-thumbnailer](https://github.com/mrdanadams/jekyll-thumbnailer). Using it is quite simple:

```
thumbnail /path/to/local/image.png 50x50<
```

### Compass sprites & image paths

If you want to use [Compass sprites](http://compass-style.org/help/tutorials/spriting/) like this:

```scss
$sprites: sprite-map("sprites/*.png");
.foo a { background:sprite($sprites, foo-icon) no-repeat; }
```

The generated sprite image will be put in the source directory. That's fine except the references in the CSS will look like `/source/images/sprites-2t3h2t31h3.png`. To reference the images at the correct path add this to config.rb:

```
http_generated_images_path = "/images"
```

### exitwp

[exitwp](https://github.com/thomasf/exitwp/) did the general conversion (including grabbing the post images) but it was pretty rough.

* I have pretty standard markup and it did things like convert lists into multiple lists (also indented incorrectly)
* I had to manually edit every single post
* It put in weird spacing
* It didn't preserve the more tag thus killing all my excerpts
* No support for images (or captions)

So I wouldn't say migrating the content is exactly seamless. In fact, this took the longest.

### Minor observations

A few observations after doing the migration:

* I found broken and extra markup being generated by Wordpress
* I eliminated a **ton** of extra CSS classes and ids from the markup to make it more minimal. Simply a side-effect of most theme frameworks.
* The delay to regenerate files when editing can be really, really long. Isolating files can help with that. Also, you may have to get out of the habitual saving after each edit.
* The default Octopress theme is well structured but verbose. I paired mine down to only a few files.
* I didn't care for the auto-capitalization
* The syntax highlighting (including the styles in the default theme) is great

## The final setup

Once set up, Octopress is pretty great. Author a new post:

```sh
rake new_post["My fancy new post"]
```

Run pow.cx to serve the files (you only need to do this once):

```sh
cd ~/.pow/
ln -s ~/path/to/my/octopress
```

Watch for changes:

```sh
rake watch
```

Once you are ready to publish:

```sh
rake generate
rake deploy
```

Don't forget to commit your source files and push to origin as well:

```sh
git commit -a -m "i made some changes"
git push origin source
```

Octopress and Jekyll are both awesome. I'm sure improvements could be made and I'm excited to see (and help with) them in the future. Generating static sites is by no means new in the CMS world but it's a great, simple alternative to Wordpress.

The sources for the blog are [on github](https://github.com/mrdanadams/mrdanadams.github.com/tree/source).
