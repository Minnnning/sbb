FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /workspace/app

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src

RUN ./gradlew build -x test
RUN mkdir build/dependency && (cd build/dependency; jar -xf ../libs/sbb-0.1.3.jar)

FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
ARG EXTRACTED=/build/extracted
COPY ${EXTRACTED}/dependencies/ ./
COPY ${EXTRACTED}/spring-boot-loader/ ./
COPY ${EXTRACTED}/snapshot-dependencies/ ./
COPY ${EXTRACTED}/application/ ./
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher"]