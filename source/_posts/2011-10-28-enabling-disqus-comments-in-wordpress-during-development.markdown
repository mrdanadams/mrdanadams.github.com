---
comments: true
date: 2011-10-28 13:28:27
layout: post
slug: enabling-disqus-comments-in-wordpress-during-development
title: Enabling Disqus comments in Wordpress during development
wordpress_id: 33
keywords: Disqus, Wordpress, Wordpress Development, Wordpress Comments
categories:
- Wordpress
tags:
- disqus
- wordpress
---

When working on a Wordpress theme on a development deployment (you aren't working on production, are you?) and using Disqus comments for commenting you may notice Disqus will not enable commenting if the site URL has changed from the one in the settings.

To get around this you can extend functions.php to enable Disqus during development. I have my local setup using a .dev domain which I can use to detect if I'm in development or not.

```php
<?php
// allows using Disqus on development deployments
function childtheme_disqus_development() { 
?>
  <script type="text/javascript">
  // see http://docs.disqus.com/help/83/
  var disqus_developer = 1; // developer mode is on
  </script>
<?php }

// only enable this if the server is a .dev domain name
if (strpos($_SERVER['HTTP_HOST'], '.dev') !== FALSE)
  add_action('wp_head', 'childtheme_disqus_development', 100);
```

Note that any comments made on the .dev domain will be set with that URL in Disqus (but you can delete the comments or migrate the domain names using the moderation panel later).

