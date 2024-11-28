FROM openjdk:17-jdk
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY ./*.jar ./app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
