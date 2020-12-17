---
title: Compute time for nothing and 3D models for free
date: Oct 24, 2020
tags: [3D, compute, photo]
description: 82 photos and 11 hours later...

---

# Compute time for nothing and 3D models for free

On my last outing, between lockdowns and preparing for exams, I went to
the local skatepark. It was much emptier than usual, although mostly
because of the meteorological conditions.

I always carry a [Sony RX100](https://www.sony.com/electronics/cyber-shot-compact-cameras/dsc-rx100) on me, so I took some pics of the skating pool.

84 high-res photos (5488x3664px)

With the intent of turning it into a 3D model. Just to see what the
results gonna look like, to see what to watch out for and what is
possible to achieve today. A different kind of an arrow for the quiver.

I did not expect it go too well, but was pleasantly surprised by the result.

## AliceVision/Meshroom

[Meshroom](https://alicevision.org/#meshroom)

a photogammetry framework, [open source](https://github.com/alicevision/meshroom),
works on linux

However, to run the whole pipeline, CUDA is needed. Alas, I have no GPU.

Enter cloud computing.

## Google Colaboratory

Notebook computing. Tesla K80, 12GB RAM Xeon 2.3GHz, 320GB. Wipe every
12 hours.

[MeshroomColab](https://colab.research.google.com/gist/natowi/3044484ad0c98877692c399297e3ab7e/meshroomcolab.ipynb)

## Result

> TODO

