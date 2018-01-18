#!/bin/sh
STATUS="$(git status -s)"
RED='\033[0;31m'
NC='\033[0m' # No Color

if [[ -z "${STATUS// }" ]]
then
    node_modules/.bin/cpx -r documentation/* demo/dist/api/
    sed -i "" '/\/dist/d' ./.gitignore
    git add .
    git commit -m "Edit .gitignore to publish"
    git push origin `git subtree split --prefix demo/dist/api master`:gh-pages --force
    git reset HEAD~
    git checkout .gitignore
else
    printf "${RED}ERROR:${NC} Need clean working directory to publish\n"
fi
