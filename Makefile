# Portfolio makefile.
# Copyright 2012 Tom Vincent <http://tlvince.com/contact/>

in=public
out=build
bin=node_modules/wintersmith/bin
style=contents/assets/style

all: build

build: clean
	$(bin)/wintersmith build --output ../$(out) --chdir $(in)
	mv $(out)/journal/entry/* $(out)
	rm -rf $(out)/journal

	# Hacky Pandoc-like smart punctuation
	sed -i -e "s/\.\.\./…/g" -e "s/ --- / — /g" $(out)/*.html $(out)/feed

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

install:
	rm -rf node_modules/wintersmith
	npm install

update: install compile

clean:
	if test -d $(out); then rm -rf $(out); fi

heroku: compile build

.PHONY: all build preview push compile clean install update heroku
