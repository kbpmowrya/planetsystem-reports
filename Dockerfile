#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
RUN mkdir -p /root/.m2 \
    && mkdir /root/.m2/repository
COPY src /home/app/src
COPY pom.xml /home/app
RUN --mount=type=cache,target=/root/.m2 mvn -f /home/app/pom.xml clean package
#-DskipTests=true
COPY /src/main/resources/employees.jrxml /home/app/target/
EXPOSE 8080
ENTRYPOINT ["java","-jar","/home/app/target/planetsystem-reports.jar"]
