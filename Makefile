all : targetDir target/about.html target/index.html target/code.html target/photography.html target/recent.html target/css target/favicon.png

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

target/recent.html : recent.htm header.htm footer.htm 
	cat header.htm recent.htm footer.htm > target/recent.html

target/favicon.png : favicon.png 
	cp favicon.png target/favicon.png

target/css: css
	rm -rf target/css
	cp -r css target

clean : 
	rm -rf target

deploy : %.html
	s3cmd sync --acl-public target/ s3://andrewdemaria.com

