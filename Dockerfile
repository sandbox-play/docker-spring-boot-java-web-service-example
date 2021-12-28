FROM maven:3.3-jdk-8 as builder
COPY . /usr/src/mymaven/
WORKDIR /usr/src/mymaven/
RUN mvn clean package

# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jdk-alpine
MAINTAINER "opstree <deepak.yadav@opstree.com>"
# set shell to bash
# source: https://stackoverflow.com/a/40944512/3128926
RUN apk update && apk add bash

# Set the working directory to /app
WORKDIR /app

# Copy the fat jar into the container at /app
COPY --from=builder /usr/src/mymaven/target/docker-java-app-example.jar /app

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run jar file when the container launches
CMD ["java", "-jar", "docker-java-app-example.jar"]
