---
title: Personal computers, personal computing, and data
description: they almost got it right
date: Aug 24, 2021
tags: [ computing, distributed, cloud ]

---

# Personal computers, personal computing, and data

- Cloud - I don't care where the computation happens
- Von Neumann - data and operations are very simillar
- S3 - almost
- Erlang - systems that evolve

## Cloud

I don't even know where this blog is hosted at.
Somewhere in the cloud, who cares. As long as it works.

Well, it's hosted on GitHub pages.
I know where the sources are, everything is in git,
gets built and transformed for publishing, and checked right back into git.
Code and data together at last.

## Are databases evil?

Von Neumann architecture.
Why treat data and computation differently?
Isn't treating data specially a huge regression?

I reckon the answer is the same as for another question:
Why would anyone write C in 2021?

Can we have one system to handle everything:
distribution, versioning, tables, assets, transformations, ...?
Can we use Erlang?

## State of the union

Streaming architectures are moving in the general direction of the grand
unification of data and computation.
Still, how do you update the processors?

Blockchains come to mind here. Most are obsessing over semi-valid
visions or grandeur.
How did it work out for BitTorrent?
New internet... sure.

S3 is cool, as a simple abstraction over disk storage.

Honorable mentions:
- kubernetes and friends
- virtualization
- WASM
