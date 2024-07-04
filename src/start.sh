#!/bin/sh

# [WARNING] [TODO] Not tested - WIP

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
            # Start the inference engine
            cd ./analysis
            if [ $? -eq 0 ]; then
                echo "$SCRIPT_NICKNAME: Launching inference engine..."
            else
                echo "$SCRIPT_NICKNAME: ERROR - Failed to navigate to the analysis directory!"
                exit 1
            fi
            ./inference/inference &
	    #whoami
            #tmux new-session -d -s inference './inference/inference'
	    cd ..
            # Start mocks
            chmod u+x ./fake.sh
            if [ $? -eq 0 ]; then
                echo "$SCRIPT_NICKNAME: Launching mocks..."
                ./fake.sh &
                if [ $? -eq 0 ]; then
                    echo "$SCRIPT_NICKNAME: Mocks started successfully"
                    echo "$SCRIPT_NICKNAME: Launching core application (Node.js)"
                    # Start the node server
                    npm run pm2
		    # tail -f /dev/null
                    # npm run start
                else
                    echo "$SCRIPT_NICKNAME: ERROR - Failed to start the mocks"
                fi
            else
                echo "$SCRIPT_NICKNAME: ERROR - Failed to start the mocks"
            fi
        else
            echo "$SCRIPT_NICKNAME: ERROR - Failed to setup database sync"
        fi
    else
        echo "$SCRIPT_NICKNAME: ERROR - Persistent volume guard error" 
    fi
else 
    echo "$SCRIPT_NICKNAME: ERROR - Failed to set environment variables, check the config.sh file"
fi
