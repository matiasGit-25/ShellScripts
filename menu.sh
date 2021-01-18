#!/bin/bash

main() {

    echo "What do you want to do?
    1. See if a user is connected
    2. Print the factorial of a number
    3. Handle a file
    4. Handle a compress file
    99. EXIT"

    read option

    case $option in
        1)
            echo "Enter the user to look up"
            read user
            ./userconnected.sh $user
            ;;
        2)
            echo "Enter a number"
            read number
            ./printfactorial.sh $number
            ;;

        3)
            echo "Enter the file to be handled"
            read file
            ./handlefile.sh $file
            ;;

        4)
            echo "Enter the name of the compressed file to be handled"
            read file
            ./findandhandlecompressedfile.sh $file
            ;;
        99)
            echo "Exiting script"
            exit
            ;;
        *)
            echo "Unknown option"
            main
            ;;
    esac
    exit
}

main
