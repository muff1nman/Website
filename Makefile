all : buildSite

buildSite: targetDir target/about.html target/index.html target/code.html target/photography.html target/recent.html target/css target/resources target/downloads target/favicon.png

targetDir:
	mkdir -p target

target/about.html : about.htm header.htm footer.htm 
	cat header.htm about.htm footer.htm > target/about.html

target/index.html : index.htm header.htm footer.htm 
	cat header.htm index.htm footer.htm > target/index.html

target/code.html : code.htm header.htm footer.htm 
	cat header.htm code.htm footer.htm > target/code.html

target/photography.html : photography.htm header.htm footer.htm 
	cat header.htm photography.htm footer.htm > target/photography.html

target/recent.html : recent.htm header.htm footer.htm recent.kramdown
	cat header.htm recent.htm > target/recent.html
	kramdown recent.kramdown >> target/recent.html
	cat footer.htm >> target/recent.html

target/favicon.png : favicon.png 
	cp favicon.png target/favicon.png

target/css: css css/pages
	rm -rf target/css
	cp -r css target

target/resources: resources
	rm -rf target/resources
	cp -r resources target

target/downloads: downloads
	rm -rf target/downloads
	cp -r downloads target

clean : 
	rm -rf target

test:
	nohup firefox target/index.html & > /dev/null

deploy: buildSite
	s3cmd sync -M  --delete-removed  --exclude-from=".gitignore" --exclude=".gitignore" --acl-public --mime-type="text/css" target/css/ s3://andrewdemaria.com/css/
	s3cmd sync -M  --delete-removed --exclude-from=".gitignore" --exclude=".gitignore" --acl-public target/ s3://andrewdemaria.com/
