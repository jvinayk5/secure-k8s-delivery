# syntax=docker/dockerfile:1
ARG BASE_IMAGE=java-base:latest

FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src ./src
RUN mvn -B -q -DskipTests package

# hadolint ignore=DL3006
FROM ${BASE_IMAGE}
COPY --from=build --chown=10001:10001 /src/target/spring-service-*.jar /app/app.jar
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]
