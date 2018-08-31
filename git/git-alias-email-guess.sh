#!/usr/bin/env bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=benregn@gmail.com # default

if [[ $remote == *github.com:meneto* ]]; then
  email=tojo@meneto.com
fi

echo "Configuring user.email as $email"
git config user.email $email
