#!/bin/sh

# defaults
[[ ! -e /config/beets.sh ]] && cp /defaults/beets.sh /config/beets.sh
[[ ! -e /config/config.yaml ]] && cp /defaults/config.yaml /config/config.yaml

# ownership
chown -R beets:beets /config

# run
run_beet() {
  grep "^plugins:.*web" /config/config.yaml && \
    su - beets -c "BEETSDIR='$BEETSDIR' beet $1 &"
}

run_beet web
run_beet bpd
sleep 2147483647d
