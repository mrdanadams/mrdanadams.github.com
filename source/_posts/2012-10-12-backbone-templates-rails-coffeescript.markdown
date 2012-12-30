---
layout: post
title: "Embedding Backbone Templates in Rails with CoffeeScript"
date: 2012-10-12 12:30
comments: true
categories: 
keywords: CoffeeScript, Backbone JS, Rails, Ruby on Rails, Views
tags:
- javascript
- coffescript
- backbone
- rails
---

[Multiline string support in CoffeeScript](http://coffeescript.org/#strings) offers a great way to embed your [Backbone templates](http://backbonejs.org/#View-render). In this approach, you can easily edit your templates while still taking advantage of JS minification, combination, and client-side caching.

<!-- more -->

## Registering and caching templates

We'll create a top-level object in our namespace to hold our templates which are cached for efficient use across many view instances.

{% gist 3880219 templates.coffee %}

## Using the templates 

An example of using the template in a Backbone view:

{% gist 3880219 view.coffee %}

In this case I'm registering and caching our templates on load. If we had more templates, or they were used less often, we could register them to be compiled on-demand which might be more efficient.

