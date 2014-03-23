---
layout: post
title:  "Setting up Javascript Lint"
date:   2013-08-05
tags: javascript lint vim tech
---

As promised here are the instructions for setting up JavaScript Lint 

*Note these instructions apply for version 0.3.0*. 

First you will need to setup [eclim](http://eclim.org/index.html). Eclim is a
layer of software that lets you interact with eclipse in vim, or conversely, use
vim while in eclipse.  You\'ll want to choose the headless install process
(otherwise you are just using Eclipse at which point this guide isn\'t very
relevant). Although I may touch on setting up eclim at some time in the future,
it is a bit outside of the scope of the post for today. You won\'t actually need
to have eclimd running, as the validation checker is a utility file that works
strictly in vim.  With that in mind, it should be relatively easy for one to
pluck the script out of the eclimd files and set it up as a separate vim
plugin.. 

Next, you will need to download the
[source](http://www.javascriptlint.com/download.htm) for JavaScript Lint.
Extract and `cd` into the `src/` directory.  Inside you should find a README
file that has some very rough instructions.  The README references `gmake` which
according to the interwebs is essentially just `make` on modern day Linux
machines.  At any rate, run:

{% highlight bash %}
export BUILD_OPT=1 # turns off debugging
make -f Makefile.ref
{% endhighlight %}

At this point I was hesitant to run a `make install` and in fact, I did not even
see a target in the Makefile.  Instead what I opted to do was to drop the
executable inside my `/opt` directory. The excutables are stored in a generated
directory named `Linux_All_OPT.OBJ` (or `Linux_All_DBG.OBJ` if you did not set
`BUILD_OPT`).  I then copied this directory's contents to my `/opt` directory.

{% highlight bash %}
sudo mkdir /opt/jsl-0.3.0
sudo cp Linux_All_OPT/* /opt/jsl-0.3.0
{% endhighlight %}

Finally add the path to the executable to your `PATH` envirnonment variable.
You now should be able to run `jsl` from the command line. The vim script will
automatically do the rest at this point provided it can find the executable.  `which jsl`
is your friend here.


