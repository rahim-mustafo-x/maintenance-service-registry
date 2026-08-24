FROM eclipse-temurin:25-jdk AS build

WORKDIR /app

ARG PORT
ARG SECURITY_USER_NAME
ARG SECURITY_USER_PASSWORD

ENV PORT=${PORT}
ENV SECURITY_USER_NAME=${SECURITY_USER_NAME}
ENV SECURITY_USER_PASSWORD=${SECURITY_USER_PASSWORD}

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

RUN chmod +x gradlew

COPY src src

RUN java -version

RUN ./gradlew clean bootJar --no-daemon -x test


FROM eclipse-temurin:25-jre

WORKDIR /app

COPY --from=build \
    /app/build/libs/*.jar \
    ./maintenance-service-registry.jar

RUN chmod +x ./maintenance-service-registry.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "./maintenance-service-registry.jar"]