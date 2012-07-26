---
comments: true
date: 2011-11-04 16:00:00
layout: post
slug: state-of-the-rails-stack-a-survey-of-the-rails-ecosystem
title: 'State of the rails stack: A survey of the Rails ecosystem'
wordpress_id: 154
categories:
- Ruby / Rails
tags:
- rails
- ruby
---

I recently stepped back and took a look at the Rails stack to see what's available for someone approaching it for the first time. Especially with the proliferation of projects on github, the Rails ecosystem has really exploded. In some areas it now faces much the same problem as the Java world in having too many options. Here's what I found from virtual machines to UI testing.

<!-- more -->

I'm sure I'll leave some out so please feel free to suggest your favorites (there's just too much to get all of it).

## Virtual Machines

Check out this humorous and informative talk on [why you should use JRuby or Rubinius in production](http://www.engineyard.com/blog/2011/ruby-mri-jruby-and-rubinius-throwdown-brodown/). Engine Yard now supports hosting on both the alternate RVMs.

The [Ruby MRI](http://en.wikipedia.org/wiki/Ruby_MRI) (or Matz' Ruby Interpreter) is the primary Ruby interpreter and the reference implementation. The default RVM and probably your best bet unless you have a specific reason for going away from it.

[Rubinius](http://rubini.us/) is an alternate implementation that, rather then interpreting Ruby code, turns it into efficient machine code. It current supports MRI 1.8.7 but 1.9.2 support is not ready for prime time. See this post on looking under the hood about [what makes Rubinius fast](http://www.engineyard.com/blog/2010/making-ruby-fast-the-rubinius-jit/).

[JRuby](http://jruby.org/) allows you to run Ruby in the JVM and access to the Java ecosystem and all that comes with it. It offers real threading and lots of garbage collection options.

[Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/) is a fork of Ruby by the same guys who did Passenger (Phusion) to improve garbage collection and memory usage using 33% less on average, better performing memory allocation, and improved debugging tools around memory usage.

## Web Servers

[Phusion Passenger](http://www.modrails.com/) (mod_rails) is a free container that works with Apache or nginx to provide easier deployment, automatic error recovery, and separation of apps so they don't crash each other.

[nginx](http://wiki.nginx.org/) is a free HTTP server that focuses on high performance and simple configuration. It can be used as both a web server and a reverse proxy. While smaller in scope and feature set than Apache, it's very popular and powers some big name sites.

[lighttpd](http://www.lighttpd.net/) (aka "lighty") is designed to be small-footprint and good at serving static content. Seems to have fallen out of favor at this point since it's interface is FastCGI and better options are available.

[Mongrel](http://en.wikipedia.org/wiki/Mongrel_(web_server)) is Ruby-based, doesn't make user of FastCGI, and is typically deployed behind nginx or similar. Has fallen out of favor. Move along. Nothing to see here. See [Mongrel2](http://mongrel2.org/) which is language-agnostic.

[Unicorn](http://unicorn.bogomips.org/) is designed for Rack applications serving requests on low-latency, high-bandwidth connections sitting behind a reverse proxy (such as nginx). [Rainbows!](http://rainbows.rubyforge.org/) is a fork for longer requests and slow clients.

See this post on [github usage of Unicorn over Mongrel](https://github.com/blog/517-unicorn).

[Thin](http://code.macournoyer.com/thin/) is a Rack-based server including some of the best parts of Mongrel and designed to be small and fast. Often deployed with nginx.

[pow.cx](http://pow.cx/) is a lightweight Ruby web server for Mac for development only boasting super-simple installation and configuration.

## Reverse Proxy / Load Balancing

As above, nginx is very popular.

[HAProxy](http://haproxy.1wt.eu/) is also quite popular and specifically designed for high availability and load balancing. 

Note these two aren't mutually exclusive and [can be used together](http://alex.cloudware.it/2011/10/simple-auto-scale-with-haproxy.html).

[Varnish](https://www.varnish-cache.org/about) is a very popular caching HTTP reverse proxy. See this post for [an intro on life with Varnish](http://www.engineyard.com/blog/2010/varnish-its-not-just-for-wood-anymore/).

## Hosting

I looked specifically at solutions that were low cost on entry but would allow for scale. While this list is not exhaustive it should provide an idea of what's available.

[Engine Yard](http://www.engineyard.com/products/cloud/pricing) offers cloud and managed cloud hosting with a small app starting at $100-400 / month.

[Rails Machine](http://railsmachine.com/) offers Rails-specific hosting providing scaling, backup, etc on the platform. No prices listed.

[Cloud Foundry](http://www.cloudfoundry.com/) is a PaaS offered by VMware. It's currently free while in beta.

[Amazon EC2](http://aws.amazon.com/ec2/) is always an option.  Instances start at $.02 / hour (for micro) ($15 / month). Could be paired with something like [RightScale](https://www.rightscale.com/s/create-account.php?sd=Free) to scale apps easily. [Rubber](https://github.com/wr0ngway/rubber/wiki) makes deploying and managing instances easier.

[Rackspace](http://www.rackspace.com/cloud/cloud_hosting_products/servers/) offers  both cloud and managed cloud solutions. Think of it as EC2 with support. Cloud servers start at $0.015 / hr ($10 / month) but that price will go up quick. A production site would likely be a couple hundred per month or a few thousand for a large deployment (I know this because I priced out a large deployment for a client). They also offer more traditional hosting like dedicated and private cloud.

[Heroku](http://www.heroku.com/) offers Rails-specific hosting with lots of support for databases and 3rd party integration. Scaling is easy. Smallest configuration possible is $35 with several hundred $ per month easily possible with a site in production.

Of course, there are cheaper shared hosted solutions like [site5](http://www.site5.com/p/ruby/) (starting at $6 / month) and [HostGator](http://www.hostgator.com/shared.shtml) (about the same) but that wouldn't work for a non-typical app.

VPS hosting (such as through [VPSFuze](http://vpsfuze.com/pricing.html)) starts at $6 / month for a VPS with up to 1GB RAM, 40GB storage, a dedicated IP, and root access. If you can do the install and config yourself it's the cheapest and most flexible option.

## Configuration management and deployment

[capistrano](https://github.com/capistrano/capistrano/wiki/) offers awesome scripted deployment. [Rubber](https://github.com/wr0ngway/rubber/wiki) extends this to EC2.

[Puppet](https://www.linux.com/learn/tutorials/325201-introduction-to-puppet-streamlined-system-configuration) could be good for managing configuration.

## Error handling, notification, and monitoring

While not strictly Rails related (although some services like New Relic do support Rails) this is always part of the picture.

There is, of course, [monit](http://mmonit.com/monit/) for keeping on eye on your processes.

[New Relic](http://newrelic.com/pricing) lets you see inside your app and how it's performing. There is even a free version but the real plans start at $24 / month / server ($49 month to month).

[Scout](https://www.scoutapp.com/subscriptions) offers hosted server monitoring starting at $159 / month.

[Server Density](http://www.serverdensity.com/) offers hosted server monitoring with lots of nifty features starting at $11 / server / month and $2 / site / month.

If you want to track custom custom data see this post on [how Etsy tracks everything](http://codeascraft.etsy.com/2011/02/15/measure-anything-measure-everything/) using [graphite](http://graphite.wikidot.com/).

[Erlywarn](http://erlywarn.com/) is simpler server monitoring for checking if the site is up or not. Starts at 1 Euro / month / site.


## Source control

Well, it's [git](http://git-scm.com/) of course. However, you need somewhere to put your repos other than your local machine.

[github](https://github.com/) is an obvious choice starting at $7 / month for personal and $25 / month for business plans.

[bitbucket](https://bitbucket.org/plans) is essentially a clone of github owned by Atlassian. Unlike github, however, it offers free unlimited private and public repositories (shared with up to 5 people) and starts at $10 / month from there.

For a very small team (read: yourself) you could always [create free private git repositories with Dropbox](/2011/github-free-private-git-repositories-dropbox/).


## Testing

[rspec](http://rspec.info/) is quite popular although has somewhat been displaced by [minitest](http://metaskills.net/2011/03/26/using-minitest-spec-with-rails/) in Rails 3.1. [Shoulda](https://github.com/thoughtbot/shoulda) offers more matchers.

Get your BDD on with [behavior driven development using Cucumber](http://cukes.info/).

[Evergreen](https://github.com/jnicklas/evergreen) looks like an interesting way to run your [Jasmine](http://pivotal.github.com/jasmine/) JavaScript unit tests.

[timecop](https://github.com/jtrupiano/timecop) looks neat for testing date- or time-related code.

[capybara tests acceptance](https://github.com/jnicklas/capybara) and has a [WebKit extension](https://github.com/thoughtbot/capybara-webkit).

[Fabrication](http://fabricationgem.org/) looks great for generating test data.

[simplecov](https://github.com/colszowka/simplecov) can give you some code coverage metrics.


## Continuous Integration

[Travis](http://travis-ci.org/) looks new and interesting. It's a distributed build system and in alpha at the time of this writing.

[Integrity](http://integrityapp.com/) may be worth checking out although it doesn't (yet) support 1.9.2.

[CruiseControl.rb](https://github.com/thoughtworks/cruisecontrol.rb) is by the guys at ThoughtWorks.

Of course you could [run your Rails build in Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Configuring+a+Rails+build).


## Background processing / Job management

There seem to be only two real contenders in this space.

[delayed_job](https://github.com/tobi/delayed_job) which requires active_record and is great for most situations. There is a [delayed_job admin](https://github.com/trevorturk/delayed_job_admin) but it's fairly lame looking.

[resque](https://github.com/defunkt/resque#readme) is the new hotness, requires redis, and is great if you have lots of jobs to run or require more than most. There is a [resque MongoDB fork](https://github.com/ctrochalakis/resque-mongo) if you're into that kind of thing.


## Rails Admin Interfaces

Unfortunately there isn't much here except to write your own (which many do).

[Typus](https://github.com/fesplugas/typus) is a "control panel for Rails applications to allow trusted users to edit structured content". See here for a [Typus demo](http://demo.typuscmf.com/admin/dashboard).

[ActiveAdmin](http://activeadmin.info/) is probably your best bet for getting a really nice UI over your active record.

[rails_admin](https://github.com/sferik/rails_admin) is a "Rails engine that provides an easy-to-use interface for managing your data". See here for the [rails_admin demo](http://rails-admin-tb.herokuapp.com/) (username@example.com / password) which isn't nearly as ugly as the login page.


## File upload and image handling

[Dragonfly](https://github.com/markevans/dragonfly) is as rack framework for on-the-fly image handling.

[magickly](https://github.com/afeld/magickly) offers URL-based image on-demand image manipulation (requires Dragonfly). There is a [hosted instance](http://magickly.jux.com/).

[Paperclip](https://github.com/thoughtbot/paperclip) offers easy file attachment for ActiveRecord.


## IDEs / Editors

I personally like [RubyMine](http://www.jetbrains.com/ruby/) (I just use the plugin for IntelliJ) although [Sublime Text 2](http://www.sublimetext.com/2) is a great general-purpose editor.

Eclipse doesn't appear to offer much here although there is [EasyEclipse](http://www.easyeclipse.org/site/distributions/ruby-rails.html) and [Aptana RadRails](http://www.aptana.com/products/radrails).

I've heard good things about the [NetBeans Rails support](http://netbeans.org/ruby/).

What did I miss? Have any favorites not on the list?
