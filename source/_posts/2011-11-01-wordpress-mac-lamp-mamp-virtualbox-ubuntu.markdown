---
comments: true
date: 2011-11-01 10:00:00
layout: post
slug: wordpress-mac-lamp-mamp-virtualbox-ubuntu
title: Wordpress development on Mac with LAMP / MAMP, VirtualBox, and Ubuntu
wordpress_id: 40
categories:
- Tools
- Wordpress
tags:
- lamp
- mac
- mamp
- virtual hosts
- virtualbox
- wordpress
---

How do you host multiple wordpress installs under different domains in a LAMP stack on your local Mac? You don't. You use Ubuntu and VirtualBox.

I recently needed a full LAMP setup (or MAMP, in this case) with virtual host mapping on .dev domains for local wordpress development. After going the native Mac route I switched to a vastly easier (and superior) option: an Ubuntu server in VirtualBox with communication between the machines.

<!--more-->

In this setup you run Ubuntu as a guest OS in VirtualBox with network access between the machines, host mappings on the host machine for the domain names, and the host files shared and mounted on the guest OS. This allows you to happily check out (with git, for instance) and edit files on the host OS with your favorite tools while Ubuntu takes care of serving the deployment (and related assets such as a MySQL db) directly from your files.

One of the reasons I love this setup is the flexibility: if you mess up your LAMP stack you can blow it away and recreate it or back-up / clone the machine image entirely.

As a long-time linux user (recently moved to a Mac) I also desperately miss the package management and ease of server installation and configuration (and don't say 'homebrew' or 'macports').

I did try [MAMP](http://www.mamp.info/en/index.html) directly and found it lacking. The configuration files are annoyingly different than any linux distro I've used, located in an odd spot, and duplicate of the main apache config in /etc.


## Install VirtualBox and Ubuntu

<a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Download and install VirtualBox</a>.

After installing, <a href="http://www.ubuntu.com/download/ubuntu/download" target="_blank">download Ubuntu</a> (I recommend one of the torrents). I used the 64-bit version although I think the 32 will work as well.

Now that you have the Ubuntu ISO, create a new VM in VirtualBox:

{% img /images/create_vm.jpg %}

I'll leave it to <a href="http://maketecheasier.com/install-ubuntu-linux-on-your-mac/2010/11/08" target="_blank">other tutorials</a> on the details of the install. However, I think I used all the defaults.

## Create a host-only network

You need to add a second network device to your VM in order to have a host-only network. This network allows you to have direct, private communication between your machine and the VM so the VM looks like just another machine on the network with a fixed IP address.

First you need to create the second adapter. Go to **VirtualBox > Preferences...** and create a new adapter.

{% img /images/host_network.jpg %}

You then create a new adapter in the VM itself:

{% img /images/network_adapter.jpg %}

Start up your VM and you should see the network adapter (see ifconfig).

## Share and mount host files

In the VM settings, go to Shared Folders and add a new shared folder. If you set it to auto-mount, it will be owned by the root preventing you from running Apache directly from the files.

{% img /images/folder_share.jpg %}

We'll mount it manually as root:

```sh
$ sudo mkdir /mnt/host-home
$ mount -t vboxsf -o uid=33,gid=33 host-home /mnt/host-home
```

The uid and gid here you can get from /etc/passwd and /etc/groups as the user and group to mount as (such as www-data for apache).

## Deploy mounted files directly in Apache

As root symlink the project in the host files to the apache sites directory:

```sh
$ cd /var/www
$ ln -s /mnt/host-home/work/yoursite
```

Then enable in your Apache virtual host configuration:

```xml
<VirtualHost *:80>
#...
        DocumentRoot /var/www/yoursite
        Options FollowSymLinks

        <Directory />
                Options FollowSymLinks
                AllowOverride FileInfo
        </Directory>
        <Directory /var/www/yoursite>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride FileInfo Indexes
                Order allow,deny
                allow from all
        </Directory>
#...
</VirtualHost>
```

Be sure to enable symlinks or you will get Forbidden errors trying to access the site.

## Host mappings between the machines

In this case we'll use **yoursite.dev** on both the host and guest so we need to add it to both /etc/hosts files.

On the host (using the IP address of the guest machine on the host-only network):

```
192.168.56.101  ubuntu yoursite.dev yourothersite.dev
```

On the guest (in case it needs to reference itself by the same name):

```
127.0.0.1       localhost yoursite.dev yourothersite.dev
```

## Have at it!

While I've left out some details (such as configuring the full LAMP stack) you should have what you need to easily run servers from one (or even multiple) guest Ubuntu servers while developing natively on your host OS.

After running with this setup for a few weeks I'm really pleased with it and find it a perfect fit: I can customize my Mac development environment and use the tools I'm used too while having all the server goodness of Ubuntu where it counts.

One enhancement would be to auto-mount the host drive on startup on the guest OS but, since I rarely ever restart the instance, I simply haven't bothered.
