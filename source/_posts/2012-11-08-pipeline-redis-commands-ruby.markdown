---
layout: post
title: "5-10x Speed Ups by Pipeling Multiple REDIS Commands in Ruby"
date: 2012-11-08 14:36
keywords: pipelining, redis pipelining, ruby, redis performance, ruby, rails, ruby on rails
comments: true
categories: 
tags:
- redis
- ruby
- rails
---

[REDIS](http://redis.io) is fast. Really fast. And awesome. But that doesn't mean you can get lazy with how you use it. [Pipelining REDIS commands](http://redis.io/topics/pipelining) allows you to execute multiple commands in REDIS and return the results at once. I've seen this provide a 5x-10x speedup. He's how to do it with the Ruby driver.

<!-- more -->

## Why You Should Pipeline

(If your code isn't performance sensitive the following is probably unnecessary.) When working with REDIS, look out for code blocks that look like this:

1. ask REDIS for something
1. do something with it
1. repeat

Depending on the number of calls you make, you could be paying a lot in over-the-wire and connection overhead (even within the same data center). A better model is to do something like this:

1. collect all your commands
1. send them to REDIS
1. unpack the result and do something with it

Even with REDIS being very, very fast and the server being close to the client, this can lead to significant improvements in speed. I've seen a handful of commands (< 10) pipelined to drop a 250ms page render to 50ms.

## Get Your Pipe On

Here's the general structure of using the Ruby driver to pipeline multiple REDIS commands. When you execute a command, rather than getting the result you get a [Future](https://github.com/redis/redis-rb#futures) object which you can ask for the result when it's available.

Using Future comes with a few challenges:

* If you are executing the command based on some context (such as a related object) you need that context when you get the result
* Future doesn't provide a nice way of waiting for the value to be realized or even checking if it has been

In this example, we'll iterate through a number of objects each one needing a REDIS hash.

```ruby
# we'll collect a number of Futures with their related context
# Let's pretend have a number of objects and need to get their associated data
cmds = []
objects = [] # we'll pretend this isn't empty

# Create the pipelined commands. Any REDIS commands executing in this block will return Futures rather than values
redis.pipelined do
  objects.each do |object|
    cmds << { future: redis.hgetall(object.key), object: object }
  end
end

# Now that we have our commands executing we need to wait for the values to come back
cmds.each do |c|
  # wait for each one to come back before proceeding. this is not ideal but simple and seems to work fine.
  while c[:future].value.is_a?(Redis::FutureNotReady)
    sleep(1.0 / 100.0)
  end

  value = c[:future].value
  object = c[:object]

  # do something with the REDIS return value and our context
  object.values = value
end
```

## Improvements

You can see that the model here is pretty disjointed and makes for less-maintainable code. The problem is having to break your code up causing you to lose context. Something like this might make more sense (**warning** untested ruby pseudocode ahead):

```ruby
Pipeliner.pipeline redis do |pipe|
  objects.each do |object|
    pipe.enqueue redis.hgetall(object.key) do |result|
      object.values = result
    end
  end
end
```

`Pipeline` could look like this:

```ruby
class Pipeliner
  def initialize(redis)
    @redis = redis
    @cmds = []
  end

  def enqueue(future, &proc)
    @cmds << { future: future, callback: proc }
  end

  def wait
    @cmds.each do |c|
      while c[:future].value.is_a?(Redis::FutureNotReady)
        sleep(1.0 / 100.0)
      end

      c[:callback].call c[:future].value
    end
  end

  def self.pipeline(redis, &proc)
    # Executes callbacks with each result. This blocks.
    pipeliner = Pipeliner.new redis
    redis.pipelined do
      proc.call pipeliner
    end

    pipeliner.wait
  end
end
```
