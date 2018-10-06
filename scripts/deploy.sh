#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: deploy.sh HOSTNAME"
    exit 0
fi

HOSTNAME=$1

# Configure SSH
ssh-keygen
touch $HOME/.ssh/config
chmod -w $HOME/.ssh/config
nano $HOME/.ssh/config

# Add access key to Git server
ssh-copy-id -i ~/.ssh/id_rsa.pub treloardigitalco@treloardigital.com.au -p 21212

# Clone the git repo
cd $HOME
git clone --recurse-submodules ssh://treloardigital.com.au:/home/treloardigitalco/git/$HOSTNAME.git drupal

# Symlink public_html directory to drupal docroot
rm -r public_html
ln -s drupal/web public_html

# Run the composer installation
composer install

# Install Drush launcher
wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
mkdir -p $HOME/.local/bin
mv drush.phar $HOME/.local/bin/drush
chmod +x $HOME/.local/bin/drush