#!/bin/sh
SCRIPT_NICKNAME="Start script"
VOLUME_GUARD_PATH="./helpers/persistent_volume_guard.sh"

# echo "$SCRIPT_NICKNAME: Running packages upgrade"
# apk update && apk upgrade

# if [ ! $? -eq 0 ]; then
#     echo "$SCRIPT_NICKNAME: WARNING - Failed to update/upgrade the packages. Proceeding with the current version."
# fi

echo "$SCRIPT_NICKNAME: Setting environment variables..."
chmod u+rx ./helpers/config.sh
. ./helpers/config.sh

if [ $? -eq 0 ]; then
    /bin/sh $VOLUME_GUARD_PATH
    if [ $? -eq 0 ]; then
        echo "$SCRIPT_NICKNAME: Setting up database sync..."
        npm run migrate

        if [ $? -eq 0 ]; then
            echo "$SCRIPT_NICKNAME: Launching core application..."
            npm run pm2
        else
            echo "$SCRIPT_NICKNAME: ERROR - Failed to setup database sync"
        fi
    else
        echo "$SCRIPT_NICKNAME: ERROR - Persistent volume guard error" 
    fi
else 
    echo "$SCRIPT_NICKNAME: ERROR - Failed to set environment variables, check the config.sh file"
fi
