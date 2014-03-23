---
layout: post
title:  "Discovering CMake"
date:   2013-08-25
tags: arch linux cmake
---

Arch Linux.  I have been spending quite a bit of time tweaking my arch linux
install just the way I like it and it has been quite the process.  However, I
like to focus not on Arch (maybe another day..), but more on one of the
side effects of redoing 3 or so years of software installs that had built up on
my primary Ubuntu machine... finding new software to replace the old!

One novel tool to me is CMake.  Sure I have heard of it before, but I have never
had projects that exceeded make's capabilities.  For this upcoming semseter, I
am finally diving back into some good ol C/C++ and so I have decided to learn
CMake.  

What a nice change of pace! CMake is actually very intuitive and much less
tedious than writing Makefiles.  Instead you write CMakeLists.txt files and
immediately I noticed some big differences.  

The obvious initial difference is that CMake has a bit more of a declarative
feel to it compared to make's imperative flavor.  So instead of creating targets
and having to describe exactly what to do with each target, with CMake you
describe your project build and let it handle the implementation details.
Interestingly enough, the implementation may very well be generating a Makefile
that can then be run, but this is not something that the user has to tweak or
even deal with.  

For a basic example Makefile I might have to write:

{% highlight Makefile %}
hello: hello.cpp
	g++ hello.cpp -o Hello
{% endhighlight %}

A roughly equivalent CMakeLists.txt file:

{% highlight CMake %}
add_executable(Hello hello.cpp)
{% endhighlight %}

Can you see the difference?  One thing I would like to point out is that there
is no mention of the compiler in CMake.  When cmake is run it will automatically
detect a compiler for you (if you are generating a makefile). 

Of course, this is a trivial example, but what I am beginning to find is that
CMake can scale with project size/complexity on a level that make just can't
keep up with.  In addition, its cross platform!


Another difference is that CMake encourages recursive build scripts. Sure it was
possible with make, but it was always tricky whereas with CMake it is as easy as
`add_subdirectory(DIRECTORY_NAME)`.  Then in that file you will have another
CMakeLists.txt file to handle everything in the subdirectory.

One last cool capability, is CMakes ability to build in out of source
directories. Again, this is not anything that could not be done with make, but
rather is much easier with CMake.

Oh, and it has nice colored terminal output with progress indicators, just to
put the cherry on top.

