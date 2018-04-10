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
* Azure, AWS, GCP, Heroku friendly code and paradigms.

### Under the Microscope ###

* Spring MVC 4 with Spring Boot allows for convention over configuration. Code immediately and be productive.
* Custom annotation `@SecuredArea` included in order to easily protect your authorized-only REST routes in your Controllers.
* Custom `run.sh` script that will install gradle, build your application, and run in it with one or more simple commands.
* Custom `Config` class that makes it easy to load application specific config data in a container-friendly way.
* Custom `Logger` class that makes it easy to output your console information in a container-friendly way.
* Custom Secrets/Environment Variable management that is compatible with Docker-Compose, Kubernetes, or just vanilla stand-alone application.
* Stand up and tear down environments quickly with containerized-ready code.

## Getting Started ##

### Open your IDE ###

Open **Intellij IDEA** or your favorite IDE and import this project into the IDE as a **Gradle** project. Allow your IDE to download **Gradle** for you automatically and pull in the required sources specified in your `build.gradle`.

### Managing Secrets ###

Abstract and ephemeral paradigms are all the rage right now. Allow your application to load custom configuration variables depending on what environment it is in (local, dev, staging, production, etc).

Duplicate `secrets.env.example` to `secrets.env` in your project root. Use this new config as a template to setup env vars in your application. Start adding new vars to `secrets.env` and `Config.java` once you're ready.

Compatible with infrastructure like AWS, GCP, and Heroku along with tools like Docker-Compose or Kubernetes.

### Build with Gradle ###

When you're ready to build you can use **Gradle** to execute `clean` and `build` commands through your IDE or do it through the command-line using the `gradle` tool.

### Run your Application ###

After you've built your application, it is time to run it. Execute the `run.sh` script in project root.

#### NOTES ####

Run the script as root/sudo on Mac and Linux and with Admin Privs on Windows machines. You will also need to run `chmod +x run.sh` to allow the script to execute on non-Windows systems.

Executing `run.sh` will run your project if the binary exists and only build when it doesn't exist.

You may execute `./run.sh --build` in order to explicitly build or rebuild the project before running.

You may also execute `./run.sh --build-only` if you only want to build or rebuild the project but NOT run it.

### Testing ###

The project is now running and ready to be used with a Hello World message located at [http://localhost:8080/](http://localhost:8080/).

## References ##

The inspiration for this project is extended from [Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/).

Learn more about **Spring MVC** here:

[https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-requestmapping](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-requestmapping)
