FROM openjdk:8 AS builder

COPY . /opt/app
WORKDIR /opt/app

ENV GRADLE_VERSION 4.4

RUN cd /usr/lib \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip"

# Set env vars for gradle
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# BUILD WAR WITH GRADLE
RUN gradle wrapper --gradle-version ${GRADLE_VERSION} && ./gradlew build

###########

FROM debian:stable AS deploy

EXPOSE 80
EXPOSE 8000
EXPOSE 8080

ENV DOCKER true

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install software-properties-common default-jre default-jdk -y

WORKDIR /opt/app
RUN mkdir -p /opt/app/bin

# Copy app files to target container
COPY --from=builder /opt/app/build/libs/app.jar /opt/app/bin/app.jar
COPY --from=builder /opt/app/run.sh /opt/app/run.sh

# RUN CONTAINER
RUN chmod +x /opt/app/run.sh
CMD ["/opt/app/run.sh"]