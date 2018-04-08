#!/bin/bash
# This script is for docker to run inside VM

if [ -n "$DOCKER" ]; then
    # in docker, just run the application in the image
    eval "java -jar /opt/app/bin/app.jar"
else
    # not in docker
    homeDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get the relative path to the script's dir
    execFile="${homeDir}/build/libs/app.jar" # final path to the application

    # Check to see if developer has built the project yet.. fail it not
    if [ ! -f ${execFile} ]; then
        echo "Please download Gradle and build the project according to the README before running this script."
        exit 1
    fi

    eval "java -jar ${execFile}"
fi