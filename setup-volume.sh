#!/bin/bash -e

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
    chown -R $DOCKER_USER:$DOCKER_GROUP /app /audio /config /subs /users /video
fi

cd /app
rm -rf appdata audio subscriptions users video

ln -s /audio
ln -s /config appdata
ln -s /subs subscriptions
ln -s /users
ln -s /video
