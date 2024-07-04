#!/bin/sh
SCRIPT_NICKNAME="Persistent volume guard script"

echo "$SCRIPT_NICKNAME: Checking the persistent volume..."
if [ -d $PERSISTENT_VOL_LOCATION ]; then
    if [ ! -d $SQLITE_DBS_LOCATION ]; then
        echo "$SCRIPT_NICKNAME: No $SQLITE_DBS_LOCATION directory found. Creating it..." 
        mkdir -p $SQLITE_DBS_LOCATION
        if [ $? -eq 0 ]; then
            echo "$SCRIPT_NICKNAME: Successfully created the $SQLITE_DBS_LOCATION directory"
        else
            echo "$SCRIPT_NICKNAME: ERROR - Cannot create the $SQLITE_DBS_LOCATION directory. Maybe a permissions issue?"
            exit 1
        fi
    fi
    if [ ! -d $DEVFILES_LOCATION ]; then
        echo "$SCRIPT_NICKNAME: No $DEVFILES_LOCATION directory found. Creating it..." 
        mkdir -p $DEVFILES_LOCATION
        if [ $? -eq 0 ]; then
            echo "$SCRIPT_NICKNAME: Successfully created the $DEVFILES_LOCATION directory"
        else
            echo "$SCRIPT_NICKNAME: ERROR - Cannot create the $DEVFILES_LOCATION directory. Maybe a permissions issue?"
            exit 1
        fi
    fi
else
    echo "$SCRIPT_NICKNAME: ERROR - The persistent volume is not mounted at $PERSISTENT_VOL_LOCATION" 
    exit 1
fi
echo "$SCRIPT_NICKNAME: Ok"
exit 0
