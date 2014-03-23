---
layout: post
title:  "The Bitmarket Project"
date:   2013-07-28
tags: bitmarket ruby
---

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

{% highlight ruby %}
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
{% endhighlight %}

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


