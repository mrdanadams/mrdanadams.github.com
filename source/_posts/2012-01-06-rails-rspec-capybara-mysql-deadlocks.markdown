---
comments: true
date: 2012-01-06 14:22:18
layout: post
slug: rails-rspec-capybara-mysql-deadlocks
title: Rails integration tests, RSpec, Capybara, and MySQL deadlocks
wordpress_id: 249
categories:
- Ruby / Rails
tags:
- Capybara
- MySQL
- RSpec
---

In the midst of writing integration tests with [Capybara](https://github.com/jnicklas/capybara) and [RSpec](https://www.relishapp.com/rspec), my tests started freezing and eventually giving me the error `ActiveRecord::StatementInvalid (Mysql::Error: Lock wait timeout exceeded; try restarting transaction`. Turns out this is a problem with RSpecs database cleaning strategy and manually seeding the database during a test run.

<!-- more -->

The full error looks like this:

```
Started POST "/users/sign_in" for 127.0.0.1 at 2012-01-03 16:53:04 -0500
  Processing by Devise::SessionsController#create as HTML
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"MlvjJC4/4pxs+8cMhn4f5pGpb1aK7fULSHAEp649hGo=", "user"=>{"email"=>"user@example.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Sign in"}
  User Load (0.9ms)  SELECT `users`.* FROM `users` WHERE `users`.`email` = 'user@example.com' LIMIT 1
  SQL (0.2ms)  BEGIN
   (0.5ms)  SELECT COUNT(*) FROM `roles` INNER JOIN `assignments` ON `roles`.`id` = `assignments`.`role_id` WHERE `assignments`.`user_id` = 112
   (50630.0ms)  UPDATE `users` SET `last_sign_in_at` = '2012-01-03 21:53:04', `current_sign_in_at` = '2012-01-03 21:53:04', `last_sign_in_ip` = '127.0.0.1', `current_sign_in_ip` = '127.0.0.1', `sign_in_count` = 1, `updated_at` = '2012-01-03 21:53:04' WHERE `users`.`id` = 112
Mysql::Error: Lock wait timeout exceeded; try restarting transaction: UPDATE `users` SET `last_sign_in_at` = '2012-01-03 21:53:04', `current_sign_in_at` = '2012-01-03 21:53:04', `last_sign_in_ip` = '127.0.0.1', `current_sign_in_ip` = '127.0.0.1', `sign_in_count` = 1, `updated_at` = '2012-01-03 21:53:04' WHERE `users`.`id` = 112
   (0.3ms)  ROLLBACK
Completed 500 Internal Server Error in 50895ms

ActiveRecord::StatementInvalid (Mysql::Error: Lock wait timeout exceeded; try restarting transaction: UPDATE `users` SET `last_sign_in_at` = '2012-01-03 21:53:04', `current_sign_in_at` = '2012-01-03 21:53:04', `last_sign_in_ip` = '127.0.0.1', `current_sign_in_ip` = '127.0.0.1', `sign_in_count` = 1, `updated_at` = '2012-01-03 21:53:04' WHERE `users`.`id` = 112):
  app/controllers/application_controller.rb:21:in `set_current_user'
```



## The root cause: dangling transactions



On sign in, [devise](https://github.com/plataformatec/devise) updates the users account with the last time they logged in. However, there is already a transaction started, and stalled, so it eventually times out.

The general testing pattern used looks like this:

1. Clean the database
2. Put in initial data (if any)
3. Do something in the app using Capybara. App alters the database.
4. Verify the result from the test
5. Alter the data in the test and repeat as necessary



One of the reasons this method is useful is the data is left in the database after the test run which is great for faster debugging and development.



## The solution



As noted in [this blog post](http://atevans.com/rspec-db-cleaning-causing-mysqlerror-savepoin), the issue is with RSpec's use of transactions during testing. Before step 1, RSpec starts a database transaction which is open when we get to step 3. At this point the application blocks due to the transaction and bad things happen. Like the aforementioned post states, the answer is as simple as changing the configuration in _spec_helper.rb_ to:

```ruby
config.use_transactional_fixtures = false
```

In the same file, I used the [database_cleaner](https://github.com/bmabey/database_cleaner) gem to nicely clear the database before test:

```ruby
  config.before :suite, do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each, do
    DatabaseCleaner.clean
  end
```

The [factory_girl](https://github.com/thoughtbot/factory_girl) gem is used to create the test data during tests:

```ruby
      @user = FactoryGirl.create :user

      visit '/users/sign_in'
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      click_button "Sign in"
```



## Debugging and cleaning up MySQL deadlocks



In the process of figuring this out, I found some new tricks in debugging MySQL transactions. Use [SHOW ENGINE...](http://dev.mysql.com/doc/refman/5.0/en/innodb-monitors.html) to find out what's going on inside the database with the locks:

```sql
show engine innodb status;
```

When queries are not being run the output may look like this:

```

….
------------
TRANSACTIONS
------------
Trx id counter 16B0B
Purge done for trx's n:o < 16B04 undo n:o < 0
History list length 2530
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 0, not started
MySQL thread id 2, query id 311 localhost root
show engine innodb status
---TRANSACTION 16B06, not started
MySQL thread id 7, query id 250 localhost root
---TRANSACTION 16B0A, not started
MySQL thread id 1, query id 294 localhost 127.0.0.1 root
---TRANSACTION 16B04, ACTIVE 62863 sec
11 lock struct(s), heap size 1248, 12 row lock(s), undo log entries 10
MySQL thread id 6, query id 249 localhost root
Trx read view will not see trx with id >= 16B05, sees < 16B05
….

--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
2 read views open inside InnoDB
Main thread id 4488679424, state: waiting for server activity
Number of rows inserted 14, updated 0, deleted 6, read 310
0.00 inserts/s, 0.00 updates/s, 0.00 deletes/s, 0.00 reads/s
….
```

See the `TRANSACTION 16B04, ACTIVE 62863 sec`? This transaction has stalled and been alive for a long time. While the querying is running, and waiting, it looks like this:

```

….
------------
TRANSACTIONS
------------
Trx id counter 16B0D
Purge done for trx's n:o < 16B04 undo n:o < 0
History list length 2530
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 0, not started
MySQL thread id 2, query id 339 localhost root
show engine innodb status
---TRANSACTION 16B06, not started
MySQL thread id 7, query id 250 localhost root
---TRANSACTION 16B0C, ACTIVE 11 sec starting index read
mysql tables in use 1, locked 1
LOCK WAIT 2 lock struct(s), heap size 376, 1 row lock(s)
MySQL thread id 1, query id 333 localhost 127.0.0.1 root Updating
UPDATE `users` SET `last_sign_in_at` = '2012-01-04 15:25:42', `current_sign_in_at` = '2012-01-04 15:25:42', `last_sign_in_ip` = '127.0.0.1', `current_sign_in_ip` = '127.0.0.1', `sign_in_count` = 1, `updated_at` = '2012-01-04 15:25:42' WHERE `users`.`id` = 112
Trx read view will not see trx with id >= 16B0D, sees < 16B04
------- TRX HAS BEEN WAITING 11 SEC FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 0 page no 462 n bits 168 index `PRIMARY` of table `myapp`.`users` trx id 16B0C lock_mode X locks rec but not gap waiting
Record lock, heap no 98 PHYSICAL RECORD: n_fields 18; compact format; info bits 32
 0: len 4; hex 80000070; asc    p;;
 1: len 6; hex 000000016b04; asc     k ;;
 2: len 7; hex 04000002291e44; asc     ) D;;
 3: len 16; hex 75736572406578616d706c652e636f6d; asc user@example.com;;
 4: len 30; hex 243261243034247036376c426b7032726e6148384471747635744b654f75; asc $2a$04$p67lBkp2rnaH8Dqtv5tKeOu; (total 60 bytes);
 5: SQL NULL;
 6: SQL NULL;
 7: SQL NULL;
 8: len 4; hex 80000000; asc     ;;
 9: SQL NULL;
 10: SQL NULL;
 11: SQL NULL;
 12: SQL NULL;
 13: SQL NULL;
 14: len 8; hex 8000124c939ad602; asc    L    ;;
 15: SQL NULL;
 16: len 8; hex 8000124c939ad602; asc    L    ;;
 17: len 8; hex 8000124c939ad602; asc    L    ;;

------------------
---TRANSACTION 16B04, ACTIVE 63275 sec
11 lock struct(s), heap size 1248, 12 row lock(s), undo log entries 10
MySQL thread id 6, query id 249 localhost root
Trx read view will not see trx with id >= 16B05, sees < 16B05

….
```

Notice the "Trx read view will not see trx with id >= 16B0D, sees < 16B04" which gives the transaction (16B04) we are waiting on.

To remedy the situation you can see the active processes in the engine with [SHOW PROCESSLIST](http://dev.mysql.com/doc/refman/5.1/en/show-processlist.html):

```
mysql> show processlist;
+----+------+-----------------+---------------+---------+-------+-------+------------------+
| Id | User | Host            | db            | Command | Time  | State | Info             |
+----+------+-----------------+---------------+---------+-------+-------+------------------+
|  1 | root | localhost:49172 | myapp         | Sleep   |   441 |       | NULL             |
|  2 | root | localhost       | myapp         | Query   |     0 | NULL  | show processlist |
|  5 | root | localhost:49675 | myapp         | Sleep   | 63876 |       | NULL             |
|  6 | root | localhost       | myapp         | Sleep   | 63703 |       | NULL             |
|  7 | root | localhost       | myapp         | Sleep   | 63703 |       | NULL             |
+----+------+-----------------+---------------+---------+-------+-------+------------------+
5 rows in set (0.00 sec)
```

[KILL](http://dev.mysql.com/doc/refman/5.0/en/kill.html) can then be used to stop any stalled transactions.

```
mysql> kill 6;
Query OK, 0 rows affected (0.00 sec)
```

[innotop](http://code.google.com/p/innotop/) also appeared useful but I didn't end up needing it.

