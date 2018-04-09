# Java Spring MVC REST Bootstrap Application #

## Summary ##

This is an example project to help you get bootstrapped with a Java **Spring MVC** project aimed towards REST that also includes **Spring Boot**, and **Gradle**.

In addition to that, developer tools like **Docker** and **Docker-Compose** have been added to get you into the code right away and not worried about the environment you need to deploy to.

## Dependencies ##

* Git
* Java 8 JRE + JDK
* Gradle 4.4+
* Docker
* Docker-Compose
* Intellij IDEA (or another Java IDE or text editor)

## What you Get ##

### 10,000ft view ###

* Simple code that is easy to understand.
* You can begin to immediately code on top of this project to accelerate your own REST Java application.
* Containerized application that's already setup with Docker, Docker-Compose, and ready for Kubernetes, Jenkins/Bamboo, and other build or devops tools.

### Under the Microscope ###

* Spring MVC 4 with Spring Boot allows for convention over configuration. Code immediately and be productive.
* Custom annotation `@SecuredArea` included in order to easily protect your authorized-only REST routes in your Controllers.
* Custom `run.sh` script that will install gradle, build your application, and run in it with one or more simple commands.
* Stand up and tear down environments quickly with containerized-ready code.

## Getting Started ##

### Open your IDE ###

Open **Intellij IDEA** or your favorite IDE and import this project into the IDE as a **Gradle** project. Allow your IDE to download **Gradle** for you automatically and pull in the required sources specified in your `build.gradle`.

### Build with Gradle ###

When you're ready to build you can use **Gradle** to execute `clean` and `build` commands through your IDE or do it through the command-line using the `gradle` tool.

### Run your Application ###

After you've built your application, it is time to run it. Execute the `run.sh` script in project root.

#### NOTES ####

You may execute `./run.sh --build` in order to explicitly build or rebuild the project before running.

You may also execute `./run.sh --build-only` if you only want to build or rebuild the project but NOT run it.

### Testing ###

The project is now running and ready to be used with a Hello World message located at [http://localhost:8080/](http://localhost:8080/).

## References ##

The inspiration for this project is extended from [Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/).

Learn more about **Spring MVC** here:

[https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-requestmapping](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-requestmapping)
