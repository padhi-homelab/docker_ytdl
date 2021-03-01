FROM alpine:3.13 as app-builder


ARG YTDLM_COMMIT_SHA=f32b3947150f577e214d05bd9d67026612b22978


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


FROM padhihomelab/alpine-base:3.13_0.19.0_0.2


COPY --from=app-builder \
     /ytdlm/backend \
     /app
COPY --from=app-builder \
     /build/backend/public \
     /app/public


RUN apk add --no-cache --update \
            ffmpeg \
            npm \
 && apk add --no-cache --update \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            atomicparsley \
 && cd /app \
 && npm install


EXPOSE 17442
VOLUME [ "/audio", "/config", "/subs", "/users", "/video" ]


CMD [ "node", "app.js" ]


HEALTHCHECK --start-period=10s --interval=30s --timeout=5s --retries=3 \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://localhost:17442/"]
