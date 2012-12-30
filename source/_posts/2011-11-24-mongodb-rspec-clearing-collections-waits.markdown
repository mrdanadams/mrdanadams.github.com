---
comments: true
date: 2011-11-24 10:00:00
layout: post
slug: mongodb-rspec-clearing-collections-waits
title: Testing MongoDB with Mongoid, RSpec, and Rails
wordpress_id: 177
keywords: MongoDB, Mongoid, rspec, rails, nosql, testing, collecting waits, clearing
categories:
- NoSQL
- Ruby / Rails
tags:
- rails
- rspec
- mongodb
---

Whether using unit tests or rspec, you may find some support missing for testing your MongoDB-based application such as clearing the collections before test and waiting for updates to finish before proceeding. With a little Ruby both are easily supported.

<!-- more -->


## Clearing collections before test



Each test will populate the collection(s) under test with the necessary documents so we need to clear those collections before the test to make our world sane again. Tests that fail from the leftovers of other tests are no fun.

While you could do this in a super class, I'll add it to the RSpec config in spec_helper.rb:

{% gist 2230855 spec_helper.rb %}



## Waiting for updates and conditions



If the operation under test is an update to the database, you could easily create race conditions:

{% gist 2230855 controller_spec.rb %}

With the addition of a wait function in spec_helper.rb:

{% gist 2230855 wait_until.rb %}

We can now wait until the condition is true or fail after a short timeout if it is not:

{% gist 2230855 controller_spec2.rb %}



