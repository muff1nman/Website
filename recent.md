2013.09.05
--------
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

~~~ bash
export BUILD_OPT=1 # turns off debugging
make -f Makefile.ref
~~~

At this point I was hesitant to run a `make install` and in fact, I did not even
see a target in the Makefile.  Instead what I opted to do was to drop the
executable inside my `/opt` directory. The excutables are stored in a generated
directory named `Linux_All_OPT.OBJ` (or `Linux_All_DBG.OBJ` if you did not set
`BUILD_OPT`).  I then copied this directory's contents to my `/opt` directory.

~~~ bash
sudo mkdir /opt/jsl-0.3.0
sudo cp Linux_All_OPT/* /opt/jsl-0.3.0
~~~

Finally add the path to the executable to your `PATH` envirnonment variable.
You now should be able to run `jsl` from the command line. The vim script will
automatically do the rest at this point provided it can find the executable.  `which jsl`
is your friend here.


2013.09.04
--------
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

![JSLint](resources/jslint_screen.png)

Tomorrow I\'ll hopefully have the installation instructions up for \*Nix
machines.

2013.08.28
--------

So I have been working on this awesome new project of mine called bitmarket.
It\'s a cool library that lets you automate bitcoin trading (and perhaps other
currencies if I\'ve modularized it right..)  But at any rate the idea is that
you can setup a couple algorithms of your own and then let this library handle
all the rest.  For example, I might think that if I buy bitcoins when the price
is 4% below the 2 day moving average and its a Monday but sell when its 10%
above the moving average and its Friday that I would strike it rich.  Well this
library allows you to test your hypothesis and possibly make (or break) your
day!

Here is an example \'algorithm\'/demo program that I made the other day. The API
is still a little off from being finalized as there are some tweaks I would
like to do.

~~~ ruby
#! /usr/bin/env ruby
#
# Copyright © 2013 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# All Rights Reserved.

require_relative 'bitmarket'

DATABASE_URL = "sqlite:////home/andrew/bitbite.db"
Bitmarket::History.setup DATABASE_URL
Bitmarket::Trader.setup DATABASE_URL

class SmartTrigger < Bitmarket::Trigger

	def trigger
		if b_meter > 1
			Bitmarket::MarketStrategy.new( :sell, BigDecimal.new("0.2"), :btc, get_current_value, :usd)
		elsif b_meter < 0 
			Bitmarket::MarketStrategy.new( :buy, BigDecimal.new("0.2"), :btc, get_current_value, :usd)
		else
			Bitmarket::MarketStrategy.new( :nothing, nil, nil, nil, nil )
		end
	end

	def get_current_value
		Bitmarket::Exchange.current_price
	end
end

# build strategy
strategy = Bitmarket::Strategy.new
strategy.add( SmartTrigger.new, :smart_trigger )

# build analyzer
analyzer = Bitmarket::Analyzer.new( strategy )

# create bank
bank = Bitmarket::Bank.new( {usd: 100, btc: 2} )

# build trader
trader = Bitmarket::LoggerTrader.new( bank )

# final step
bit = Bitmarket::Bitmarket.new

bit.start_historian(30)
bit.start_analyzing( analyzer, 60)
bit.start_trading( trader )

sleep 

bit.stop_historian
bit.stop_analyzing
bit.stop_trading
~~~

Eventually I would like to make a DSL (Domain Specific Language) for it so that
it takes care of the setup and tear down process and so that the language for
the triggers is simple and straight forward, but for now this will have to
suffice. 

Although its close to being able to sync up with the MtGox bitcoin exchange, I
am testing it extensively and trying to create my own good algorithms :)  As you
can see, right now it will only log trades and use a top level bank class that
is not hooked up with the MtGox API, but again this is in the tubes!

The only remaining question becomes... do I go open source? On one hand it would
be nice to get some more contributors on board to expand and test it.  Yet what
if it becomes popular enough that it stablizes the bitcoin currency and I can no
longer make a profit off its volatility?  Or maybe this could expand to be
compatible with other currencies and become popular with more serious currency
traders?  You never know...


2013.07.01 
--------

I just found one of the coolest things that I wish I would have found years ago!
You know when you get those songs from random places; friends, cds, shady places
on the internet, etc and for whatever reason you don\'t get the track information
with the song?  It bugs the crap out of me, mostly because I like my music
library nice and neat. 

Introducing the Last.fm fingerprint plugin for Banshee.  This gives me the
option to right click on any song in my library and have it match the sound
signature with one on Last.fm\'s service. Of the 20 or so songs I tried it out
with, it worked perfectly and was able to find the correct artist, ablum and
title in addition to the other good info.  Neato!

2013.06.30
--------

Well, I have been meaning to create a blog for quite some time, if for no other
reason than to document my swimming through life\'s turbulent waters.  I plan on
keeping heavily to ranting on my new discoveries in technology and computing but
occasionally I am sure you will find other remnants of my life such as recent
pictures. 

As far as the site goes, I plan on redesigning it as I have time.  Right now it
looks awful, but then again I put it together hastily. Also, I have decided that I enjoy using
Amazon Web Services.  This site, for example, is hosted on an s3 bucket and
deployed using a short but sweet Makefile script. Most of the work is actually
done with a neat tool called [s3 tools](http://s3tools.org/s3cmd) and it seems
perfect for deploying public assets such as a website.

Here is what the Makefile looks like:

~~~ Makefile
MD = kramdown
MD_ARGS = --coderay-line-numbers table

all : buildSite

target/%.html : header.htm footer.htm %.htm
	@cat header.htm $*.htm > target/$*.html
	@echo "" | cat - $*.kramdown 2>/dev/null | $(MD) $(MD_ARGS) >> target/$*.html
	@cat footer.htm >> target/$*.html

buildSite: targetDir target/about.html target/index.html target/code.html target/photography.html target/recent.html target/css target/resources target/downloads target/favicon.png

targetDir:
	@mkdir -p target

target/favicon.png : favicon.png 
	@cp favicon.png target/favicon.png

target/css: css css/pages
	@rm -rf target/css
	@cp -r css target

target/resources: resources
	@rm -rf target/resources
	@cp -r resources target

target/downloads: downloads
	@rm -rf target/downloads
	@cp -r downloads target

clean : 
	@rm -rf target

test:
	@nohup firefox target/index.html & > /dev/null

deploy: buildSite
	s3cmd sync -M  --delete-removed  --exclude-from=".gitignore" --exclude=".gitignore" --acl-public --mime-type="text/css" target/css/ s3://andrewdemaria.com/css/
	s3cmd sync -M  --delete-removed --exclude-from=".gitignore" --exclude=".gitignore" --acl-public target/ s3://andrewdemaria.com/
~~~

It\'s a bit hackish in some aspects. The one ugly line is line 8.  I wanted to
have one target declaration for all the different pages.  The one page that is
different is the page you are reading which is compiled with kramdown. To get
around this all pages look for a kramdown file.  If its not there, some empty
tags get pushed into the html. 

Eventually I may decide to move on to a Rakefile or an Ant script, but for now
it seems to do the job well.

Now to see how well I keep up on posting frequently :)

