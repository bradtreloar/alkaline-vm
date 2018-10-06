#!/bin/bash

DRUPAL=$PWD

# @todo check that we're in the right directory

# Create database export folder
mkdir -p $DRUPAL/data

# Clear out old exports
rm $DRUPAL/data/*

# Export database
cd $DRUPAL/web
drush sql:dump > $DRUPAL/data/drupal_$(date +%F_%R).sql

drush config:export

# Commit exported data to Git
cd $DRUPAL
git add data
git add config
git commit -m "export data and config"
