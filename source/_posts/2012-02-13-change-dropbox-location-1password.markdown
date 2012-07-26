---
comments: true
date: 2012-02-13 11:41:47
layout: post
slug: change-dropbox-location-1password
title: Changing Dropbox location for 1Password storage
wordpress_id: 340
categories:
- Tools
---

{% img featured /images/dropbox_1password.png %}

Dropbox is awesome. 1Password is awesome. When their powers combine... it's awesome. Except if you need to change where 1Password stores it's file in Dropbox. Here's a simple way to change that.

<!-- more -->

From the mouth of 1Password support:

> You have 1Password 3.9 which is from the Mac App Store. Apple requires (or will soon be requiring) all applications on the Mac App Store to conform to various Sandboxing rules. One of those rules is strict limitations on where the data files the application accesses are located. 
> 
> In this case we allow 1Password to read the file 1Password.agilekeychain inside of ~/Dropbox/1Password/ 
> 
> So it will always prompt you to tell you that it is copying the file to that location and that the other one will remain in the prior location as a backup. 
> 
> Long story short, you'll have to keep your data file at ~/Dropbox/1Password/1Password.agilekeychain
> 
> I do apologize for the inconvenience though. Hopefully this helps.


Bummer. Here's how to change it:

1. Open 1Password and go to **1Password > Preferences... > General**
2. Disable using Dropbox. This will now store the files under /Users/yourname/Dropbox/Personal/...
3. Close 1Password
4. Open a terminal and follow the script below



Assuming you want to store your files in ~/Dropbox/Personal/1Password instead of ~/Dropbox/1Password (for instance, if you are using [multiple Dropbox accounts on the same machine](/multiple-dropbox-accounts-same-machine-sharing/)) do the following in a Terminal:

```sh
$ mv ~/Library/Containers/com.agilebits.onepassword-osx-helper/Data/Documents ~/Dropbox/Personal/1Password
$ ln -s ~/Dropbox/Personal/1Password ~/Library/Containers/com.agilebits.onepassword-osx-helper/Data/Documents
```

Enjoy.

