###################
# Build Container #
###################

FROM openjdk:8 AS builder

WORKDIR /opt/app
COPY . .

RUN chmod +x run.sh
RUN run.sh --build-only

####################
# Deploy Container #
####################

FROM debian:stable AS deploy

EXPOSE 80
EXPOSE 8000
EXPOSE 8080

ENV DOCKER true

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install software-properties-common default-jre default-jdk -y

RUN mkdir -p /opt/app
WORKDIR /opt/app

# Copy app files to target container
COPY --from=builder /opt/app/build/libs/app.jar ./app.jar
COPY --from=builder /opt/app/run.sh ./run.sh

# RUN CONTAINER
RUN chmod +x run.sh
CMD ["run.sh"]