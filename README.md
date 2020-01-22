# Java REST starter app

This project is designed to get you bootstrapped immediately by providing a minimum set of code you'll need to begin developing a modern Java REST app that is ready to run natively or in a container.

## Download and run

    docker-compose up --build -d

The app is now running at [http://localhost:8080/](http://localhost:8080/).

## Features

* Java 13
* Spring MVC
* Spring Boot
  - Embedded Tomcat 9 web server
* Gradle 6.1
* Docker
* Compose

## Requirements

To run the code quickly you'll just need:

* [Docker](https://www.docker.com)
* [Compose](https://docs.docker.com/compose)

If you plan on writing code:

* [Java 13 JDK](https://www.oracle.com/technetwork/java/javase/downloads/jdk12-downloads-5295953.html)
* [Tomcat 9](https://tomcat.apache.org/download-90.cgi)

## Development

#### Debug app within Docker container

&#8291;1. Download & Install Tomcat 9

The download link is provided above. Decompress the archive and place the Tomcat 9 directory somewhere easily accessible, like your user's home directory.

&#8291;2. Configure your IDE to listen to debugger

In this example I will be using Intellij IDEA. You can add/edit configuration by clicking the run profile drop-down and click "Edit Configurations" at the top-right of the IDE. In this dropdown, select Tomcat Server > Remote.

You will want to bind the app to the Tomcat 9 binary you downloaded above. You will also want the debug profile
in start-up/connection section to be set to port 8000.

&#8291;3.  Start the app in debug mode

    docker-compose -f docker-compose.yml -f docker-compose.debug.yml up --build

&#8291;4. Listen from your IDE

Start the debug profile here and it should listen to your breakpoints after the docker image has been built and is running.

## FAQs

### Why isn't feature X inside of this project template?

The goal of this project is to provide a streamlined initial starting point for a developer to immediately be productive in writing modern Java REST web app.

### How should I deploy this app?

This app is ready to run natively or be shipped in your favorite orchestration technology that supports Docker.

### How should I implement HTTPS / SSL?

#### Load balancer

If you're in a production environment and need your app to scale, I would look at **AWS app Load Balancer**, **GCP Cloud Load Balancing**, or **Azure Load Balancer**. Most load balancers fully support HTTPS/SSL and will send requests to your instance in your cloud's internal network via HTTP which reduces load at your app and still covers for most security use-cases.

#### Web server reverse proxy

If you're running in a non-scalable environment, a single instance in production, or in a staging/development/qa/misc environment I would recommend looking at a reverse proxy using **nginx** or **Apache**. Either of these web servers are great choices and they can provide HTTPS/SSL and proxy all the requests to your app via HTTP internally.

#### Why not run SSL natively through Java / Tomcat?

1. In a scalable environment you typically want to reduce any load at the app layer. In primarily security focused apps, requirements may be different.

2. Configuring Java for SSL can be a pain. In my personal experience I have found it much easier to configure a load balancer or web server to serve the latest SSL/TLS ciphers and other security settings than to allow my Java/Tomcat app to do it.

3. In general, SSL is more related to infrastructure than app level so there is a developer benefit of separation of concerns here.

## Contribute

Community feedback is welcome. Please feel free to submit an issue or a pull request.

## References

[Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/)
