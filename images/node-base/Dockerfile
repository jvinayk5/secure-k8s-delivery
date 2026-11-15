# Platform base image for Node.js services.
# Pinned LTS, non-root user, no package manager cache, tini as PID 1.
FROM node:22.11-alpine3.20

RUN apk add --no-cache tini \
 && addgroup -S app -g 10001 \
 && adduser -S app -u 10001 -G app

ENV NODE_ENV=production \
    NPM_CONFIG_UPDATE_NOTIFIER=false
WORKDIR /app
USER 10001
ENTRYPOINT ["/sbin/tini", "--"]
