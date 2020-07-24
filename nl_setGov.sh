#!/bin/bash


helpMenu () {
    echo " "
    echo "PowerManagement options"
    echo "-------------------------"
    echo " "
    echo "  -h           prints this help"
    echo "  -i           current performance govenor"
    echo "  -p           sets performance mode"
    echo "  -s           sets powersave mode"
    echo "  -o           output just governor, for polybar"

    echo " "
}

printCurrentState () {
    echo " "
    echo "Current Settings"
    echo "----------------"
    echo " "
    
    currentGovernor=`cpupower frequency-info | grep "The governor " | awk -F '"' '{print $2}'`

    echo "  Current Govenor: $currentGovernor"

    echo " "
}

setPerformanceMode () {

    sudo cpupower frequency-set -g performance

}

setPowersaveMode () {

    sudo cpupower frequency-set -g powersave

}

polybarOut () {

    currentGovernor=`cpupower frequency-info | grep "The governor " | awk -F '"' '{print $2}'`

    echo "$currentGovernor"

}

while getopts 'hipso' flag
do
    case "${flag}" in
        h) 
            helpMenu
            exit
            ;;
        i)
            printCurrentState
            exit
            ;;
        p)
            setPerformanceMode > /dev/null
            polybarOut
            exit
            ;;
        s)
            setPowersaveMode > /dev/null
            polybarOut
            exit
            ;;
        o)
            polybarOut
            exit
            ;;
    esac
done

helpMenu
exit