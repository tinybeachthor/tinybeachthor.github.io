---
title: Towards EXPO2021
description: planning an AR experience
date: Aug 06, 2021
tags: [ expo, AR ]

---

# Towards EXPO2021

> TODO: link to the project here

[Last year](https://tinybeachthor.github.io/post/aframe-forking-required.html) I started a tradition of making a small self-contained technology art project.
The idea came from the necessity -- I needed a way to make photo
exhibition during a pandemic.
The answer was VR.

A year later and it is about time to start working on this year's
project.
Last year was VR.
It is very obvious where this is going.
We are building an AR experience!

## What's it gonna be

![YZY Foam Runner MX Cream Clay](https://hypebeast.com/image/2021/07/adidas-yeezy-foam-runner-mx-cream-clay-official-look-release-info-gx8774-1.jpg)

The story behind the inspiration for the project is a classical one:

1. Kanye teases new ugly shoes
2. Ugly shoes are releases in a limited run
3. No shoes...

Though ugly, there is something really cool about the grown-like -- as
opposed to made -- structure of it.
Nature is cool.

Other cool grown-like things to investigate (concrete!):

![3D printed concrete columns](https://static.dezeen.com/uploads/2019/07/concrete-choreography-3d-printed-columns-stage-eth-zurich-students-switzerland_sq-c.jpg)

![3D printed concrete tree-like structure](https://www.sculpteo.com/blog/wp-content/uploads/2016/12/xtree1.jpg)

## What to do

Let's grow virtual shoes on everyone's feet!

### AR rendering

[THREE.js + svelte](https://svelthree.dev/)

Should be fast enough, otherwise stitch all code together and hand
optimize the 3D rendering.
The biggest bottleneck should be the AR object detection.

### AR object detection

We need to detect people's feet in the video.
Since people wear shoes a lot, we can get away by [detecting shoes](https://google.github.io/mediapipe/solutions/objectron.html).

_Render the virtual shoes oversized._
![Weird blocky oversized outfits.](https://www.youtube.com/watch?v=cwQgjq0mCdE)

### Grow the shoes

Simulate tentacles growing on top of a surface.

1. Define shoe base geometry with equations
2. Determine shoe normals & climb over the surface like a vine
3. Inflate the path with tentacle geometry

Initialize RNG from the camera image -- needs to be robust.

### Library, Achievements, Socials

Make this an "experience" with a library of saved models.
Share images to socials.
Add achievements to drive engagement.

## That's about it

Rather complex all in all, but should be doable.

1. Setup rendering
2. Create tentacle geometry
3. Simulate vine-like growth
4. Shoe detection from video stream
5. AR detect shoe positions
6. Place virtual shoe in space
7. Polish with engagement features
