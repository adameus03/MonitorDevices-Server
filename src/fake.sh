#!/bin/bash

SCRIPT_NICKNAME="Faker"

#Connect to the database and check if user_id 0x0123456789abcdef (16B blob) exists
# If not create such user
# (It is required for the fake device to work)

if [[ $(sqlite3 $SQLITE_DBS_LOCATION/monitordevicesdb.sqlite "SELECT * FROM users WHERE user_id = X'61616161616161616262626262626262'") ]]; then
    echo "$SCRIPT_NICKNAME: Fake user exists"
else
    echo "$SCRIPT_NICKNAME: Fake user does not exist, creating..."
    
    sqlite3 $SQLITE_DBS_LOCATION/monitordevicesdb.sqlite "INSERT INTO users (user_id, username, password, email, createdAt, updatedAt, wants_mail_notifications) VALUES(X'61616161616161616262626262626262', 'test_user', '10a6e6cc8311a3e2bcc09bf6c199adecd5dd59408c343e926b129c4914f3cb01', 'amadeusz.sitnicki3@gmail.com', '2007-01-01 10:00:00', '2007-01-01 10:00:00', 1)"

    if [[ $(sqlite3 $SQLITE_DBS_LOCATION/monitordevicesdb.sqlite "SELECT * FROM users WHERE user_id = X'61616161616161616262626262626262'") ]]; then
        echo "$SCRIPT_NICKNAME: Fake user created successfully"
    else
        echo "$SCRIPT_NICKNAME: ERROR - Failed to create fake user"
        exit 1
    fi
fi

# Sleep to drastically increase the chance of node server starting before the fake device
sleep 10
# Start fake device
cd ./fake/fakedev
if [ $? -eq 0 ]; then
    echo "$SCRIPT_NICKNAME: Launching fake device..."
    ./debug/fake_device
else
    echo "$SCRIPT_NICKNAME: ERROR - Failed to navigate to the fake device directory!"
    exit 1
fi
