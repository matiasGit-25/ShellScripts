#!/bin/bash
printFactorial() {

    if [ -z $1 ]; then
        echo "You need to give a number to calculate its factorial"
        exit
    fi

    counter=$1
    factorial=1
    while [ $counter -gt 0 ]; do
        factorial=$((factorial * counter))
        counter=$((counter - 1))
    done

    echo "Broadcasting factorial $factorial to tty using command 'wall'"
    wall "Factorial of $1 is $factorial"

}

printFactorial $1
