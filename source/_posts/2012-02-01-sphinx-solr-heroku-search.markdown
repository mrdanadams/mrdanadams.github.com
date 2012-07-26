---
comments: true
date: 2012-02-01 10:00:00
layout: post
slug: sphinx-solr-heroku-search
title: Sphinx versus Solr and other Heroku search solutions
wordpress_id: 280
categories:
- Ruby / Rails
tags:
- heroku
- solr
- sphinx
---

{% img featured /images/heroku_search.png %}

A recent Heroku-hosted Rails application required fulltext search of the content including field boosting. The best options quickly narrowed down to [Solr](http://lucene.apache.org/solr/) and [Sphinx](http://sphinxsearch.com/). I'll detail some of the reasons Solr won and the differences between the two.

<!-- more -->



## Available search solutions





### Solr



[Solr](http://lucene.apache.org/solr/) is quickly becoming the de-facto search solution, even outside the Java / JVM spaces. It's fast, scales, is rock solid, and has a great feature set including advanced features like stemming, nearness, fuzzy queries, search suggestion, and spatial search.

Integration with Heroku is provided by [Websolr](http://addons.heroku.com/websolr), one of the first Heroku add-ons. [Sunspot](http://sunspot.github.com/) is a great gem and highly recommended.



### Sphinx



[Sphinx](http://sphinxsearch.com/), provided via the [Flying Sphinx add-on](http://addons.heroku.com/flying_sphinx), is also quite popular due to it's ability to quickly index and search nearly any SQL database, great search features, and blindingly-fast indexing speeds. As we shall see, it comes with important limitations due to it's design.



### IndexTank



[IndexTank](http://indextank.com/documentation/heroku-addon) used to be a great option for Heroku search until it got bought by LinkedIn. It's now [open source on github](https://github.com/linkedin/indextank-engine) but no service currently provides a hosted solution (yet).



### Database search



Barely worth mentioning, some would say, database search is an option if you need cheap search with minimal features. Projects like [acts-as-tsearch](http://code.google.com/p/acts-as-tsearch/) provide integration but don't appear to be well-supported.



### Host your own



You don't **have** to host your search on Heroku or use one of their add-ons. For instance, run your own [Elastic Search](http://www.elasticsearch.org/) cluster on EC2 and use it from Heroku as you would any other service. A great option if Heroku doesn't yet support what you need or provide what you want.



## Solr versus Sphnix



Wanting to go with something that fit our requirements yet was easy to use, we chose to go with Websolr add-on for Heroku (at least for now). Consider your own requirements but here are my reasons for Solr over Sphinx.

A critical factor is the design of each solution. Solr is a collection of documents in which each document may be updated (replaced) and, upon commit, a new searcher is created for the updated index. It also supports fast reloads of the index not requiring a reload of the entire index. This provides better support for indexes not read-only or read-mostly. Furthermore, Solr is schema-less, supports dynamic fields, and knows nothing about your SQL data model.

Sphinx, conversely, is designed to quickly index and search a SQL database. While this provides significantly faster indexing than Solr (since it can connect directly to your database) it limits you to searching the fields in your data model. Sphinx is also optimized for read-mostly or read-only data meaning less frequent, and more complex, indexing.

Sphinx is new to Heroku to the extent they don't (yet) officially support running it against Heroku dedicated databases. It's primarily designed to work with Amazon RDS.

Sphinx doesn't support partial updates to an index: it's all or nothing. You can use a "delta index", containing just the changed documents, and search that and the main index. A cron job merges them every night to keep the delta index from becoming too large. There is more delay on when you see documents in the index, since there is no immediate indexing, and it's more moving parts.

It's not clear that delta indexes will really work at all across multiple Heroku dynos given how the processes are set up and how it's distributed.

See [this question](http://stackoverflow.com/questions/1284083/choosing-a-stand-alone-full-text-search-server-sphinx-or-solr) for additional info on the differences between them.

Which search solution have you used or considered?

