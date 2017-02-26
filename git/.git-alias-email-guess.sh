#!/bin/bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=benregn@gmail.com # default

if [[ $remote == *github.com:FalconSocial* ]]; then
  email=tomas@falcon.io
fi

echo "Configuring user.email as $email"
git config user.email $email
