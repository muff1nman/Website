DEPLOY_DIR:=_site

all : buildSite

buildSite: 
	jekyll build

clean : 
	@rm -rf $(DEPLOY_DIR)

deploy: buildSite
	s3cmd sync -M  --delete-removed  --exclude-from=".gitignore" --exclude=".gitignore" --acl-public --mime-type="text/css" $(DEPLOY_DIR)/css/ s3://andrewdemaria.com/css/
	s3cmd sync -M  --delete-removed --exclude-from=".gitignore" --exclude=".gitignore" --exclude=".gitmodules" --acl-public $(DEPLOY_DIR)/ s3://andrewdemaria.com/
