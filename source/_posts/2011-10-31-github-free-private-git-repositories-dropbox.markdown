---
comments: true
date: 2011-10-31 16:30:00
layout: post
slug: github-free-private-git-repositories-dropbox
title: 'Forget github limits: Free private git repositories with Dropbox'
wordpress_id: 43
categories:
- Tools
tags:
- dropbox
- git
- github
---

Need private git repositories for your personal projects but don't want to pony up the lunch money for a github personal account? git combined with Dropbox creates personal repos that can be synced to multiple machines, host any number of repositories, give you the assurance of cloud backup, and with a 2 GB limit for a personal account provides ample storage (I currently only use 10% of my quota).

<!-- more -->

## Create a normal git repo

Assuming you have an existing project you wish to git-dropbox-ify, go to the project directory, create a repo in it, and add and commit your files.

```sh
$ cd yourproject
$ git init
$ git add *
$ git commit
```

## Create a git folder to hold your repos

Go to your dropbox directory and create a directory (just to be organized) to hold your repos.

```sh
$ cd ~/Dropbox
$ mkdir git
```

## Create a bare origin repo

Now create an empty repo to act as the remote origin for your working copy repo. This is essentially the same as when working with github or another remote repo except it's stored locally and pushes are auto-syncronized to other machines and backed up by dropbox.

```sh
$ cd git
$ mkdir yourproject.git
$ cd yourproject.git
$ git --bare init
```

## Add remote origin and push changes

Add the dropbox folder as the remote origin and push your changes. Whenever you push to the remote origin the changes will be detected by dropbox and synced.

```sh
$ cd yourproject
$ git remote add origin ~/Dropbox/git/yourproject.git
$ git push origin master
```

## Beware shared folders

I have had no problems with this setup but others have reported problems when trying the model shared with multiple users. This makes sense due to the conflicts and how dropbox handles them but at least for a single user (or multiple users who don't conflict) it works great.

