#!/bin/bash

# Remove the Drupal VM git
chmod -R +x .git
rm -r .git

# Create the site git
cd drupal
git init

# Move the scripts into the drupal's scripts folder
mv ../scripts/* scripts/

# Add Alkaline
git submodule add https://github.com/bradtreloar/alkaline web/themes/custom/alkaline