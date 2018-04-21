#!/bin/bash
## This script will run the paired java application in dev or in production, in Docker env or in native env. ##

##############################
# CLI Switches/Args Selected #
##############################

SHOULD_REBUILD_PROJECT="false"
REBUILD_ONLY="false"

###############
# Global Vars #
###############

ARGS=( "$@" )
ARG_COUNT=$#
USER_HOME_DIR="NULL"
HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get the relative path to the script's dir
APP_FILE_PATH="${HOME_DIR}/build/libs/app.jar" # final path to the application
GRADLE_VERSION=4.4
GRADLE_HOME=""
GRADLE_BIN_PATH=""
GRADLE_NAME="gradle-${GRADLE_VERSION}"
TMP_PATH="/tmp"

#############################
# App Code -- DO NOT MODIFY #
#############################

function generateRandomString {
    MD5_BIN="md5sum" # default for windows git bash and linux

    COMMAND_OUTPUT=$(command -v md5sum)
    if [ ${#COMMAND_OUTPUT} -lt 1 ]; then
        MD5_BIN="md5" # OSX
    fi

    echo $(date | ${MD5_BIN} | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')
}

function checkAndInstallGradle {
    # Checking if gradle exists.. if not install it
    cd ~
    USER_HOME_DIR="$(pwd)"
    GRADLE_HOME="${USER_HOME_DIR}/gradle"
    GRADLE_BIN_PATH="${GRADLE_HOME}/bin/"

    if [ ! -d "${GRADLE_HOME}" ]; then
        TMP_ARCHIVE_PATH="${TMP_PATH}/$(generateRandomString)"
        mkdir -p ${TMP_ARCHIVE_PATH}

        cd ${TMP_ARCHIVE_PATH}
        curl -fl https://downloads.gradle.org/distributions/${GRADLE_NAME}-bin.zip -o ${TMP_ARCHIVE_PATH}/gradle-bin.zip
        unzip ${TMP_ARCHIVE_PATH}/gradle-bin.zip

        mkdir -p ${GRADLE_HOME}
        cp -Rav ${TMP_ARCHIVE_PATH}/${GRADLE_NAME}/. ${GRADLE_HOME}/.

        cd ~
        echo "export PATH=\$PATH:${GRADLE_BIN_PATH}" >> ${USER_HOME_DIR}/.bash_profile
        sleep 1
        source ${USER_HOME_DIR}/.bash_profile
    fi
}

function injectSecrets {
    # Inject secrets.env into env and run the application

    if [ -f "${HOME_DIR}/secrets.env" ]; then

        while IFS='' read -r line || [[ -n "$line" ]]; do
            splitLine=(${line//=/ })
            echo "Loading env var ${splitLine[0]}..."
            eval "export ${line}"
        done < "${HOME_DIR}/secrets.env"

    fi
}

function executeApp {
  eval "java -jar ${APP_FILE_PATH}"
}

function main {
    # If running Docker do one thing if running in local dev do another
    if [ -n "$DOCKER_COMPOSE" ]; then
        # in docker-compose, local dev and testing.
        # here the image is mounted at /opt/bin/app.jar instead
        APP_FILE_PATH="/opt/app/bin/app.jar"
        executeApp
    elif [ -n "$DOCKER" ]; then
        # in docker, just run the application in the image
        APP_FILE_PATH="/opt/app/app.jar"
        executeApp

    else
        # not in docker, in local env

        if [ ${ARG_COUNT} -eq 1 ]; then
            if [ ${ARGS[0]} = "--build" ] || [ ${ARGS[0]} = "--rebuild" ]; then
                SHOULD_REBUILD_PROJECT="true"
                echo "Will rebuild project if it already exists..."
            elif [ ${ARGS[0]} = "--build-only" ]; then
                REBUILD_ONLY="true"
                SHOULD_REBUILD_PROJECT="true"
            else
                echo "Invalid argument(s)!"
                exit 1
            fi
        elif [ ${ARG_COUNT} -gt 1 ]; then
            echo "Too many arguments!"
            exit 1
        fi

        # Check to see if developer has built the project or if we need to build it fresh
        if [ -f "${HOME_DIR}/app.jar" ]; then
            APP_FILE_PATH="${HOME_DIR}/app.jar"

        elif [ ! -f ${APP_FILE_PATH} ] || [ $SHOULD_REBUILD_PROJECT = "true" ]; then
            # Build folder doesn't exist or rebuild flag is set to true...

            checkAndInstallGradle

            # Run gradle to clean and build project
            cd ${HOME_DIR}
            gradle clean build
        fi

        if [ $REBUILD_ONLY = "false" ]; then
            # Add env vars to application scope
            injectSecrets

            # Run the application!
            executeApp
        fi
    fi
}


main
