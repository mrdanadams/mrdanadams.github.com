---
layout: post
title: "Trello for Agile Development at BlockAvenue"
date: 2012-12-05 16:40
comments: true
keywords: trello, agile, agile development, agile process, blockavenue
tags:
- blockavenue
- startups
- process
- agile
- trello
- portfolio
- featured
---

One of the my roles as CTO at [BlockAvenue](http://www.blockavenue.com/ "Neighborhood Reviews") is to manage a [high velocity, agile development process](http://blog.blockavenue.com/corporate/blockavenue-your-neighborhood-socialized/). [Trello](https://trello.com/) is my new favorite tool when it comes to ticket management but it's not without limitations. Here's how we use Trello at BlockAvenue and some of the challenges working with it.

<!-- more -->

## The Basics

Cards are arranged into buckets (Trello lists) each bucket representing how far in the future it's cards will get done. The further out the bucket, the larger and less well-groomed it may be.

Lists are arranged left-to-right so that the most frequently used lists are on the first screen for most displays, the less used lists being to the right on the second screen. They also follow a logical progression of _queued -> doing -> done_.

[{% thumbnail /images/trello/board.png 600x400< %}](/images/trello/board.png)

* **Dec 2012:** All of the priority cards for this month based on business priorities and other factors. This will map to multiple staging or production releases (even multiple releases each week) but all of the development in this month will be pulled from this bucket. Cards in this list are sorted roughly in order of priority. Most are assigned owners.
* **Jan 2013:** Similar to the Dec list, this is for the following month but less well defined.
* **General Backlog:** This list represents a larger backlog to be pulled from into the monthly lists. It contains all things that should get done at some point but didn't make the cut. It can be thought of as the mid-term roadmap.
* **Future:** A holding area for future ideas. When you have an idea, don't be afraid to make a card for it. File it away so it doesn't get lost. This is list is groomed the least often.

In addition to the time frame-based lists, there are a few special ones:

* **Inbox:** All new cards go here. Cards are held until they can get triaged and moved somewhere else. This keeps the dev team sane and ensures the non-devs know their cards aren't getting lost. It should be empty most of the time.
* **On Deck:** Cards pulled from the current monthly milestone that are next up for development. You can think of this roughly as a weekly iteration list. This list should be fairly short and reviewed by the team every couple days (or even daily).
* **Doing:** Cards pulled from On Deck that are being worked on.
* **Done:** Completed cards. Note that we don't have lists indicating the status of a done card (in testing, deployed, etc). This is only because we haven't needed it but for some teams managing the work flow around Done cards is probably a good idea. For instance, you may need explicit design QA on a feature and there could be a list for those cards.

The Done list gets some special treatment: whenever a production release is made we rename the "Done" to something like "Dec 3, 2012 Release", archive it, and create a new "Done" list. This captures for posterity what was released and allows anyone to know what's done so far in the current release just by looking at the Done list. You may also want to tag the card with the git release tag.

## Anatomy of a Good Card

Well-formed cards encourage getting the work done smoothly and accurately. While you may not need all of the following on each card, I find myself using using all of these to some degree overall.

### Card Title, Tags, and Labels

![A good Trello card title](/images/trello/card-top.png)

* Keep the title succinct. Put the long stuff in the card description. A long title will severly reduce how many cards you can see at once in your lists.
* Tags for things like which users it affects, browser, platform, if it's an epic or story, etc
* Use labels to visually indicate traits of the card and allow card filtering
* Work estimate. A good convention is "(5) Do something" especially when it's supported by [Trello Scrum](https://chrome.google.com/webstore/detail/trello-scrum/jdbcdblgjdpmfninkoogcfpnkjmndgje).

![Trello card with estimate](/images/trello/story-title.png)

### Card Description

* Be sure to write one unless the title, tags, and labels provide everything needed to get it done
* Take full advantage of markdown. Include code snippets, samples of log files, bulleted lists, headers, etc.
* Write a full spec for complex cards. Provide implementation hints / details.
* Include reasons _why_ the card is being done based on team discussion. This info tends to get lost and can be really valuable later.

### Screenshots & Attachments

![Trello attachments](/images/trello/attachments.png)

Don't try to describe a bug with words if it's visual. Just don't. Take a screenshot (or multiple screenshots) with something like [Skitch](http://evernote.com/skitch/) and attach it. Especially during design QA, designers can get across exactly what they're are talking about.

<img src="/images/trello/card.png" alt="Trello card with image" class="alignright" /> For new features, attach images of the designs for reference even if the PSDs live in Dropbox. A side effect is the visual appeal it can add to your lists.

### Checklist(s)

![Trello card checklists](/images/trello/checklists.png)

Use checklists to guide work and track detail progress.

## Trello and git

We have two primary git branches: _master_ (which always represents what's on production) and _development_ which is the current release under development and is frequently pushed to staging. Trivial and small cards can be done right on development but larger cards (or those involving multiple commits) get moved to their own feature branch. While not displayed prominently, Trello cards actually do have unique, auto-incrementing numbers:

![Trello card numbers](/images/trello/trello_card_number.png)

All feature branches map back to a Trello card based on the card number (ex: _322_my_awesome_new_feature_). You could also include the initials of the person that created the branch in a larger team.

## Labels, Tags, and Finding Your Cards

<img src="/images/trello/trello_labels.png" alt="BlockAvenue Trello labels" class="alignright" />

Trello lets you easily filter by person or label. You only get six labels so use them wisely; it's a pain to go back and change later. Here's the labels we used:

* __Data__, __App__, __API__, __Admin__: Major system components
* __Bug__: Something that's broken.
* __Needs Review__: Needs clarification or discussion and isn't ready to be worked on. When cards are pulled into _On Deck_ none should have this label.

Keep in mind that one of the best thing about labels is that they are color coded making it good for visually distinguishing cards when the lists are unfiltered.

You will inevitably come up with ways you want to filter your cards that don't fit owners, due dates, or labels. While Trello doesn't have direct support for tags it does have a nice text search. It only searches the title and ignores any non-alphanumeric characters. With _#sometag_ on the end of a card title you can see that a card is tagged and, as long as you pick a tag name that isn't common to your card titles, you can filter by it.

![Trello tags](/images/trello/tags.png)

Suggestions for tags:

* __Browser-specific:__ #ie9, #ff, #safari
* __User group:__ #dweller, #mover, #press
* __Card types:__ #epic, #story

## Checklists Rock

Lists are awesome. Sometimes it seems my whole life is managed by making lists of things. Trello is no different. Tips on using checklists:

* When grooming the backlog, create the checklist for a card to get a sense of what's involved.
* Use multiple checklists with custom titles to separate between components of a card (frontend, backend) or between roles (dev, design).
* You can't (yet) drag TODOs betweens checklists. Bummer.

## Dealing with Long Lists

Lists can get long, especially if you attach images or use long card titles. Unfortunately, there isn't a 'send to top' for cards but if you drop a card on a list quickly it will shoot to the bottom of the list. Try to keep your titles succinct or even reducing the browser font size as small as you can stand it. It's a hack, but it works.

## Card Estimates

This is, perhaps, the single biggest thing I miss in Trello; the ability to put a work estimate on a card and see estimate totals for each list. Even with a small backlog, tracking estimates can add much needed control to the process. [this tool](http://bluelinegamestudios.com/trello/) allows you to track estimates and graph them but it's not a great solution: the estimates should be managed in Trello.

[Trello Scrum](https://chrome.google.com/webstore/detail/trello-scrum/jdbcdblgjdpmfninkoogcfpnkjmndgje) looks promising although I don't believe it does any kind of burn visualization.

![Trello Scrum](https://lh4.googleusercontent.com/U9TS8KIksA5LyG0u2AGSmB6HNBQuRS1Xx2Zsf5j74AW2FHCT4WKhnXG372FGqi0O7NE7qrgIew=s640-h400-e365)

## Shortcuts

If you aren't using [Trello shortcuts](https://trello.com/shortcuts), you should be. They will save you a massive amount of time when grooming the backlog.

## Team Friction

We struggled with effectively using Trello to make the business stakeholders self-sufficient in answering the following:

* How much is left and when will it get done?
* Given our current team, how much can we get done in the next N weeks?

The following goes a long way to solving this:

* Good team communication and regular review of the lists
* Good card and list hygiene: well-formed cards and groomed lists
* Date or goal-oriented lists
* Card estimates and tracking team velocity

## For Hackers: Card JSON and Trello API

Trello's beauty is in it's simplicity. When it doesn't allow you to do something you always have the option of using the [Trello API](https://trello.com/docs/api/index.html). Tucked away under the card details is a link to the card JSON:

![Trello card JSON](/images/trello/card-json.png)

## When I Wouldn't Use Trello

Trello is simple and necessarily limited. In a more complex project I could see easily outgrowing it. [OnDemand JIRA](http://www.atlassian.com/software/jira/overview/) with [GreenHopper](http://www.atlassian.com/software/greenhopper/overview) is a great alternative. Unlike Trello, it's not free but it's the Swiss Army knife of ticket tracking as far as I'm concerned. Between Trello and JIRA I have a hard time recommending anything else (having used most of the others).

An example where Trello might not fit is a software platform that needed to track things across versions of the software. A REST API with multiple versions could need maintenance fixes and releases against old versions. In JIRA, this is relatively trivial with version tracking. That's not to say you _couldn't_ do it with Trello but it could get messy very quickly.

