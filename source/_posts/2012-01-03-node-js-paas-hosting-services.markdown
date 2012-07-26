---
comments: true
date: 2012-01-03 14:22:55
layout: post
slug: node-js-paas-hosting-services
title: Node.js PaaS hosting services
wordpress_id: 232
categories:
- Node.js
tags:
- heroku
---

{% img featured nodejs-logos.png %}

[PaaS](http://en.wikipedia.org/wiki/Platform_as_a_service) (Platform as a Service) with support for specific stacks is the latest wave of cloud-based hosting services. Awesome providers such as [Heroku](http://www.heroku.com/) show you why; simple (and often free) deployment and scaling of common stacks like [Rails](http://rubyonrails.org/). Here are the best known [Node.js](http://nodejs.org/) PaaS offerings.

<!-- more -->


## Heroku



[Heroku now offers Node.js support](http://devcenter.heroku.com/articles/node-js) which, as a huge Heroku fan, I'm glad to see. See [here](http://blog.heroku.com/archives/2010/4/28/node_js_support_experimental/) for the announcement and additional details. So far Heroku is my chosen Node.js host as I'm sure it is for many. Compared to the rest it appears to have the best support and be keeping up with the competition. For me, the pricing at Heroku and ease of use makes it a no-brainer for small projects or even just playing with Node.js.

Heroku mandates Node.js v0.4.7 and WebSockets are not yet supported. Dependency management requires [NPM](http://npmjs.org/) and [foreman](https://github.com/ddollar/foreman) (with a Procfile) is used to [create web and worker processes](http://blog.heroku.com/archives/2011/6/20/the_new_heroku_1_process_model_procfile/). See this page for details on [Heroku socket.io support](http://devcenter.heroku.com/articles/using-socket-io-with-node-js-on-heroku).



## DuoStack / dotCloud



[dotCloud](https://www.dotcloud.com/) (which acquired [Duostack](http://blog.duostack.com/)) now offers [Node.js support](http://docs.dotcloud.com/services/nodejs/). Like Heroku, you can get started for free and must use NPM for package management. The application structure is dotCloud-specific and uses [YAML build files](http://docs.dotcloud.com/guides/build-file/). WebSockets are not supported though socket.io provides fall-back to other methods. Documentation doesn't say if a specific Node.js version is required or what versions are supported.



## nodeSocket



[nodeSocket](http://www.nodesocket.com/) is currently in private beta. While the site doesn't offer much detail the [nodeSocket blog](http://blog.nodesocket.com/) has a peak under the covers.

A feature of note is getting root access to your VPS. While this sounds like a good thing it blurs the line between VPS hosting and a PaaS. Not needing to know host details is one of the reasons for a PaaS and why working with Heroku is so great. I'd love to hear the compelling reason to use nodeSocket over a standard AMI on EC2 or Nodester.



## bejes.us / Nodester



[bejes.us](http://bejes.us/) is a hosted version of [nodester](http://www.nodester.com/), an open source (via [github](https://github.com/nodester/nodester)) Node.js PaaS with a REST API, CLI, and git integration. If you want to run your own Heroku, this could be a good option.



## Cloudnode



[Cloudnode](http://cloudno.de/), current in private beta, appears to be very Heroku-esque although not much in known. The [Cloudnode CLI](https://github.com/dvbportal/cloudnode-cli) offers some insight.



## nodejitsu



[nodejitsu](http://nodejitsu.com/), in private beta, also appears to be a Heroku competitor. However, many of the core projects are [open source on github](https://github.com/nodejitsu/) and appear to be useful outside nodejitsu. 



## Update: no.de by Joyent



[no.de by Joyent](https://no.de/) provides "SmartMachines" similar to other services using NPM for dependency management and git for deployment. See the [Joyent wiki](http://wiki.joyent.com/display/node/Getting+Started+with+a+Node.js+SmartMachine) and the [FAQ](http://wiki.joyent.com/display/node/Node.js+SmartMachine+FAQ) for a quick sense of what's involved. Node.js v0.4.11 is supported by default but the [version can be changed](http://wiki.joyent.com/display/node/Setting+the+Node.js+Version). Based on the info on [getting a production deployment](http://wiki.joyent.com/display/node/Installing+Node.js+on+a+Joyent+SmartOS+SmartMachine), it's unclear what the scaling plan is as your have root access and install it yourself on a Solaris box.



## Update: Cloud Foundry



[Cloud Foundry](http://www.cloudfoundry.com/), a general purpose cloud hosting platform, [does support Node.js](http://support.cloudfoundry.com/entries/505133-deploying-a-node-js-app-with-npm-dependencies) and [Joyent is the community leader for it](http://joyeur.com/2011/11/08/joyent-is-community-lead-for-node-js-on-cloud-foundry/). [This post](http://www.mihswat.com/2011/05/04/getting-started-with-cloud-foundry-using-a-node-js-and-mongodb-application/) has a nice tutorial on getting started.

Know of any not listed here? How do you host your Node.js apps?

[Image sources: http://www.helicontech.com/zoo/media/icons/nodejs-100x100.png, http://a0.twimg.com/profile_images/473641368/logo-twitter.png, http://djangocon.us/site_media/media/sponsor_logos/dotcloud_png_180x140_q85.PNG, https://s3.amazonaws.com/photos.angel.co/startups/i/20387-0f44d2f264e195591716f9f82f30f5b3-thumb.png, http://a3.twimg.com/profile_images/1543095199/ndoesterrocket.png, https://secure.gravatar.com/avatar/fff4946e54f73818117b075009c985cc?s=140&d;=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png, http://nodesummit.com/wp-content/uploads/nodejitsu-small-e1324592710612.png]

Image created with [Logo Lifter](http://logolifter.com/).
