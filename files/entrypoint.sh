#!/bin/sh
/bin/sh

# defaults
[[ ! -e /config/beets.sh ]] && cp /defaults/beets.sh /config/beets.sh
[[ ! -e /config/config.yaml ]] && cp /defaults/config.yaml /config/config.yaml

# ownership
chown -R beets:beets /config

# run
if [ $# -eq 0 ]; then
  su - beets -c "BEETSDIR='$BEETSDIR' beet web"
  while sleep 3600; do :; done
else
  beet $@
fi
