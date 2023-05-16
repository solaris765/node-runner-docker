#!/bin/sh
set -euo pipefail
IFS=$'\n\t'

# check if REMOTE is set
if [ -z "$REMOTE_URL" ]; then
    echo "REMOTE_URL is unset"
    exit 1
fi

echo "-----------------------"
echo "Downloading latest release"
echo "-----------------------"
# check if app.zip exists
if [ -f "/app.zip" ]; then
    echo "Removing old app.zip"
    rm /app.zip
fi
if curl -L -o app.zip "$REMOTE_URL"; then

    echo "-----------------------"
    echo "Unzipping to /app"
    echo "-----------------------"
    # check if /app is not empty
    if [ "$(ls -A /app)" ]; then
        echo "Removing old files"
        rm -rf /app/*
    fi
    unzip app.zip -d /app

    echo "-----------------------"
    echo "Starting application"
    echo "-----------------------"
    cd /app
    npm ci
    npm start
else
    echo "curl failed"
fi
