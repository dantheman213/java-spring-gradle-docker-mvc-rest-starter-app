#!/bin/bash

# CLI switches/args

SHOULD_REBUILD_PROJECT="false"
REBUILD_ONLY="false"

# Global vars

ARGS=( "$@" )
ARG_COUNT=$#
HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get the relative path to the script's dir
APP_FILE_PATH="${HOME_DIR}/build/libs/app.jar" # final path to the application
GRADLE_VERSION=4.4
GRADLE_HOME="~/gradle" # Placed inside user's home dir
GRADLE_BIN_PATH="${GRADLE_HOME}/bin/"
GRADLE_NAME="gradle-${GRADLE_VERSION}"
TMP_PATH="/tmp"

# Application code begins

function checkAndInstallGradle {
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

function main() {
    # If running Docker do one thing if running in local dev do another
    if [ -n "$DOCKER" ]; then
        # in docker, just run the application in the image
        APP_FILE_PATH="/opt/app/app.jar"
        eval "java -jar ${APP_FILE_PATH}"
    else
        # not in docker, in local env

        if [ ${ARG_COUNT} -eq 1 ]; then
            if [ ${ARGS[0]} = "--build" ]; then
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
            eval "java -jar ${APP_FILE_PATH}"
        fi
    fi
}


main