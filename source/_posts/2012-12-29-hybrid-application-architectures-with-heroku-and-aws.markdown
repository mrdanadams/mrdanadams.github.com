---
layout: post
title: "Hybrid Application Architectures With Heroku &amp; AWS"
date: 2012-12-29 10:00
comments: true
keywords: heroku, aws, architecture, combining, hybrid, amazon web services, s3, ec2
categories: 
published: false
tags:
- aws
- heroku
- featured
---

AWS (Amazon Web Services) and Heroku are great tools for cloud-hosted applications. Combining them into a single application architecture allows the best of both worlds achieving the perfect balance of capabilites, cost, convenience, and performance. I'll use a few examples to illustrate when, how, and why you might combine them.

<!-- more -->

## Why Heroku?

Heroku is an abstraction layer on top of AWS and other services making common application concerns such as deployment, scale, reliability, maintenance, and integration with other services much easier. Especially with buildpacks, Heroku and other PaaS providers have set a new expectation for the level of effort it should take to get an application up and running. Some providers such as Meteor even go as far as abstracting the implementation details of the application itself based on a common framework.

Heroku giveth and it also taketh away...

## Combining

Heroku (currently) lives in the east AWS region. This means that other AWS services such as EC2 and S3, when used in the same region, are fast and cost effective when integrated with a Heroku-hosted application.

## You Don't Need Addons / Configuring a Rails App to another service

## Optmizing for Cost

## Flexibility in Capabilities

## Multiple Deployments

## Scalable, Distributed Computation

## The Double-Edge Sword of Abstraction

Heroku offers a lot but at the cost of control...

### Customized Metal

### Routing, Load Balancing, DNS

### Security

### Redundency