---
title: Keeping it safe with macros
description: racket macros for hyper defensive programming
date: Feb 02, 2021
tags: [ racket, macro ]

---

# Keeping it safe with macros

Playing around with the excellent [pure data](https://puredata.info/exhibition),
embedding it in a racket framework to get the extra super freedom of expression.
How to abstract away all the C level details?
Syntax parameters!

## What is pure data?

Visual programming environment for multimedia,
mostly sound.
Really great because of very fast feedback - hear changes live.
Also it's easier to see sound transformations wired on a patchboard.

There are some limitations, and some operations are not easily handled in pure data.
Possible to interface from pd outside, and from outside to pd -
[libpd](https://github.com/libpd/libpd).

## Embedding pure data patches

How better to complement a fast prototyping framework than with the best LISP?
Enter [racket](https://racket-lang.org/).

To send some data and export a sound from pd instance,
a naive implementation yields the following:

```racket
(let ([pd (make-pd-instance)])
 (begin
  (pd-instance-open-project-patch pd "kick.pd")
  (pd-instance-send-float pd "kick_transient" 0.035)
  (pd-instance-send-float pd "kick_max_pitch" 292.2)
  (pd-instance-send-float pd "kick_fall_time_1" 17.59)
  (pd-instance-send-float pd "kick_break_pitch" 83.89)
  (pd-instance-send-float pd "kick_fall_time_2" 1042.0)
  (pd-instance-send-float pd "kick_amp_decay" 1120.0)
  (pd-instance-tick pd)
  (pd-instance-send-bang pd "kick_bang")
  (begin0
    (pd-instance-export pd 5)
    #| ... |#
    #| close and free everything ... |#
    #| ... |#
    )))
```

Gritty, chaotic, noisy and annoying. Very C.
A lot is left to be desired here,
especially since we have all these awesome metaprogramming features available in racket.

## What

What can be improved?

- do not lose any flexibility
- create / free pd instance automatically
- make the pd commands available only inside the given context
  (getting strong monadic vibes here)
- hide repetitive passing of pd instance reference

## How

Now to implement it.

### Memory management

```racket
(define executor (make-will-executor))
(void (thread (lambda ()
                (let loop ()
                  (will-execute executor)
                  (loop)))))

(define (pd-instance-free pd)
  (libpd_free_instance pd))

#| after creating a pd-instance: |#
(will-register executor instance pd-instance-free)
```

That should be enough to automatically the free once the pd-instance goes out of scope.

### Isolated context

To create the pd-instance, pass it where necessary
and keep the pd specific functions only accesible in this context,
now this is asking for quite a lot.
Better bring out the big guns!
[Syntax parameters](https://docs.racket-lang.org/reference/stxparam.html)
will let us dynamically re-bind syntax to different expressions depending on context.

At first we define empty syntax parameters
(these will result in an exception if evaluated):

```racket
(require
  racket/stxparam
  racket/splicing)

(define-syntax-parameter open-project-patch (syntax-rules ()))
(define-syntax-parameter send-float (syntax-rules ()))
(define-syntax-parameter send-bang (syntax-rules ()))
(define-syntax-parameter tick (syntax-rules ()))
(define-syntax-parameter export-rsound (syntax-rules ()))
```

_Ideally these would throw custom exceptions,
or result in a noop, or a sane default behavior._

And the context macro to substitute the parameters:

```racket
(define-syntax with-pd-instance
  (syntax-rules ()
    [(_ (action args ...) ...)
     (let ([pd* (make-pd-instance)])
       (splicing-syntax-parameterize
         ([open-project-patch (lambda (stx) #'(curry pd-instance-open-project-patch pd*))]
          [send-float (lambda (stx) #'(curry pd-instance-send-float pd*))]
          [send-bang (lambda (stx) #'(curry pd-instance-send-bang pd*))]
          [tick (lambda (stx) #'(lambda () (curry pd-instance-tick pd*)))]
          [export-rsound (lambda (stx) #'(curry pd-instance-export-rsound pd*))])
         (begin
           ((action) args ...) ...)))]))
```

When expanded, this will create a new pd-instance,
set the syntax parameters to pass the instance to the underlying function,
and unwrap the body of the macro otherwise unchanged.
(The freeing of the instance is already handled by the will-executor.)

Using the syntax parameters also guarantees that
[our macros are hygienic](http://scheme2011.ucombinator.org/papers/Barzilay2011.pdf).

## The final form

Now this:

```racket
(let ([pd (make-pd-instance)])
 (begin
  (pd-instance-open-project-patch pd "kick.pd")
  (pd-instance-send-float pd "kick_transient" 0.035)
  (pd-instance-send-float pd "kick_max_pitch" 292.2)
  (pd-instance-send-float pd "kick_fall_time_1" 17.59)
  (pd-instance-send-float pd "kick_break_pitch" 83.89)
  (pd-instance-send-float pd "kick_fall_time_2" 1042.0)
  (pd-instance-send-float pd "kick_amp_decay" 1120.0)
  (pd-instance-tick pd)
  (pd-instance-send-bang pd "kick_bang")
  (begin0
    (pd-instance-export pd 5)
    #| ... |#
    #| close and free everything ... |#
    #| ... |#
    )))
```

becomes:

```racket
(with-pd-instance
  (open-project-patch "kick.pd")
  (send-float "kick_transient" 0.035)
  (send-float "kick_max_pitch" 292.2)
  (send-float "kick_fall_time_1" 17.59)
  (send-float "kick_break_pitch" 83.89)
  (send-float "kick_fall_time_2" 1042.0)
  (send-float "kick_amp_decay" 1120.0)
  (tick)
  (send-bang "kick_bang")
  (export 5))
```

