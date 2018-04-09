#!/bin/bash

SHOULD_REBUILD_PROJECT="false"

# If running Docker do one thing if running in local dev do another
if [ -n "$DOCKER" ]; then
    # in docker, just run the application in the image
    APP_FILE_PATH="/opt/app/bin/app.jar"
    eval "java -jar ${APP_FILE_PATH}"
else
    # not in docker, in local env

    if [ $# -eq 1 ]; then
      if [ $1 = "--build" ]; then
        SHOULD_REBUILD_PROJECT="true"
        echo "Will rebuild project if it already exists..."
      fi
    else
      echo "Too many arguments!"
      exit 1
    fi

    HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get the relative path to the script's dir
    APP_FILE_PATH="${HOME_DIR}/build/libs/app.jar" # final path to the application
    GRADLE_VERSION=4.4
    GRADLE_HOME="/opt/gradle"
    GRADLE_BIN_PATH="${GRADLE_HOME}/bin/"
    GRADLE_NAME="gradle-${GRADLE_VERSION}"
    TMP_PATH="/tmp"

    # Check to see if developer has built the project or if we need to build it fresh
    if [ ! -f ${APP_FILE_PATH} ] || [ $SHOULD_REBUILD_PROJECT = "true" ]; then

      # Checking if gradle exists.. if not install it
      if [ ! -d "${GRADLE_HOME}" ]; then
        curl -fl https://downloads.gradle.org/distributions/${GRADLE_NAME}-bin.zip -o ${TMP_PATH}/gradle-bin.zip
        cd ${TMP_PATH}
        unzip ${TMP_PATH}/gradle-bin.zip

        mkdir -p ${GRADLE_HOME}
        cp -Rav ${TMP_PATH}/${GRADLE_NAME}/. ${GRADLE_HOME}/.

        cd ~
        echo "export PATH=\$PATH:${GRADLE_BIN_PATH}" >> ~/.bash_profile
        source ~/.bash_profile

        rm -rf ${TMP_PATH}/gradle* > /dev/null 2&1
      fi

      # Run gradle to clean and build project
      cd ${HOME_DIR}
      gradle clean build
    fi

    # Run the application
    eval "java -jar ${APP_FILE_PATH}"
fi
