#!/bin/sh

echo "Configuring dovecot"

if [ ! -e /etc/dovecot/dovecot.conf.orig ]; then
    cp /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf.orig
fi


cat /vagrant_provision/dovecot.conf > /etc/dovecot/dovecot.conf



mkdir /etc/dovecot/cert
openssl genrsa -out /etc/dovecot/cert/private.pem 1024

openssl req \
    -new \
	-x509 \
    -newkey rsa:4096 \
    -days 3650 \
    -key /etc/dovecot/cert/private.pem \
    -out /etc/dovecot/cert/public.pem \
	-subj "/C=/ST=/L=/O=/CN=localhost"


# Create "testuser"

# First check to see if the user already exits
if getent passwd testuser > /dev/null; then
    echo 'testuser already exists'
else
    echo 'Creating User "testuser" with password "zeyple"'
    sudo useradd testuser -m -s /bin/bash

    # Use chpasswd since we can pipe in a new password
    echo "testuser:zeyple"|sudo chpasswd
    echo 'User created'
fi


sudo service dovecot restart