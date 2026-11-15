# Platform base image for Spring Boot services.
# JRE only (no JDK) on current Alpine, OS packages patched at build time,
# non-root user, container-aware JVM flags.
FROM eclipse-temurin:21-jre-alpine

RUN apk upgrade --no-cache \
 && apk add --no-cache tini \
 && addgroup -S app -g 10001 \
 && adduser -S app -u 10001 -G app

ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75 -XX:+ExitOnOutOfMemoryError"
WORKDIR /app
USER 10001
ENTRYPOINT ["/sbin/tini", "--"]
