---
comments: true
date: 2011-11-22 10:00:00
layout: post
slug: starting-mongodb-mongoid-rails
title: Getting started with MongoDB and Mongoid on Rails
wordpress_id: 175
categories:
- NoSQL
- Ruby / Rails
tags:
- mapreduce
- mongodb
- mongoid
- nosql
- rails
---

Having recently delved into the world of [MongoDB](http://www.mongodb.org/) and [Mongoid](http://mongoid.org/) here's a few resources (some obvious and some not) I found quite handy.

<!-- more -->

## Start here

Be sure to start with the official [MongoDB](http://www.mongodb.org/display/DOCS/Home), [Mongoid](http://mongoid.org/docs.html), and [MongoDB Ruby driver](http://api.mongodb.org/ruby/current/file.TUTORIAL.html) documentation. There is a lot of good stuff in there.


## SQL to Mongo Mapping Chart

{% img /images/sql-to-mongo.jpg %}

If you prefer to learn by example, the official MongoDB docs have a great table of [SQL / MongoDB statement equivalents](http://www.mongodb.org/display/DOCS/SQL+to+Mongo+Mapping+Chart).


## MapReduce and server-side code execution

{% img /images/SQL-to-MongoDB.png %}

If you heavily use aggregates in SQL you will quickly miss them in MongoDB. Rick Osborne put together a great infographic on [translating SQL to MapReduce](http://rickosborne.org/blog/2010/02/infographic-migrating-from-sql-to-mapreduce-with-mongodb/) (at least in your head). Here's the [PDF version](http://rickosborne.org/download/SQL-to-MongoDB.pdf).

Also be sure to check out the reference on [server-side code execution](http://www.mongodb.org/display/DOCS/Server-side+Code+Execution).

[This gist](https://gist.github.com/865065) provides an example (in Java) of executing server-side code when MapReduce is too heavy and in-place updates are not possible.

What are your favorite MongoDB-related resources?
