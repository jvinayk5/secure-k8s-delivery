# syntax=docker/dockerfile:1
ARG BASE_IMAGE=node-base:latest

FROM node:22.11-alpine3.20 AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN mkdir -p node_modules && (npm ci --omit=dev 2>/dev/null || npm install --omit=dev)

# hadolint ignore=DL3006
FROM ${BASE_IMAGE}
WORKDIR /app
COPY --from=deps --chown=10001:10001 /app/node_modules ./node_modules
COPY --chown=10001:10001 package.json ./
COPY --chown=10001:10001 src ./src
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION} PORT=8080
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:8080/healthz || exit 1
CMD ["node", "src/index.js"]
