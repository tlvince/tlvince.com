# Portfolio makefile.
# Copyright 2012 Tom Vincent <http://tlvince.com/contact/>

in=public
out=build
bin=node_modules/wintersmith/bin
style=contents/assets/style

all: build

# Temporary hack until wintersmith/#10 is implemented:
# https://github.com/jnordberg/wintersmith/issues/10
build:
	if test -d $(out); then rm -rf $(out); fi
	mkdir -p $(out)/assets/style
	stylus --out $(out)/assets/style --compress $(in)/$(style)/site.styl
	mv $(in)/$(style) tmp-style
	wintersmith build --output ../$(out) --chdir $(in)
	mv tmp-style $(in)/$(style)

preview:
	$(bin)/wintersmith preview --chdir $(in)

push:
	git push origin master
	git push heroku master

compile:
	rm -rf node_modules/wintersmith/lib
	node_modules/wintersmith/node_modules/.bin/coffee \
		-o node_modules/wintersmith/lib \
		-b -c node_modules/wintersmith/src

.PHONY: all build preview push compile
