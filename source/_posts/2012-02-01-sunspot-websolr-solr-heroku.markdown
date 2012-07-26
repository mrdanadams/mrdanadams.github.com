---
comments: true
date: 2012-02-01 16:00:00
layout: post
slug: sunspot-websolr-solr-heroku
title: Using Sunspot, Websolr, and Solr on Heroku
wordpress_id: 287
categories:
- Ruby / Rails
tags:
- heroku
- solr
---

Having recently deployed a Rails app using Sunspot and Solr on Heroku, here are some tips for getting started, testing, searching, and deploying.

<!--more-->

## Getting the right gem

As noted in <a href="http://blog.derekperez.com/post/552826277/the-proper-websolr-gem-for-heroku" target="_blank">this post</a>, getting the right gem for Websolr is important (yet confusing): the Heroku documentation is not consistent on which gem to use. In short, use the <a href="https://github.com/onemorecloud/websolr-sunspot_rails" target="_blank">websolr-sunspot_rails</a> gem which tracks the version of <a href="http://sunspot.github.com/" target="_blank">Sunspot</a> needed by <a href="http://www.websolr.com/" target="_blank">Websolr</a>.

The following gems are used:

{% gist 2230763 Gemfile %}

UPDATE (per Nick Zadrozny):


> the docs at https://devcenter.heroku.com/articles/websolr are correct: You want to use Sunspot directly, not websolr-sunspot_rails. The only thing the devcenter document gets wrong right now is the version. The current version of Sunspot is 1.3.0. I'll add that to my todo list ;)
>
> The websolr-sunspot_rails gem was only needed for earlier versions of Sunspot in order to support the WEBSOLR_URL variable, which is supported natively in Sunspot as of its 1.2.0.
>
> So all you need is `gem 'sunspot_rails'` in your Gemfile and you're all set!


## Configuration

_config/sunspot.yml_ provides a base config file for development and production only. `ENV['SOLR_URL']` and `ENV['WEBSOLR_URL']` override any values in this file.

{% gist 2230763 solr.yml %}

## Starting Solr (locally)

Solr can be started (and stopped) locally with:

{% gist 2230763 run.sh %}

## Testing

If using rspec the following can get you started:

{% gist 2230763 rspec_solr.rb %}

Your search spec may look like this:

{% gist 2230763 search_spec.rb %}

The following allows Cucumber features not to explode:

{% gist 2230763 cucumber_config.rb %}

## Searching and paginating

Perform the search in the controller:

{% gist 2230763 search_controller.rb %}

In the template show results and paging:

{% gist 2230763 results.html.erb %}
