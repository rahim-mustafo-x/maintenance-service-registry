FROM ghcr.io/graalvm/native-image-community:25 AS build

WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

RUN chmod +x gradlew

COPY src src

RUN java -version
RUN native-image --version

RUN ./gradlew clean nativeCompile --no-daemon -x test


FROM debian:bookworm-slim

WORKDIR /app

COPY --from=build \
    /app/build/native/nativeCompile/maintenance-service-registery \
    ./maintenance-service-registery

RUN chmod +x ./maintenance-service-registery

EXPOSE 8761

ENTRYPOINT ["./maintenance-service-registery"]