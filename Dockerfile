FROM ghcr.io/graalvm/native-image-community:25 AS build

WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

RUN chmod +x gradlew

COPY src src

ARG PORT
ARG SECURITY_USER_NAME
ARG SECURITY_USER_PASSWORD

ENV PORT=${PORT}
ENV SECURITY_USER_NAME=${SECURITY_USER_NAME}
ENV SECURITY_USER_PASSWORD=${SECURITY_USER_PASSWORD}

RUN java -version
RUN native-image --version

RUN ./gradlew nativeCompile --no-daemon -x test


FROM debian:bookworm-slim

WORKDIR /app

COPY --from=build /app/build/native/nativeCompile/maintenance-service-registery .

EXPOSE 8761

ENTRYPOINT ["./maintenance-service-registery"]