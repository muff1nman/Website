---
layout: post
title:  "First Post"
date:   2013-06-30
tags: blog make website
---

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

