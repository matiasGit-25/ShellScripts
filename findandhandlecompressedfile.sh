#!/bin/bash

findAndHandleCompressedFile() {

    if [ -z $1 ]; then
        echo "You need to give a file name to run the script"
        exit
    fi

    dir="/" #$(pwd)

    echo "Looking up '${1}' file with any extension in '${dir}'..."

    find_result=$(find $dir -type f -name "${1}*" 2>&1 | grep -v "Permission denied" | head -n 1) # Solo tomamos 1er resultado

    if [ $find_result ]; then

        echo "Found $find_result"

        find_if_is_compressed=$(file $find_result | grep -i -e compress -e zip)

        found_is_compressed=${#find_if_is_compressed[*]}

        if [ $found_is_compressed -gt 0 ]; then

            echo "The file is compressed"

            delete_menu $find_result

        else

            dir=$(dirname "$find_result")

            echo "The file is not compressed. Compressing its folder '${dir}'"

            tar czf "$dir".tar.gz --absolute-names "$dir"/

        fi

    else
        echo "The file $1 was not found in $dir"
    fi

}

delete_menu() {

    file_name=$(basename $1)
    echo "Delete compressed file '${file_name}'? Yes/No"
    read yes_no_option

    case $yes_no_option in

        [yY] | [yY][Ee][Ss])
            rm $find_result
            ;;
        [nN] | [nN][Oo])
            echo "Exiting"
            exit
            ;;
        *)
            echo "Invalid option"
            delete_menu $1
            ;;
    esac
}

findAndHandleCompressedFile $1
