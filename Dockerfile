#
# Build stage
#
FROM maven:3.6.3-openjdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM tomcat:7.0-jdk8-openjdk-slim
COPY --from=build /home/app/target/gameoflife-0.0.1-SNAPSHOT.jar /usr/local/lib/gameoflife.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/gameoflife.jar"]