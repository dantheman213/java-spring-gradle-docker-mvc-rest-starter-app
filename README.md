# Java Spring MVC REST Application #

This project is designed to get you bootstrapped immediately by providing a minimum set of code you'll need to begin developing a modern Java 12 containerized REST application.

## Dependencies ##

* Java 12 JRE + JDK
* Gradle 5.4.1+
* Docker
* Docker-Compose

## Getting Started ##

### Open your IDE ###

Open **Intellij IDEA** or your favorite IDE and import this project into the IDE as a **Gradle** project. Allow your IDE to download **Gradle** for you automatically and pull in the required sources specified in your `build.gradle`.

### Managing Secrets ###

Have state data you need to inject? Add your environment variables to a `secrets.env` file to be loaded at container start.

Compatible with infrastructure like AWS, GCP, and Heroku along with tools like Docker-Compose or Kubernetes.

### Build and Run your Application ###

    docker-compose up --build

### Hello World ###

The application is now running. Please visit [http://localhost:8080/](http://localhost:8080/).

## References ##

The inspiration for this project is extended from [Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/).

Learn more about **Spring MVC** here:

[https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-requestmapping](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-requestmapping)
