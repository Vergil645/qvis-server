#!/bin/sh


cd /srv/qvisserver/out
node index.js "$@" # this will start the actual web server

tail -f /dev/null # keep container around even after possible crash, so we can look at logs later
