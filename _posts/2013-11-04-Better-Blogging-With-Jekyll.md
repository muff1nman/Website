---
layout: post
title: "Better-Blogging-With-Jekyll"
date: 2013-11-04
tags: jekyll blog
---
I'll confess, school has been very busy and hence the prolonged update.  For
starters, I have upgraded how the site is managed.  Remeber the [first
post]({{site.baseurl}}{% post_url 2013-06-30-First-Post %}) I made with that
giant makefile?  Well here is my new makefile:

~~~ make
DEPLOY_DIR:=_site

all : buildSite

buildSite: 
	jekyll build

clean : 
	@rm -rf $(DEPLOY_DIR)

deploy: buildSite
	s3cmd sync -M  --delete-removed  --exclude-from=".gitignore" --exclude=".gitignore" --acl-public --mime-type="text/css" $(DEPLOY_DIR)/css/ s3://andrewdemaria.com/css/
	s3cmd sync -M  --delete-removed --exclude-from=".gitignore" --exclude=".gitignore" --exclude=".gitmodules" --acl-public $(DEPLOY_DIR)/ s3://andrewdemaria.com/
~~~

Quite a difference, don't you think?  As you may have noticed under the
`buildSite` target, I am now using [jekyll](http://jekyllrb.com/) to build the
site.  It was a painless migration as jekyll goes down the same road that I was
initially headed:  use markdown to generate posts, collect it all together and
deploy it as a static site. It is actually a common way to use [Github
Pages](https://help.github.com/articles/using-jekyll-with-pages), so while I am
using Amazon S3, you can also just push your code to a Github repo for the same
effect.

With that done and out of the way, it should be a bit more painless to create
blogs. Upcoming I should have some interesting tidbits to share about some of my
school projects. 
