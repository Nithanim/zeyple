#/bin/sh

apt-get install gnupg python-gpgme sudo


echo "Configuring zeyple"
if getent passwd zeyple > /dev/null; then
	echo 'User "zeyple" already exists'
else
	echo 'Creating User "testuser"'
	adduser --system --no-create-home --disabled-login zeyple
	echo 'User created'
fi

if [ ! -e /usr/local/bin/zeyple.py ]; then
    ln -s /vagrant_data/zeyple.py /usr/local/bin/zeyple.py 
fi

if [ ! -e /etc/zeyple.conf ]; then
    ln -s /vagrant_data/zeyple.conf.example /etc/zeyple.conf
fi

chmod 744 /usr/local/bin/zeyple.py && chown zeyple /usr/local/bin/zeyple.py
touch /var/log/zeyple.log && chown zeyple /var/log/zeyple.log