#!/bin/sh

./scripts/build.sh

for i in build/*; do
  [ -f "$i" ] && [ "${i##*.}" == "$i" ] && mv "$i" "$i".html
done

rm -rf build/{comments,journal,untitled.html}
rm -rf build/assets/{.git*,*.{png,ico,txt,xml}}
rm -rf build/assets/styles/{anchor,base,responsive,utilities,variables}.css

ditto build ../tlvince.github.io
cd ../tlvince.github.io
git add .
git commit --all --message "Publish as of $(date +%Y%m%d%H%M%S)"
git push origin master
cd -
