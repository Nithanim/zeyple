#!/bin/sh

echo "Setting up thunderbird"

apt-get -qqy install thunderbird

if [ ! -e /root/.thunderbird/ ]; then
	cp -r /vagrant_provision/.thunderbird/ /root/
fi
chown -R testuser /vagrant_provision/.thunderbird/