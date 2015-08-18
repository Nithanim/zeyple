# ZEYPLE: Zeyple Encrypts Your Precious Log Emails [![Build Status](https://travis-ci.org/infertux/zeyple.png?branch=master)](https://travis-ci.org/infertux/zeyple)

**Zeyple automatically encrypts outgoing emails with GPG:**

1. It catches emails from your Postfix queue
1. Then encrypts them if it's got the recipient's GPG public key
1. Finally it puts them back into the queue

<pre>
     unencrypted email   ||   encrypted email
sender --> Postfix --> Zeyple --> Postfix --> recipient(s)
</pre>

_Why should I care? If you are a sysadmin who receives emails from various monitoring tools like Logwatch, Monit, Fail2ban, Smartd, Cron, whatever - it goes without saying that those emails contain lots of information about your servers.
Information that may be intercepted by some malicious hacker sniffing SMTP traffic, your email provider, &lt;insert your (paranoid) reason here&gt;...
Why would you take that risk - encrypt them all!_

## Install & upgrade

See [INSTALL.md](INSTALL.md) & [UPGRADE.md](UPGRADE.md).

## Disable/enable Zeyple

Just comment/uncomment the line `content_filter = zeyple` in your `/etc/postfix/main.cf` then `postfix reload`.

## Uninstall

Manually remove the added lines in `/etc/postfix/{main,master}.cf` then

```bash
rm -rfv /etc/zeyple /usr/local/bin/zeyple.py /var/log/zeyple.log
userdel zeyple
postfix reload
```

## Key management

* List of keys: `sudo -u zeyple gpg --homedir /etc/zeyple/keys --list-key`
* Update imported keys: `sudo -u zeyple gpg --homedir /etc/zeyple/keys --keyserver hkp://keys.gnupg.net --refresh-keys`
* Import a new key: `sudo -u zeyple gpg --homedir /etc/zeyple/keys --keyserver hkp://keys.gnupg.net --search you@domain.tld`

## Dev install

You will need the following development dependencies.

* Packages:
  * Debian/Ubuntu: `apt-get install libgpgme11-dev`
  * Fedora: `yum install gpgme-devel python-devel python3-devel python-pep8`
* Python eggs: `pip install -r requirements.txt`

## Testing

`tox` will run [nosetests](https://github.com/nose-devs/nose) under every supported version of Python thanks to [tox](https://bitbucket.org/hpk42/tox).

To restrict the versions of Python tested by `tox`, you can use `tox -e py27,py34,pypy` for example.

## Integration with other MTAs

Although tested only with [Postfix](http://www.postfix.org/), Zeyple should integrate nicely with any MTA which provides a [filter](http://www.postfix.org/FILTER_README.html "Postfix After-Queue Content Filter")/hook mechanism. Please let me know if you experiment with this.

## Vagrant

A fully-setup test-environment is available to easily test your modifications.
[Vagrant](https://www.vagrantup.com/) and a compatible virtualization environment ([VirtualBox](https://www.virtualbox.org/) for example) are required.

To get started, open a shell in the base directory of this repositoy and type `vagrant up`.It will setup a linux box with everything preconfigured
(Thunderbird included) so you can start with sending emails right away after the installation has completed. However, it needs to download a lot
of things and the installation takes quite some time too so let it run for a bit.

If everything has finished, the only thing you need to do is edit the zeyple.py on your real system. Every change is automatically reflected in
theguest OS and used by postfix. If you need the output of the zeyple.log you can type `vagrant ssh` in the same shell you used to start the OS
and then `tail -f /var/log/zeyple.log` as you would on your real machine.

When you are done with testing you can type `vagrant halt` to shut everything down. If you want to delete the test environment you can use
`vagrant destroy` to delete the box.

If you get an error that sounds like
```Command died with status 127: "/usr/local/bin/zeyple.py". Command output: /usr/bin/env: python_: No such file or directory```
you need to make sure that the line-endings in the zeyple.py are LF and not CRLF.

## Kudos

Many thanks to [Harry Knitter](http://www.linux-magazine.com/Issues/2013/153/Email-Encryption-with-Zeyple) for his feedback to help make Zeyple bullet-proof.

## Support

Bitcoin donations to support Zeyple: [192TgFGjiRKCJtXAQAv1urnvQXGZV2wwBt](bitcoin:192TgFGjiRKCJtXAQAv1urnvQXGZV2wwBt?message=Zeyple) :)

## License

AGPLv3+

