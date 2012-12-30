---
comments: true
date: 2012-03-28 16:20:44
layout: post
slug: heroku-postgres-shared-dedicated-amazon-rds
title: 'Heroku Postgres: Shared, Dedicated or use Amazon RDS?'
wordpress_id: 389
keywords: heroku, postgress, shared, dedicated, amazon rds, rds, ruby, ruby on rails, rails, aws
categories:
- Ruby / Rails
tags:
- heroku
- postgres
- aws
- rails
---

{% img featured right /images/heroku_rds_postgres.png %}

Heroku shared databases can't be beat for convenience or cost during development (assuming you are on Heroku already). What about when the app goes live? Here are some thoughts on whether the app should stay on a [Heroku shared Postgres database](https://postgres.heroku.com/), switch to a dedicated database or use something else entirely such as [Amazon RDS](http://aws.amazon.com/rds/).

<!-- more -->



## Basic Considerations


We have a startup Rails app hosted on Heroku getting ready to push for an early alpha release. For such an app, what are the questions you should be asking?

* How will you handle traffic spikes?
* What determines growth in the size of the database?
* Is the data read only/read mostly or does it contain quick growth data like page views and social activity?
* How closely do costs need to be controlled?
* How much traffic and data do you need to support?
* How much maintenance will the solution cost and what staff is needed to support it?


For this app, the following were important to consider:

	
* Since Heroku runs on EC2 they recommend (not surprisingly) that you grab a database plan where your entire DB can be in RAM. Dedicated plans range from 1.7 GB to 68 GB. Both our databases, being loaded with just testing data for alpha testing, were under 1 MB. That's not very helpful for evaluating the size we needed.
* We don't store anything growth- or data-heavy in our DB: we don't log analytics and all binary data is stored on S3. The data is going to grow with the number user accounts and related records. This is all very small, slow-growth data and even with a large number of new objects shouldn't blow out the database size. All the search indexes are stored in [WebSolr](http://websolr.com) which will help keep the DB size down.
* While it's safer to go to a dedicated plan now, it's starts at $200 in the door and we don't appear to be anywhere near needing the storage or performance provided.




## Heroku Database Migration Options


There are a few options for migrating databases if and when you want to go from shared to dedicated. Note that you should have a [maintenance page](http://onehub.com/blog/posts/rails-maintenance-pages-done-right/) while migrating your database, especially if using a manual migration method. During migration your database won't accept any modifications (or if it does they will be lost).


### Backup & Restore


This is the only option on Heroku for migrating from a shared to dedicated database. See [PG Backups](https://devcenter.heroku.com/articles/pgbackups).

* Works across all plans
* Can be slower than other migration methods (especially with large databases) since you need to export and re-import the entire database and transfer it across the network doing so. However, it's a pretty simple process and appears to be easy and fairly low risk.




### Fast Changeover


In [fast database changeover](https://devcenter.heroku.com/articles/fast-database-changeovers), you use followers (read-only slaves) or forking (snapshots) and then point the app at the new database. This isn't an option for migrating from a shared to dedicated database or moving to or from the Heroku platform in general. However, it's a good tool to know about.

* Works for large databases better than a manual migration
* Minimizes app downtime
* Migrating shouldn't require changes to the [WebSolr](http://websolr.com/) index as the IDs should be the same




## Use Something Else (like Amazon RDS)


Rather than staying on [Heroku Postgres](https://postgres.heroku.com/), you could switch to something external such as Amazon RDS (which is clearly MySQL and not Postgres if that's an issue for you).

* A switch from Postgres to MySQL might be an issue if you have lots of migrations and some use something database-specific
* Heroku offers Postgres as a service (outside hosting apps)
* Includes a nice admin panel and lots of scaling / migration features and support for scaling horizontally (if it should ever come to that)
* We could host a Postgres install on EC2 but we now have to roll all that scalability stuff ourselves (which we could do). We'd probably consider using RDS rather than any self-run db cluster.
* For us it's mostly a matter of price and if the service Heroku provides is worth not doing it ourselves. Given that we don't have a dedicated IT team for this project the time spent maintaining the cluster is an important factor.


At the point of putting out an alpha we didn't even need the 15 MB database which is $15 / month. Again, the DB should grow in proportion to the number of actually accounts, etc none of which should grow quickly (unless we are actually getting a ton of usage). If we started tracking analytics of any kind this would change.


## Getting Heroku Database Size


You can use `heroku pg:info --remote=production` to get the database size. For shared databases the output is not very interesting:

```sh
$ heroku pg:info --remote=production
=== SHARED_DATABASE (DATABASE_URL)
Data Size 648k
$ heroku pg:info --remote=staging
=== SHARED_DATABASE (DATABASE_URL)
Data Size 688k
```


## Where We Left It: EC2 for Cost Reduction


If this app really takes off (like huge) we will likely move to EC2 / RDS to reduce cost. Again, this depends on the numbers (particularly how many staff we need to support an AWS deployment). [This discussion](http://www.quora.com/How-easy-is-it-to-get-off-Heroku-once-you-grow-out-of-it) has a good example of an experience comparing Heroku and RDS in the long-term:


> The only way to achieve any concurrency in Heroku is to turn up dynos and workers. These are 5c/hour each ~ $36/month. The first dyno (but not the worker) is free. Therefore, if you want a concurrency of 4 dynos and 1 worker, you are looking at $144/month. We have found that we can easily achieve 4 times this concurrency on one small EC2 instance. You would want load balancing and failover, so assuming that you are going to use 2 reserved small EC2 on the east coast (Heroku is on the east coast too), that comes to 2 X ($227.50 per year + 3c/hour) ~ $81/month. This can be equivalent of approximately $576/month on Heroku.
> 
> Continuing with the $144/month figure for Heroku, shared database in Heroku is free, but the smallest dedicated instance is $200! Compare this with RDS, where an equivalent reserved multi-availability zone instance costs $455 yearly + 9.2c/hour ~ $104/month.
> 
> In other words, at a concurrency of 4 dynos and 1 worker with a free shared database, Heroku costs $144 a month, while Amazon with a potential of atleast 4 times that concurrency with failover for the database and the server costs a total of $81 + $104 = $185/month. At the full capacity of the EC2 machines with a dedicated database instance, Heroku will cost approximately $776/month while Amazon will continue to run at under $200.
> 
> ...
> 
> The operational cost of maintaining the databases on Amazon is near zero, except for the initial setup, which can be super easy too if you have used it in the past. Web server operations can be a little more ongoing work, compared to zero for Heroku. However, once you have load balancing set up, and like in our case, capistrano + git based push system, you can be off and running at almost nil system administration time.


What considerations and decisions have you made regarding where your database lives?
