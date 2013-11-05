DEPLOY_DIR:=_site

all : buildSite

.PHONY: buildSite
buildSite: 
	jekyll build

clean : 
	@rm -rf $(DEPLOY_DIR)

test: buildSite
	@nohup firefox $(DEPLOY_DIR)/index.html & > /dev/null

deploy: buildSite
	s3cmd sync -M  --delete-removed  --exclude-from=".gitignore" --exclude=".gitignore" --acl-public --mime-type="text/css" $(DEPLOY_DIR)/css/ s3://andrewdemaria.com/css/
	s3cmd sync -M  --delete-removed --exclude-from=".gitignore" --exclude=".gitignore" --exclude=".gitmodules" --acl-public $(DEPLOY_DIR)/ s3://andrewdemaria.com/
