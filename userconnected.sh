#!/bin/bash

checkIfUserIsConnected() {

    if [ -z $1 ]; then
        echo "You need to give a user name to lookup"
        exit
    fi

    usersConnected=$(who | cut -d ' ' -f1)

    echo "Users connected: " $usersConnected

    if [[ $usersConnected == *$1* ]]; then
        isUserConnected='YES'
    else
        isUserConnected='NO'
    fi
    echo "Is $1 connected?: " $isUserConnected

}

checkIfUserIsConnected $1
