---
comments: true
date: 2012-02-02 16:00:00
layout: post
slug: beware-using-active_admin-and-sunspot-rails-gems-together
title: Beware using active_admin and Sunspot Rails gems together
wordpress_id: 284
categories:
- Ruby / Rails
tags:
- solr
---

If you are using [Active Admin](http://activeadmin.info/) and the [Sunspot](http://sunspot.github.com/) gem for Rails, beware: they conflict on the search method leading to some very confusing results.

<!-- more -->

Active Admin has a dependency on [meta_search](https://github.com/ernie/meta_search) which provides a `.search()` method on Active Record classes. Sunspot attempts to provide the same method, aliased from `solr_search`, but only if the method does not already exist.

In short, searching can be done using `solr_search()` rather than `search()`:

```ruby
@search = Profile.solr_search do
	keywords params[:q]
	paginate page: params[:page], per_page: page_size
end

@results = @search.results
```

