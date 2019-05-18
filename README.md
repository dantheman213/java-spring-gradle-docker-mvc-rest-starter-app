# Java Spring MVC REST Application

This project is designed to get you bootstrapped immediately by providing a minimum set of code you'll need to begin developing a modern Java 12 containerized REST application.

## What you get

* Java 12
* Spring MVC + Boot
* Gradle 5.4.x
* Docker
* Docker Compose

## Prerequisites

### Minimum Software Required To Deploy

* Docker
* Docker-Compose

### For Development

* Java 12 JDK
* IDE (Intellij IDEA, NetBeans, Eclipse, etc)

## Getting Started

### Import Project into IDE

Open your IDE, I recommend **Intellij IDEA** but you can use your favorite IDE, and import this project as a **Gradle** project. Allow your IDE to download **Gradle** for you automatically (if you'd like to run locally) and pull in the required sources specified in your `build.gradle`.

### Managing Secrets

Does your application have state data you need to inject at runtime? Add environment variables to a `secrets.env` file to be loaded at container start.

Compatible with clouds like AWS, GCP, and Heroku in addition to services like Compose, Swarm, ECS, or Kubernetes.

### Build Docker Image & Run Application

    docker-compose up --build -d

#### Hello World

The application is now running. Please visit [http://localhost:8080/](http://localhost:8080/).

### Debug Application Within Docker Container

#### Download Tomcat 9

https://tomcat.apache.org/download-90.cgi

#### Configure your IDE to listen to debugger

In this example I will be using Intellij IDEA. You can add/edit configuration at the top-right. Select Tomcat Server > Remote.

You will want to bind the application to the Tomcat 9 binary you downloaded above. You will also want the debug profile
in start-up/connection section to be set to port 8000.

#### Start the application in debug mode

    docker-compose -f docker-compose.yml -f docker-compose.debug.yml up --build

#### Listen from your IDE

Start the debug profile here and it should listen to your breakpoints after the docker image has been built and is running.

## References

[Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/)
