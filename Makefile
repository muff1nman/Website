all : target/about.html target/index.html target/code.html target/photography.html target/recent.html target/css

targetDir:
	mkdir -p target

target/about.html : about.htm header.htm footer.htm targetDir
	cat header.htm about.htm footer.htm > target/about.html

target/index.html : index.htm header.htm footer.htm targetDir
	cat header.htm index.htm footer.htm > target/index.html

target/code.html : code.htm header.htm footer.htm targetDir
	cat header.htm code.htm footer.htm > target/code.html

target/photography.html : photography.htm header.htm footer.htm targetDir
	cat header.htm photography.htm footer.htm > target/photography.html

target/recent.html : recent.htm header.htm footer.htm targetDir
	cat header.htm recent.htm footer.htm > target/recent.html

target/favicon.ico : favicon.ico targetDir
	cp favicon.ico target/favicon.ico

target/css: targetDir 
	rm -rf target/css
	cp -r css target

clean : 
	rm -rf target

deploy : targetDir %.html
	s3cmd sync --acl-public target/ s3://andrewdemaria.com

