---
comments: true
date: 2012-01-31 16:00:00
layout: post
slug: boosting-facebook-friends-omniauth-sunspot-solr
title: Boosting search results for Facebook friends with fb_graph, omniauth, Sunspot
  and Solr
wordpress_id: 292
categories:
- Ruby / Rails
tags:
- devise
- heroku
- solr
---

{% img featured /images/solr_facebook.png %}

Boosting in [Solr](/2012/sunspot-websolr-solr-heroku/) allows customizing search relevance to offer users the best experience. Here's the short and sweet on boosting at search time using the [Sunspot](http://sunspot.github.com/) gem so documents associated with other users who are your Facebook friends show up first.

<!-- more -->



## Grab the user's Facebook friends



This application allows users to register with their Facebook account using [devise](https://github.com/plataformatec/devise) and [omniauth](https://github.com/intridea/omniauth). On login, we'll use [fb_graph](https://github.com/nov/fb_graph) to get the user's Facebook friend ids and store them with the account. We'll also store their API key so we can refresh this info later to ensure the list is up to date. See this page for info on [getting started with omniauth and facebook](https://github.com/plataformatec/devise/wiki/OmniAuth%3a-Overview).

{% gist 2230436 user.rb %}



## Indexing Facebook ids for search



In our Active Record model we index the Facebook id of the user associated with the document to a "facebook_id" field:

{% gist 2230436 model.rb %}



## Searching and boosting by Facebook id



When searching we'll use [adjust_solr_params](https://github.com/sunspot/sunspot) and a [boost query with the dismax query parser](http://wiki.apache.org/solr/DisMaxQParserPlugin) to boost any documents matching the friend ids of the current user.

Note the use of solr_search() versus search() due to [a conflict with active_admin](/2012/beware-using-active_admin-and-sunspot-rails-gems-together/).

{% gist 2230436 controller.rb %}


