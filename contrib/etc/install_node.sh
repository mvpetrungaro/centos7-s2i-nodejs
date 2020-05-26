#!/bin/bash

set -ex

#yum install -y git

# Ensure git uses https instead of ssh for NPM install
# See: https://github.com/npm/npm/issues/5257
#echo -e "Setting git config rules"
#git config --system url."https://github.com".insteadOf git@github.com:
#git config --global url."https://github.com".insteadOf ssh://git@github.com
#git config --system url."https://".insteadOf git://
#git config --system url."https://".insteadOf ssh://
#git config --list

yum install -y nodejs
which node
which nodejs

#rpm -V $INSTALL_PKGS
yum clean all -y
ldconfig

# Make sure npx is available
if [ ! -h /usr/bin/npx ] ; then
  ls -l /usr/lib/node_modules/npm/bin/npx-cli.js
  ln -s /usr/lib/node_modules/npm/bin/npx-cli.js /usr/bin/npx
fi

echo "---> Setting directory write permissions"
fix-permissions /opt/app-root

# Delete NPM things that we don't really need (like tests) from node_modules
#find /usr/local/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf

# Clean up the stuff we downloaded
yum clean all -y
