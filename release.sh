#!/usr/bin/env bash
set -ue

ref=$1

rm -rf repo/
if [[ ${ref:0:1} == "v" ]]; then
  name=$ref
  git clone https://github.com/angular/angular.js.git repo/ --branch "$ref" --depth 1
  cd repo/
else
  git clone https://github.com/angular/angular.js.git repo/
  cd repo/
  git checkout $ref
  name=$(git describe --tags)
fi

source ../build/$(git describe --tags --abbrev=0).sh

cd build/

IFS=$'\n' LINES=($(find . -depth 1 | grep -v '\.min\.js$' | awk '{print "\"" $0 "\""}'))
MAIN=$(printf ", %s" "${LINES[@]}")
MAIN=${MAIN:1}

cat <<EOF > bower.json
{
  "name": "angular-complete",
  "version": "$name",
  "description": "AngularJS with all core directives and i18n files",
  "keywords": [
    "angular",
    "angularjs",
    "directive",
    "directives",
    "i18n",
    "internationalization"
  ],
  "main": [ $MAIN ],
  "license": "MIT"
}
EOF

git init
cp ../../.git/config .git/
git add -A
git commit -m "$name"
git tag "$name"
git push origin --tags -f
