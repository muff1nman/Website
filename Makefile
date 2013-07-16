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
