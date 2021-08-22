FROM alpine:3.14 as builder


ARG YTDLM_COMMIT_SHA=53216246049ef839437a84a31461d7be3be2bf9d


RUN apk add --no-cache --update \
            git \
            npm \
 && npm install -g @angular/cli \
 && git clone https://github.com/Tzahi12345/YoutubeDL-Material.git /ytdlm \
 && cd /ytdlm \
 && git checkout ${YTDLM_COMMIT_SHA} \
 && mkdir /build \
 && cd /build \
 && cp /ytdlm/package.json /ytdlm/package-lock.json . \
 && npm install \
 && cp /ytdlm/angular.json /ytdlm/tsconfig.json . \
 && cp -r /ytdlm/src . \
 && ng build --source-map=false --prod


FROM padhihomelab/alpine-base:3.14.1_0.19.0_0.2


ENV NO_UPDATE_NOTIFIER=true


COPY --from=builder \
     /ytdlm/backend \
     /app
COPY --from=builder \
     /build/backend/public \
     /app/public

COPY user-entrypoint.d \
     /etc/docker-entrypoint.d/99-user
COPY start.sh \
     /usr/local/bin/start-ytdl


RUN chmod +x /etc/docker-entrypoint.d/99-user/*.sh \
             /usr/local/bin/start-ytdl \
 && apk add --no-cache --update \
            ffmpeg \
            npm \
            python3 \
 && apk add --no-cache --update \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            atomicparsley \
 && cd /app \
 && rm -rf appdata audio subscriptions users video \
 && npm install forever -g \
 && npm install


EXPOSE 17442
VOLUME [ "/audio", "/config", "/subs", "/users", "/video" ]


CMD [ "start-ytdl" ]


HEALTHCHECK --start-period=10s --interval=30s --timeout=5s --retries=3 \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://localhost:17442/"]
