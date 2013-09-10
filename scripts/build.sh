#!/bin/sh

coffee="./node_modules/.bin/coffee"
wintersmith="./node_modules/wintersmith"
public="public"

# Relative to public
build="../build"

# XXX: Needed to respect the new `filenameTemplate` config
rm -rf "$wintersmith/lib"
"$coffee" -o "$wintersmith/lib" -b -c "$wintersmith/src"

[ -d "$build" ] && rm -rf "$build"
"$wintersmith/bin/wintersmith" build --output "$build" --chdir "$public"
