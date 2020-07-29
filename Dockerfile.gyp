FROM node:12-alpine

LABEL maintainer="Aleksey Maydokin <amaydokin@gmail.com>"

COPY --from=alexxxnf/brotli:1.0.7 /bin/brotli /usr/local/bin/brotli

RUN apk add --no-cache \
        g++ \
        gcc \
        make \
        python3 \
    && yarn global add node-gyp \
    && yarn cache clean
