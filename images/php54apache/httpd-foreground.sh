#!/bin/sh

cd /etc/apache2/
exec apachectl -d . -f ./apache2.conf -e info -DFOREGROUND
