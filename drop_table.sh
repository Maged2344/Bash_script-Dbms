#! /bin/bash
    echo
    echo "========================== drop table =============================="
    echo


 list_table.sh

         echo "please enter table name to remove : " | pv -qL 100
         read -r  remove_tb
    if [ -f $remove_tb ] 
    then
        echo "are you sure delete $remove_tb (y/n): " | pv -qL 100
        read -r  ans
        if [[ $ans == y || $ans == Y ]]
        then
        rm -r $remove_tb .$remove_tb.meta
        echo "================================================================="
        echo "======================= $remove_tb removed ======================"
        echo "================================================================="
        echo
        fi
    else
        echo
        echo  "$remove_tb table does not exist"
        echo
    fi
        echo
        echo "1. remove another table"
        echo "2. connect menu"
        echo
        echo "Please enter your choice : " | pv -qL 100
        read -r  choice
case $choice in 
    1 ) drop_table.sh ;;
    2 ) exit ;;
esac