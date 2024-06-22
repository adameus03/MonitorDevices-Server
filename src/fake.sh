#!/bin/bash

SCRIPT_NICKNAME="Faker"
sleep 5
# Start fake device
cd ./fake/fakedev
if [ $? -eq 0 ]; then
    echo "$SCRIPT_NICKNAME: Launching fake device..."
    ./debug/fake_device
else
    echo "$SCRIPT_NICKNAME: ERROR - Failed to navigate to the fake device directory!"
    exit 1
fi