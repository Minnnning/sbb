FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=build/libs/sbb-0.1.3.jar
COPY run.sh .
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["./run.sh"]