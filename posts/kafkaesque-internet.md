---
title: Kafkaesque Internet
description: The Internet is broken.
date: Oct 02, 2021
tags: [ internet, streams, logs ]

---

# Kafkaesque Internet

> **DISCLAIMER**: this is an article about the internet from purely
> technological point of view.

## What's the internet

When we talk the Internet, we really mean the web.
And web is really just HTTP.

## How it works

1. Send `OPTIONS` to see available methods
2. `GET` to retrieve content
3. `PUT` to add content
4. `POST` can update or do anything

Except that's not how it works at all.

## How it actually works

Pages update asynchronously.
Content comes from multiple sources.
Users submit multiple actions concurrently.
Analytics are collected about everything.
Content is generated on demand.

And no one wants to see it fail or worse freeze while loading.
And we would like everything to work offline.

## Intermission : GraphQL

A nice real world example of a real world project recognizing the issues
of pulling content from multiple sources in various formats is GraphQL.

Send a single query describing the data you want.
Get it the way you want on a best effort basis.
(Even across multiple responses based on the priority.)

Updates are iffy, because we want to push the user actions to the server
ASAP, not wait and batch them.
Also can still fail...

## Eventual consistency required eventual delivery

To avoid failure, let's log every action locally before trying to
execute it.
Write-ahead logs are a very elegant solution from the database world.

1. Log the user action to a local persistent log.
2. Materialize the change into the local view.
3. At convenience / when available, sync the log with the server.

When we synchronize the logs we make them available for other devices to
pull and materialize the collected actions locally themselves.
Careful about conflicts -- we need to be deliberate about the way we
handle conflicts.

Conflict resolution is very application specific and requires careful
planning.
Sometimes simple last write wins can work just fine, sometimes we need
to design the actions to not create conflicts (CRDTS), and sometimes we
need to be very granular and have multiple resolution strategies.
More about that some other time.

## Globally Persistent Connections

A `User` can have multiple `Connection`s -- one per client.
`Connection` can be `active` or `inactive`.
`Active Connection` has a reserved data channel at the `Server` and will get
an update whenever connected.
An `active Connection` can be downgraded to `inactive` by the `Server`.
`Inactive Connection` will not get updated but overwritten by a clone of
an `active Connection` when connected to the `Server`.

Setting resource limits is necessary to guarantee quality of service.

We can be smart about transitioning `Connection`s to inactive though.

## What do we get?

More like what do we not get?

- No errors! (just delays)
- No contradictions in state (if we materialize correctly)
- Full history (if we keep the logs)
- User authentication (partially, through the logs; still need initial)

All of that for free, just by using persistent connections.
And remember:

> Persistent connections are just write ahead logs.

## Honorable mentions

### Kafka

Can we run it in browser?

### ZeroMQ

Very cool project providing good abstractions over basic connections.
Not quite new Internet, just Internet on steroids. Still cool though.
