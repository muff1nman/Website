DEPLOY_DIR:=_site

all : buildSite

.PHONY: css
css:
	pygmentize -S autumn -f html > assets/themes/twitter/css/code.css

buildSite: css
	jekyll build

.PHONY: test
test: css
	./test.sh

clean : 
	@rm -rf $(DEPLOY_DIR)

deploy: buildSite
	s3cmd sync -M  --delete-removed  --exclude-from=".gitignore" --exclude=".gitignore" --acl-public --mime-type="text/css" $(DEPLOY_DIR)/css/ s3://andrewdemaria.com/css/
	s3cmd sync -M  --delete-removed --exclude-from=".gitignore" --exclude=".gitignore" --exclude=".gitmodules" --acl-public $(DEPLOY_DIR)/ s3://andrewdemaria.com/
