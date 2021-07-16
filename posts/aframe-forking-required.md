---
title: "A-FRAME - some forking required"
date: Oct 31, 2020
tags: [aframe, photo, complexity]
description: my experience with a-frame, building a VR photo album

---

# A-FRAME - some forking required

About building a VR photo album as this years' "expo".
Here is the final result:

[trestripes 2020 expo](https://expo.trestripes.com/2020/index.html)

This was built using the industry-standard, and the only full-fledged
solution to VR and AR website experiences - ["A-FRAME"](https://aframe.io/).
Here follows the very incomplete documentation of the whole process, and
some observations.

## Extensibility

A-frame is a rather thin wrapper around THREE.js and the DOM. It does
not try to provide solutions to every use-case ever. But offers good
defaults and provides a standard way of extending it - writing custom
components.

Sounds great, but.
For this relatively small website, I had to create 2 custom components.
One for the layout and one for fitting geometry to the texture size.

These components were not custom, just customized - but still had to
fork the whole code.

### OO vs f

This exposes the biggest issue with objects - they are entities of their
own. Encapsulating a certain behavior or workflow instead of an
operation, which could be rewired in a different way.

Because of needing to change a single line in the
`fit-texture-component` I will be stuck with maintaining the fork of
this component.

> When extensibility is a priority, objects are not an option.

### Complex and Complicated

Here is a nice overview of addressing innate complexity by Alan Kay.

![Is it really "Complex"? Or did we just make it "Complicated"?](https://www.youtube.com/watch?v=ubaX1Smg6pY)

The overall idea of the talk is - even though some tasks are inherently
complex, we can split them into simpler atomic pieces and address them
one by one.

If we are able to solve the atomic pieces completely, such that the
complexity does not leak into other parts depending on this one, we have
successfully simplified the problem.
