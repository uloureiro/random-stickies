#!/usr/bin/env sh

# abort on errors
set -e

git config --global -l
git config --global user.email circleci@circleci
git config --global user.name CircleCI

git init
git add -A
git commit -m "CircleCI Deploy (`date '+%F %T %Z'`)"

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:uloureiro/random-stickies.git master:gh-pages

cd -