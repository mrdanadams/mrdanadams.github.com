---
comments: true
date: 2011-11-23 10:00:00
layout: post
slug: partials-ajax-form-submit-rails
title: Updating a DIV with partials after remote AJAX form submit in Rails 3
wordpress_id: 168
categories:
- Ruby / Rails
tags:
- ajax
- jquery
- rails
- ujs
---

Here's a simple way to submit a remote AJAX form in Rails 3 rendering a partial into a specific DIV on the page without marshaling content into JSON or creating the DOM manually.

<!-- more -->

Following the model of [Unobtrusive JavaScript (UJS)](http://www.simonecarletti.com/blog/2010/06/unobtrusive-javascript-in-rails-3/) we'll create a form POSTing remotely using AJAX. The return of the form will be the rendered result of a partial.

We start with the form to submit.

{% gist 2230354 view.html.erb %}

`:remote => true` indicates this should submit via AJAX. `":'data-update-target' => 'update-container'"` creates a [data attribute](http://ejohn.org/blog/html-5-data-attributes/) with the ID of the element to update after submit.

Elsewhere in the page we'll create the DIV to update (which could contain the form itself).

{% gist 2230354 updatetarget.html %}

To handle the return we'll add an event listener on the `ajax:success` event on any forms with the `data-update-target` attribute. This allows nicely supporting this functionality across the whole of the application and easily enabling it by adding the attribute.

{% gist 2230354 application.js %}

A few notes on this:

* We've used the [live() method](http://api.jquery.com/live/) to re-register the event handler for AJAX forms returned by the form submit.
* We could have allowed the value of the attribute to be a CSS selector rather than an ID if the flexibility were needed.


On the server side we'll create a handler in our controller:

{% gist 2230354 controller.rb %}

The content to be rendered should go in `/app/views/[controllername]/_preview.html.erb`. Without the content_type specified the content was expected to be JSON.

How have you extended Rails with unobtrusive JavaScript?
