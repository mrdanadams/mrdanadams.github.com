---
comments: true
date: 2011-12-23 10:34:47
layout: post
slug: exclude-active-admin-js-css-rails
title: Excluding active_admin JS and CSS from your Rails app
wordpress_id: 226
categories:
- Ruby / Rails
tags:
- active_admin
- heroku
---

<a href="https://github.com/gregbell/active_admin" target="_blank">active_admin</a> is a cool gem for quickly creating an admin interface over your Active Record models. By default, it puts it's JS and CSS files into your app/assets folder which then get included in your application. Not what you want.

<!--more-->

## Excluding active_admin.js and active_admin.css.scss

Create the folders `app/assets/javascripts/admin` and `app/assets/stylesheets/admin` and move the files `active_admin.js` and `active_admin.css.scss` into these folders, respectively.

In your `app/assets/stylesheets/application.css.scss` you will find the following near the top:

```
 *= require_self
 *= require_true .
```

Change this to:

```
 *= require_self
 *= require_directory .
```

Do the same for `application.js`.

This changes what's included in application.css from anything under the stylesheets folder (and it's subfolders) and the contents of the application.css.scss file to only files directly under the stylesheets folder and the contents of the application.css.scss file. You should notice the active_admin files no longer being included. However, they are also no longer in active admin either.

## Re-including the files in active admin

The culprit is active_admin's asset_registration.rb and application.rb:

```ruby
def register_default_assets
  register_stylesheet 'active_admin.css'
  register_javascript 'active_admin.js'
end
```

To clear these and replace them with the new files, add the following to the bottom of config/initializers/active_admin.rb:

```ruby
config.clear_stylesheets!
config.register_stylesheet 'admin/active_admin.css'

config.clear_javascripts!
config.register_javascript 'admin/active_admin.js'
```

Active admin should be back to normal.

## Heroku deployment problems

When deploying to heroku, you may see something like this in the logs:

```
Started GET "/admin/login" for 146.115.108.146 at 2011-12-22 16:03:32 +0000

ActionView::Template::Error (admin/active_admin.css isn't precompiled):
    6:   <title><%= [

    7: 
    8:   <% ActiveAdmin.application.stylesheets.each do |path| %>
    9:     <%= stylesheet_link_tag path %>
    10:   <% end %>
  


    12:     <%= javascript_include_tag path %>
    11:   <% ActiveAdmin.application.javascripts.each do |path| %>
```

The files need to be precompiled for production, as noted in <a href="https://github.com/gregbell/active_admin/issues/483" target="_blank">this issue</a>. Add the following to `application.rb` (or config file of choice):

```ruby
config.assets.precompile += %w[admin/active_admin.css admin/active_admin.js]
```
