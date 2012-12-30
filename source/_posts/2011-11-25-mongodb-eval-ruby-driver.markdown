---
comments: true
date: 2011-11-25 10:00:00
layout: post
slug: mongodb-eval-ruby-driver
title: db.eval() and server-side updates on MongoDB with the Ruby driver
wordpress_id: 176
keywords: mongodb, eval, ruby, mongodb driver, rails
categories:
- NoSQL
- Ruby / Rails
tags:
- eval
- mapreduce
- mongodb
- rails
- ruby
---

If you need to update a number of documents in MongoDB, such as calculating simple statistics, [in-place updates](http://www.mongodb.org/display/DOCS/Updating) and [MapReduce](http://www.mongodb.org/display/DOCS/MapReduce) are available. There is a third option, eval(), allowing the [execution of arbitrary code server-side](http://www.mongodb.org/display/DOCS/Server-side+Code+Execution).

<!-- more -->



## Making a case for eval()



In-place updates are fast and atomic and should be used whenever possible. However, they can be very limiting. Consider this use case: a user performs an action marking two different documents: one a winner and another a loser. We calculate simple statistics on both based on the updates.

In-place updates are not an option since the statistics depending on updates to other fields are too complex to be expressed in a MongoDB update.

A second option is to grab both documents, calculate the statistics in Ruby, and save the changes. With many concurrent requests the time required to query the documents and process the update increases the window for a race condition. A small amount of inaccuracy is acceptable but should be limited.

A third option is in-place updates to update the simple counts on the documents and MapReduce to calculate the statistics later. The loss is setting up periodic jobs to trigger the MapReduce (not a big deal) and a window in which the data is out of date. For this application, the statistics power major functionality so having them out of date would affect the user experience.



## The good and bad of eval()



Using eval() allows us to quickly grab the documents, calculate the statistics, and update them in-database limiting the window in which the update takes place and eliminating translation between the application and database.

The most significant limitation to eval() is acquiring a write lock (server wide) by default. The 'nolock' option allows disabling this (see below).

See this page on [MongoDB concurrency and lock usage](http://www.mongodb.org/display/DOCS/How+does+concurrency+work) (in 2.0). Locking may not be an issue due to the yielding strategy for long-running operations.

Another limitation: "only one thread in the mongod process executes Javascript at a time (other database operations are often possible concurrent with this)". There is a ticket, [SERVER-4258](https://jira.mongodb.org/browse/SERVER-4258), to improve this but in the meantime we should be careful not to overuse javascript execution. It does appear, as with MapReduce and groups, effort is made to interleave the operations.



## eval() Basics



The mongo console provides best illustrates the basic usage:

{% gist 2230825 runCommand.txt %}

Note:

* 'args' is used to pass an array of arguments to our function which we'll see comes in handy
* nolock in necessary to prevent db.eval() from blocking the entire mongod process while running. This means the update will no longer be atomic but will allow other queries to be run. 
* The order of arguments is important and $eval has to be first.





## eval() from Ruby / Rails



This application is using Mongoid which provides no direct support for eval() and doesn't need to as the underlying Ruby MongoDB driver connection is easily accessible. The driver sources show this is how many operations are implemented anyway.

Now for the code:

{% gist 2230825 controller.rb %}

Note the get-calculate-update operation is done for each document individually rather than for both at the same time further decreasing the race condition.



## Final considerations



eval() could also be a fit for simple calculations on a few documents where MapReduce is too heavy-weight.

I have not yet performance tested this under high load so I can't comment. Based on performance considerations, MapReduce could be used to calculate the statistics.

How have you used eval() or considered using it? What for and what was your experience?

