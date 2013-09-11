#!/bin/sh

wintersmith="./node_modules/wintersmith/bin/wintersmith"
public="public"

# Relative to public
build="../build"

[ -d "$build" ] && rm -rf "$build"
"$wintersmith" build --output "$build" --chdir "$public"
