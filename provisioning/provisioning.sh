#!/usr/bin/env bash

#
# This script installs the development environment.
#

# Require all variables to be set and exit on first error.
set -u
set -e

LOG='/vagrant/provisioning/provisioning.log'

POSTGRES_CONFIG='/etc/postgresql/9.3/main/pg_hba.conf'

RBENV_REPO='https://github.com/sstephenson/rbenv.git'
RUBY_BUILD_REPO='https://github.com/sstephenson/ruby-build.git'

RUBY_VERSION=$(cat /vagrant/.ruby-version)

# Clear the log
> ${LOG}

# A quiet unattended installation
export DEBIAN_FRONTEND=noninteractive

echo 'Now provisioning! Why not get a coffee?'
echo "Output and errors are logged into ${LOG}."

echo 'Configuring the system...'

# Set a proper locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment

echo 'Upgrading the system...'

apt-get -qy update &>> ${LOG}
apt-get -qy upgrade &>> ${LOG}

echo 'Installing utilities...'

apt-get -qy install git-core &>> ${LOG}

echo 'Installing Postgres...'

apt-get -qy install postgresql postgresql-contrib libpq-dev &>> ${LOG}

# Allow login from anywhere
sed -Ei 's/local\s+all\s+postgres\s+peer/local all postgres trust/' \
  ${POSTGRES_CONFIG}

service postgresql restart &>> ${LOG}

echo "Installing Ruby ${RUBY_VERSION}..."

# Common Ruby dependencies
apt-get -qy install autoconf bison build-essential libssl-dev libyaml-dev \
  libsqlite3-dev libreadline6-dev zlib1g-dev libncurses5-dev &>> ${LOG}

# This provisioning script is running as root.
# Using sudo to install rbenv as vagrant.

sudo -u vagrant -H bash -c "git clone ${RBENV_REPO} ~/.rbenv" &>> ${LOG}
sudo -u vagrant -H bash \
  -c "git clone ${RUBY_BUILD_REPO} ~/.rbenv/plugins/ruby-build" &>> ${LOG}

sudo -u vagrant -H bash \
  -c "echo 'export PATH=\"\$HOME/.rbenv/bin:\$PATH\"' >> ~/.bash_profile"
sudo -u vagrant -H bash \
  -c "echo 'eval \"\$(rbenv init -)\"' >> ~/.bash_profile"

sudo -u vagrant -H bash \
  -c "~/.rbenv/bin/rbenv install ${RUBY_VERSION}" &>> ${LOG}
sudo -u vagrant -H bash \
  -c "~/.rbenv/bin/rbenv global ${RUBY_VERSION}" &>> ${LOG}

echo 'Installing Bundler...'

sudo -u vagrant -H bash -c '~/.rbenv/shims/gem install bundler' &>> ${LOG}

echo 'Installing gems...'

sudo -u vagrant -H bash \
  -c '~/.rbenv/shims/bundle install --gemfile="/vagrant/Gemfile"' &>> ${LOG}

echo 'Setting up database...'

sudo -u postgres createdb development  &>> ${LOG}
sudo -u postgres createdb test  &>> ${LOG}

sudo -u vagrant -H bash \
  -c '~/.rbenv/shims/rake db:setup --rakefile="/vagrant/Rakefile"' &>> ${LOG}

echo 'Starting Rack...'

# Copy the Upstart job into place and refresh Upstart
cp /vagrant/provisioning/config/rack.conf /etc/init/rack.conf &>> ${LOG}
chmod +x /etc/init/rack.conf &>> ${LOG}
initctl reload-configuration &>> ${LOG}

service rack start &>> ${LOG}

echo 'Done!'
