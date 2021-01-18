#!/bin/bash

main() {

    if [ -z $1 ]; then
        echo "You need to give a file name to bring you the options"
        exit
    fi

    fileToSearch="$*"

    echo "Looking up exact file \"$fileToSearch\""

    rawFindResults=$(find $HOME -type f -iname "$fileToSearch" -nowarn)

    result=($rawFindResults) # split to array $names

    findings=${#result[*]}

    if [ $findings -gt 0 ]; then
        echo "$findings result(s) found!"
    else
        echo "The file couldn't be found..."
        exit
    fi

    i=0
    lastElement=$((findings - 1))
    while [ $i -lt $findings ]; do
        if [ $i -ge $lastElement ]; then isLast=true; fi
        if [ $isLast ]; then echo "Its the lastElement"; fi
        performAction ${result["$i"]} $isLast
        let i=i+1
    done

}

performAction() {

    unknownOptionTxt="Unknown option"
    echo "$1"
    if [ $2 ]; then
        nextOption=""
        nextOptionTxt=$unknownOptionTxt
    else
        nextOption="10. Go to next file
            "
        nextOptionTxt="Next file"
    fi

    echo "Enter an option for
    $1:
    1. Compress it
    2. Add timestamp prefix to it
    3. Delete it
    $nextOption
    99. EXIT"

    read option

    case $option in
        1)
            echo "Compressing" $1
            tar -f -z $1
            echo $1 "compressed"
            ;;
        2)
            echo "Adding timestamp to" $1

            current_time=$(date "+%Y.%m.%d-%H.%M.%S")
            echo "Current time: $current_time"

            new_fileName=$1.$current_time
            echo "New file name: $new_fileName"

            rm $1
            cp $1 $new_fileName
            echo "Timestamp added to $1. It's new name is $new_fileName"

            ;;

        3)
            echo "Delete" $1
            rm $1
            ;;

        10)
            echo "$nextOptionTxt"
            if [ $2 ]; then
                performAction $1 $2
            fi
            ;;
        99)
            echo "Exit"
            exit
            ;;
        *)
            echo "Unknown option"
            performAction $1 $2
            ;;
    esac
    return
}

SAVEIFS=$IFS # Save current IFS
IFS=$'\n'    # Change IFS to new line
main $1
IFS=$SAVEIFS # Restore IFS
