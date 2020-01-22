FROM openjdk:13 AS build

RUN mkdir -p /workspace
WORKDIR /workspace
COPY . .
RUN yum install -y wget unzip
RUN wget -O /tmp/gradle.zip https://services.gradle.org/distributions/gradle-6.1-bin.zip && \
    unzip /tmp/gradle.zip -d /opt && \
    mv /opt/gradle-6.1 /opt/gradle

RUN /opt/gradle/bin/gradle build

# --

FROM openjdk:13 AS deploy

RUN mkdir -p /opt/app
COPY --from=build /workspace/build/libs/myapp-FINAL.jar /opt/app/myapp.jar

ENTRYPOINT ["java", "-jar", "/opt/app/myapp.jar"]
