#!/bin/sh

set -e

cd /app

ln -s /audio  audio
ln -s /config appdata
ln -s /subs   subscriptions
ln -s /users  users
ln -s /video  video

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
    chown -R $DOCKER_USER:$DOCKER_GROUP /app /audio /config /subs /users /video
fi
