# Platform base image for Node.js services.
# Supported Node LTS on current Alpine, OS packages patched at build time,
# non-root user, tini as PID 1. npm and yarn are removed: the runtime image
# only needs `node`, and their bundled dependencies are a common source of CVEs.
FROM node:22-alpine

RUN apk upgrade --no-cache \
 && apk add --no-cache tini \
 && addgroup -S app -g 10001 \
 && adduser -S app -u 10001 -G app \
 && rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx \
           /opt/yarn-* /usr/local/bin/yarn /usr/local/bin/yarnpkg

ENV NODE_ENV=production
WORKDIR /app
USER 10001
ENTRYPOINT ["/sbin/tini", "--"]
