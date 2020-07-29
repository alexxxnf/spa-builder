# SPA Builder
This repo contains Docker image that helps to build [SPA](https://en.wikipedia.org/wiki/Single-page_application).

It's based on [node.js](https://nodejs.org/) and has [npm](https://www.npmjs.com/), [yarn](https://yarnpkg.com/).

It also has [gzip](https://en.wikipedia.org/wiki/Gzip) and [brotli](https://github.com/google/brotli)
to produce pre-compressed static files ready to be served by [nginx](https://www.nginx.com/).

Alternative version of the image also has [node-gyp](https://www.npmjs.com/package/node-gyp)
and [Python](https://www.python.org/) to build binary packages.

## Usage
```
FROM alexxxnf/spa-builder as builder

COPY ./package.json ./package-lock.json ./yarn.lock /app/
RUN cd /app && yarn

COPY . /app
RUN cd /app \
    && yarn run build --prod \
    && /app/dist \
    && for i in `find | grep -E "\.css$|\.html$|\.js$|\.svg$|\.txt$|\.ttf$"`; do gzip -9kf "$i" && brotli -fZ "$i" ; done

FROM alexxxnf/nginx-spa

COPY --from=builder /app/dist /etc/nginx/html/
```
