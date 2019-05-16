# Java Spring MVC REST Application #

This project is designed to get you bootstrapped immediately by providing a minimum set of code you'll need to begin developing a modern Java 12 containerized REST application.

## What you get ##

* Java 12
* Spring MVC + Boot
* Gradle 5.4.x
* Docker
* Docker Compose

## Prerequisites ##

### Minimum ###

* Docker
* Docker-Compose

### Nice to Haves ###

* Java 12 JDK
* IDE (Intellij, NetBeans, Eclipse, etc)

## Getting Started ##

### Import Project into IDE ###

Open your IDE, I recommend **Intellij IDEA** but you can use your favorite IDE, and import this project as a **Gradle** project. Allow your IDE to download **Gradle** for you automatically (if you'd like to run locally) and pull in the required sources specified in your `build.gradle`.

### Managing Secrets ###

Does your application have state data you need to inject at runtime? Add environment variables to a `secrets.env` file to be loaded at container start.

Compatible with clouds like AWS, GCP, and Heroku in addition to services like Compose, Swarm, ECS, or Kubernetes.

### Build and Run your Application ###

    docker-compose up --build

### Hello World ###

The application is now running. Please visit [http://localhost:8080/](http://localhost:8080/).

## References ##

[Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/)
