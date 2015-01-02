#!/bin/sh

# Sets up c9 environment for dev/test

sudo chmod 644 /etc/postgresql/9.3/main/pg_hba.conf
sudo service postgresql start
sudo sudo -u postgres psql < init_c9.sql

# Set ENV variables
export SECRET_TOKEN=`rake secret`
export APPNAME=FitStalker
export ADMIN_EMAIL=heisler@epimp.com
export ADMIN_NAME=Hamish Eisler
#export ADMIN_PASSWORD=
export GMAIL_USERNAME=gpucctester@gmail.com
#export GMAIL_PASSWORD=
export ROLES='[admin, user, trainer, VIP]'

# Setup DB
rake db:migrate
rake db:seed
