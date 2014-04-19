---
layout: post
title:  "Javascript Lint"
date:   2013-08-04
tags: javascript lint
---

Just a short one today...

Javascript is an interesting language.  It combines the syntax structure of C,
Java and other bracey languages with a dynamically typed one like Python.  Yet
at the same time it isn\'t quite Object Oriented with a hint of Functionalism.  

Right from the get-go Javascript has felt clunky to me.  Its like a hybrid
language that can\'t quite decide what its meant for.
[JQuery](http://jquery.com/) has made working with the language much more
enoyable but I still haven\'t reached a point of being able to put Javascript
on my tool belt. However, I did find something bringing me one step
closer:  [JavaScript Lint](http://www.javascriptlint.com/)  integration with Vim. [Source
Forge](http://sourceforge.net/projects/javascriptlint/)

JavaScript Lint allows me to write all my Javascript in vim and when I save a file, it
produces nice errors next to the line numbers. It allows for immediate feedback
and saves a trip to the browser and back.  It seems pretty solid (I haven't run
into any issues yet) but it also seems that development on the project has
stalled a bit. **Update 2013.09.05** Here is a
[fork](https://github.com/davepacheco/javascriptlint) of the project that seems
a bit more updated.

![JSLint]({{ BASE_PATH }}/resources/jslint_screen.png)

Tomorrow I\'ll hopefully have the installation instructions up for \*Nix
machines.

