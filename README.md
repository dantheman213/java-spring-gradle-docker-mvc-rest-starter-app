# Modern Java "Hello World" REST Starter Application

This project is designed to get you bootstrapped immediately by providing a minimum set of code you'll need to begin developing a modern Java 12 containerized REST application.

## What you get

* Java 12
* Spring MVC
* Spring Boot
  - Embedded Tomcat 9 web server
* Gradle 5.4.x
* Docker
* Compose

## Prerequisites

### Minimum Software Required To Deploy Application

You **only** need these items to run the application on any supported device:

* [Docker](https://www.docker.com)
* [Compose](https://docs.docker.com/compose)

### For Development

If you plan on writing code please also install these items as well:

* [Java 12 JDK](https://www.oracle.com/technetwork/java/javase/downloads/jdk12-downloads-5295953.html)
* IDE ([Intellij IDEA](https://www.jetbrains.com/idea), [NetBeans](https://netbeans.org), [Eclipse](https://www.eclipse.org/ide), etc)

#### Debugging

If you are writing code and will need to debug the application, please download this item:

* [Tomcat 9](https://tomcat.apache.org/download-90.cgi)

## Getting Started

### Build Docker Image & Run Application

    docker-compose up --build -d

#### Hello World

The application is now running. Please visit [http://localhost:8080/](http://localhost:8080/).

## Development

Ready to start writing code on top of this project? Please follow these steps:

### Import Project into IDE

Open your IDE, I recommend **Intellij IDEA** but you can use your favorite IDE, and import this project as a **Gradle** project. Allow your IDE to download **Gradle** for you automatically (if you'd like to run locally) and pull in the required sources specified in your `build.gradle`.

### Write Code

If your IDE's Gradle import was successful or you're using a text editor, you may begin writing code.

### Run New Code

Instructions on how to run the application are mentioned earlier. Save your work and follow the same steps above.

### Debug Application Within Docker Container

Need to debug your experimental application code for this project? Here is how I recommend getting started:

#### Download & Install Tomcat 9

The download link is provided above. Decompress the archive and place the Tomcat 9 directory somewhere easily accessible, like your user's home directory.

#### Configure your IDE to listen to debugger

In this example I will be using Intellij IDEA. You can add/edit configuration by clicking the run profile drop-down and click "Edit Configurations" at the top-right of the IDE. In this dropdown, select Tomcat Server > Remote.

You will want to bind the application to the Tomcat 9 binary you downloaded above. You will also want the debug profile
in start-up/connection section to be set to port 8000.

#### Start the application in debug mode

    docker-compose -f docker-compose.yml -f docker-compose.debug.yml up --build

#### Listen from your IDE

Start the debug profile here and it should listen to your breakpoints after the docker image has been built and is running.

### Managing Secrets

Does your application have state data you need to inject at runtime? Create a file in your project root called `secrets.env`. Then uncomment the lines in `docker-compose.yml` mentioning `secrets.env`. Compose will read this file to be loaded at container start. You can add environment variables to be injected into your container at runtime. Check out `secrets.env.example` in order to see some practical examples.

Compatible with clouds like AWS, GCP, and Heroku in addition to services like Compose, Swarm, ECS, or Kubernetes.

## FAQs

### Why isn't feature X inside of this project template?

It was tempting to add things such as reading environment variables to configuration, logging, error handling, protected routes, JSON serialization, unit testing, and more. However, the goal of this project is to be as unopinionated as possible while at the same time allowing a developer to immediately be productive in writing a REST web application with a modern Java stack.

This code allows you to build any of those custom requirements on top of pre-existing and well-known technologies.

I may add new things if I can find a modular way for a new developer to quickly decouple anything he or she does not want. Community feedback welcome.

### How should I deploy this application?

That depends. This application is ready to be shipped in your favorite orchestration technology that supports Docker. It can also be run as a single instance through Docker/Compose. Your deployment strategy depends on use case, scalability, availability, and other requirements that you and your team have for your project.

### How should I implement HTTPS / SSL?

#### Load balancer

If you're in a production environment and need your application to scale, I would look at **AWS Application Load Balancer**, **GCP Cloud Load Balancing**, or **Azure Load Balancer**. Most load balancers fully support HTTPS/SSL and will send requests to your instance in your cloud's internal network via HTTP which reduces load at your application and still covers for most security use-cases.

#### Web server reverse proxy

If you're running in a non-scalable environment, a single instance in production, or in a staging/development/qa/misc environment I would recommend looking at a reverse proxy using **nginx** or **Apache**. Either of these web servers are great choices and they can provide HTTPS/SSL and proxy all the requests to your application via HTTP internally.

#### Why not run SSL natively through Java / Tomcat?

1. In a scalable environment you typically want to reduce any load at the application layer. In primarily security focused applications, requirements may be different.

2. Configuring Java for SSL can be a pain. In my personal experience I have found it much easier to configure a load balancer or web server to serve the latest SSL/TLS ciphers and other security settings than to allow my Java/Tomcat application to do it.

3. In general, SSL is more related to infrastructure than application level so there is a developer benefit of separation of concerns here.

### What is a secret?

Modern enterprise applications are typically written to be state independent on the code level. In the infrastructure you can then inject a list of secrets. A secret is typically an environment variable for values such as timeouts, connection credentials, API keys, and other values that you'd want to customize between production/staging/developer/qa/local environments.

### Why use `secrets.env` instead of `application.properties`?

I wouldn't recommend `application.properties` because it is not a portable solution that you can use across multiple languages and is not supported by typical Docker-based orchestration software. Environment variable injection is however very common and supported by typical orchestration software like Kubernetes, ECS, Swarm, and Compose.

## References

[Spring Boot Getting Started](https://spring.io/guides/gs/spring-boot/)
