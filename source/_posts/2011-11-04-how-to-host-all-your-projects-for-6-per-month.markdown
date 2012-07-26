---
comments: true
date: 2011-11-04 10:00:00
layout: post
slug: how-to-host-all-your-projects-for-6-per-month
title: How to host all your projects for $6 per month
wordpress_id: 141
categories:
- Tools
- Wordpress
tags:
- cdn
- java
- rails
- wordpress
---

Looking for hosting of your personal projects or WordPress site(s) but don't want to pay the price for specialized services or shared servers that limit your access? Here's how to run your own server on the cheap including a CDN (Content Distribution Network), specifically for one or more WordPress blogs.

<!-- more -->

For developers with the know-how to set up and manage a server the options for hosting are endless. At one point, if you wanted to host a project you could take some old hardware you had lying around, throw linux on it, and you have yourself a server. Hosting is so cheap now this no longer makes sense.

In my case I have personal projects including at least 2 blogs as well as random projects like a Rails / MongoDB app. I need a server to host it on but don't want to pay a premium, especially when traffic is low. If a project takes off it can be moved to bigger, redundant setups.

## The basic setup

{% img /images/architecture.jpg %}

The overall setup for a new project looks like this:

* $8 for a domain name on godaddy (if exposing to the world). For strictly private stuff (like a staging site) Dyn.com provides free dynamic hostnames.
* $6 / month for a small VPS. You heard that right. Keep reading.
* $30 for several months of a CDN. Optional but highly recommended.
* [Source control via git and Dropbox](/2011/github-free-private-git-repositories-dropbox/) with projects backed up regularly using Dropbox

Both the VPS and the CDN can be used for all your projects so the cost for a new project might be just the domain name.

## Shared, specialized, and VPS hosting

Let's say you want to host a WordPress blog. What are your options?

{% img /images/wordpress-com.jpg %}

You could, of course, just use [wordpress.com](http://en.wordpress.com/products/) which is an example of a specialized hosting service optimized around WordPress and providing enhanced features. However, like most specialized hosts, you are limited in what you can do. In fact, just removing ads will cost you $30 / yr, a custom domain is at least $12 / yr, and extra storage starts at $20 / yr. Customizing the theme is $30 / yr. Not a lot but it can add up especially for multiple blogs. Not sure what the options are for installing custom plugins. Keep in mind most of the wordpress.com features are bundled in the [Jetpack plugin](http://wordpress.org/extend/plugins/jetpack/) which can be used with any WordPress install.

{% img /images/wpengine-logo3.jpg %}

Another option would be something like [WP Engine](http://wpengine.com/pricing/) which provides live and staging sites and a bundled CDN but starts at $40. Probably not a fit for a couple low-traffic side projects.

## Shared hosting

Another option is shared hosting like [DreamHost](http://dreamhost.com/) which starts at $9 / month for shared and $15 / month for a tiny VPS. Services like this often provide LAMP stacks and other related tools like phpMyAdmin out of the box but lock down your access. You probably have FTP access, might have SSH access, and definitely don't have root access.

If you want to host Java or Rails apps you'll need a separate, specialized host started around $9 / month. 

## VPS Hosting

{% img /images/OpenVZ-logo.jpg %}

Technologies like [OpenVZ](http://wiki.openvz.org/) have made it possible for hosting providers to offer dirt-cheap hosting of virtual machines. You sign up, they assign you an IP address and create a new VM, and you are off and running.

With hosting providers like [VPSFuze](http://vpsfuze.com/) (what I use) you can get an Ubuntu server with root access, 40 GB storage, 1200GB of transfer, 512 - 1024 MB RAM, and a dedicated IP address for $6 / month. Even a larger server with 2-4GB RAM is only $22 / month. After using this service for a while now I still only run one VM, haven't had any outages, and have been really pleased with the support.

For the price of less than a sandwich per month you can host WordPress / Java / Rails / whatever. Since I've got SSH access I can mount the filesystem locally (using [Transmit](http://www.panic.com/transmit/)) and root access lets me do whatever I like. You can even run a VNC server if you want.

## CDN (Content Distribution Network)

{% img /images/maxcdn-logo.jpg %}

A CDN allows you to offload a lot of transfer to your VPS and serve the content from the "edges" of the internet resulting in faster page load times for you visitors. On my WordPress blogs the only content returned from the VPS itself is the page HTML; everything else is served by 3rd-party services or the CDN.

There are a number of options for CDNs. I use [MaxCDN](http://www.maxcdn.com/): it's $30 for 1 TB ($40 / TB after that), has a great admin panel, and works great. Over the course of a year that's $2.50 / month. Unless you have a large amount of transfer you'll have a hard time finding a CDN that offers better features and price. [Amazon's CloudFront](http://aws.amazon.com/cloudfront/) is also an option but the price only becomes cheaper after 300 GB / month or so. Once you have a lot of transfer there is a different class of CDNs available to you but for small sites and personal projects, MaxCDN is great.

Using the CDN in a WordPress install is fairly easy:

1. Create a "pull zone" in the CDN. Any requests to this will pull the content from your site and cache them in the CDN and distribute them around the world. All requests for static assets (JS, CSS, etc) will go to the CDN rather than your VPS.
2. Create a CNAME (or alias) to the pull zone. Whoever controls your domain name will allow you to do this. This maps a URL like cdn.yoursite.com to the host name your CDN will provide for the pull zone.
3. Enable CDN support in the [W3 Total Cache plugin](http://wordpress.org/extend/plugins/w3-total-cache/). This will rewrite all static asset references to your CDN.

## Measure performance and optimize

{% img /images/GTMetrics.jpg %}

[GTmetrix](http://gtmetrix.com/) is a great, free tool for measuring performance. It will tell you a lot about the user experience and how to improve it including page load times, Google PageSpeed results, and YSlow results. You can retest as much as you want and the results are aggregated over time so you can see performance over the long run.

W3 Total Cache is sort of a one-stop-shop for WordPress performance. It really is excellent. See this post as a starting point for [configuring W3TC](http://www.wpbeginner.com/plugins/how-to-install-and-setup-w3-total-cache-for-beginners/).

Using W3TC with minification and combination of JS and CSS, page and query caching, and serving of assets from the CDN you should be able to get < 1s (at least < 2s) load times on a blog with a reasonable page weight.

## What's your setup?

Do you have a different setup that works well or have other services you use?
