FROM node:8-alpine

LABEL maintainer="Aleksey Maydokin <amaydokin@gmail.com>"

ENV BROTLI_VERSION 1.0.7

RUN apk add --no-cache --virtual .build-deps \
        bash \
        gcc \
        libc-dev \
        make \
        linux-headers \
        cmake \
        curl \
    && mkdir -p /usr/src \
    && curl -LSs https://github.com/google/brotli/archive/v$BROTLI_VERSION.tar.gz | tar xzf - -C /usr/src \
    && cd /usr/src/brotli-$BROTLI_VERSION \
    && ./configure-cmake --disable-debug && make -j$(getconf _NPROCESSORS_ONLN) && make install \
    && yarn global add node-gyp \
    && apk del .build-deps && yarn cache clean && rm -rf /usr/src
