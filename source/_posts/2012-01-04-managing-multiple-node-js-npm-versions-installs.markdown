---
comments: true
date: 2012-01-04 10:00:50
layout: post
slug: managing-multiple-node-js-npm-versions-installs
title: Managing multiple Node.js / NPM versions and installs
wordpress_id: 244
categories:
- Node.js
---

If you are using [Node.js](http://nodejs.org/), particularly on [Heroku](http://www.heroku.com/) which mandates a specific version, and need to work across multiple versions doing this manually can be frustrating (and insane). "No such module" problems like [this](https://github.com/isaacs/npm/issues/1711) and [this](https://github.com/isaacs/npm/issues/1711) have naturally led to some nice tools for managing [NPM](http://npmjs.org/) and Node.js versions.

<!-- more -->



## n



I have found [n](https://github.com/visionmedia/n), like it's name, to be simple and useful and haven't yet had any issues with it.



## Nave



[Nave](https://github.com/isaacs/nave) borrows from [NVM](https://github.com/creationix/nvm) and sea. 



## NVM



[NVM](https://github.com/creationix/nvm), presumably inspired by [RVM](http://beginrescueend.com/), has a number of dependencies, more complicated installation, and appears to have been superseded by more recent tools like n and nave.

What is your tool of choice? Do you use one or just do it manually?
