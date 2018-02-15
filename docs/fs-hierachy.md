# Linux Hierachy

~~My Modified Best Practices~~

## $HOME/.local/{bin,lib,share,man,etc,var,opt}

- Duplicate the basic system hierarchy.  Aim to keep everything in here except if:
  - Program or configuration should be available to more than current user.

## /usr/local/bin -> /opt/local/bin

- new place to store additional (not come with os) binaries.

## /usr/local/

Since this is designed to be read-only by FHS but require RW access in its bin subfolder, we use /opt/local instead.  And now we can make /usr/local read-only if required.

https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s09.html
says /usr/local/ must have a certain set of dirs under it and nothing more.  So...

## /opt/local/
- will have bin, etc, include, lib, lib64, man, sbin, share, src.

## /opt/
- has `local` and all other dirs are program names.  then as a subfolder use program version `/opt/go/1.9/...`

- For example, someapp would be installed in /opt/someapp/1.5/, with one of its command being /opt/someapp/1.5/bin/foo, its configuration file would be in /etc/opt/someapp/foo.conf, and its log files in /var/opt/someapp/logs/foo.access.




http://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html

https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local
