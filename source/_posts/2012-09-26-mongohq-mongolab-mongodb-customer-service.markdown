---
layout: post
title: "MongoHQ vs MongoLab: Selecting a Hosted MongoDB Provider"
date: 2012-09-26 10:19
comments: true
categories: 
published: false
---

{% img feature /images/mongohq_mongolab.jpg MongoLab vs MongoHQ %}

In the course of building [BlockAvenue](http://blockavenue.com), one of the decisions I made was whether to host our own [MongoDB](http://www.mongodb.org) or use a hosted provider. Here's the short tale of what I selected and the importance of top-tier customer service.

<!-- more -->

## Self-hosted or managed hosting?

We were under intense deadline, had no resources to spend setting up or maintaining a MongoDB cluster, needed no heavy customizations, and needed the database up and running yesterday. Since the app was Heroku hosted, we also needed some control over which region it would be located in. The decision to use a hosted service was a no-brainer even if it meant higher costs for the EC2 instances in the short term. [MongoHQ](https://www.mongohq.com) and [MongoLab](https://mongolab.com) were clearly the top two choices. But which provider to use? And which size deployment?

## A first-look at MongoHQ and MongoLab

My first impression comparing MongoHQ and MongoLab put me slightly in favor of MongoLab. In fact, we used the free plan on MongoLab for a short period (and I've used them for small stuff on other projects). As a customer walking in the door, I found the MongoLab pricing and info about their offering much clearer and more informative. Even when choosing a database, having clear pricing and product info is important and eye candy makes some difference. The MongoHQ page provides the basics on pricing but not much else.

With their dedicated plans, for instance, you know the pricing for a Large instance without a replica set ($525 / mo) and the Extra Large instance with replica set ($1,950 / mo). But what about starting with a single Extra Large instance and going to replica set later? How do I expand my cluster? What's the process and costs involved?

{% img /images/mongohq_pricing.png MongoHQ pricing %}

The MongoLab documentation is much clearer and their technical architecture page (aka "What will I get?") makes a **lot** of sense is and very well done. Overall, MongoLab was more informative and, frankly, better looking. Even when choosing a back end technology, visual goodness conveys a sense of quality.

{% img /images/mongolab_pricing.png MongoLab pricing %}

{% img /images/mongolab_arch.jpg MongoLab architecture %}

## Interaction with a real human

At this point, I'm on the fence and out of time; I need a deployment up, my data loaded, and to start setting up the production environment. I still have big questions about the specifics of the data we are handling; large amounts of geospatial data with very fast response times and a lot of queries.

I email [10gen](http://www.10gen.com) asking to get on the phone with someone to ask a few questions about index structure, the amount of memory needed and overhead to plan for, and other performance concerns. Within 30 minutes I am on the phone with a 10gen engineer. Awesome. I could not have had a better experience with 10gen and would absolutely recommend people with non-trivial deployments consider a support contract or initial consultation.

Having my strategy worked out, I need to select a vendor and get the deployment up. I fire off emails to MongoHQ and MongoLab. Within 10 minutes, a real person with real experience and knowledge of MongoDB calls my cell (Chris from Birmingham). Chris is awesome; I explain our project particulars and he immediately comes back with solid questions and recommendations based on their experiences with other customers. 15 minutes on the phone and I am ready to pull the trigger. This was, without a doubt, one of the best customer experiences I've ever had (I sent him an email later saying as much).

I walk back to my desk, create my account, set up a new deployment, wait for the EC2 instances to come up (which took a few minutes), create my database, and am off and running. 30 minutes in and I have my instance with GBs of data and many millions of documents loaded and serving our Heroku-hosted app. Everything should be this easy. Rock on, MongoHQ.

I hear back from MongoLab several hours later (which, admittedly, isn't **that** bad) but MongoHQ beat them to it and totally delighted me with their customer service. My production db was up and serving our app by the time MongoLab responded.

## Living with MongoHQ

A few days later, we need to make the move to a replica set in preparation for [go-live](http://blog.blockavenue.com/corporate/we-are-live-n-kickin/). I email support with specific questions about cost, process, time line, and scaling up / down as needed based on traffic ([we knew we were going to get TechCrunch'd](http://techcrunch.com/2012/09/20/blockavenue-launch)). Again, I have a response within minutes. A day or two later, on a Saturday, we circle back on this and are ready to make a decision. Email is sent to support giving them the go-ahead to both increase the instance size and create the replica set. Response was that they are on it but may not get to it by Monday. A few hours later, I'm delighted to see an email that the new cluster is up with the URLs for each server. Again, MongoHQ goes above expectations for customer support.

Once up and running, the clusters are largely self-service and we've had no problems so far. An admin panel shows the status of each node, connection and database info, and what's happening on each instance now and in recent history. The old admin is a bit ugly and dated but the new admin (in alpha) is already awesome. It's also responsive meaning it works well as a large view showing and as a mini dashboard. In fact, on launch day, I left it running in the corner of my second monitor all day to keep an eye on things.

## Final thoughts

In the end, the offerings between MongoHQ and MongoLab may be marginally different, at least in terms of pricing and technology. However, MongoHQ support has so far proven to be top notch. For many of my clients without IT or dev ops resources, this makes the price increase over running their own MongoDB cluster on EC2 well worth it.
