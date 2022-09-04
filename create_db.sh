#! /bin/bash
    echo
    echo "=================================== create database ==================================="
    echo
echo "Enter data bases name want to create : " | pv -qL 50
read  -r  dbname
echo

while [[ -z $dbname ]] || [[ $dbname == *['!''@#/$\"*{^})(+|,;:~`._%&/=-]>[<?']* ]] || [[ $dbname =~ [0-9] ]]

do          
            apt-get moo ;
            echo  "Invalid Input"
            echo
            echo "PLease Enter Database Name Again: " | pv -qL 50
            read -r  dbname           
done
        if [ -d "./databases/$dbname" ]  
        then
            echo "Database $dbname already exists!!"
            echo
        else

            mkdir ./databases/$dbname

            echo "================================================================================="
            echo "  ======================= $dbname created successfully ======================="
            echo "================================================================================="
        fi
            echo
            echo "1. create another database"
            echo "2. main menu"
            echo
            echo "Please enter your choice : "| pv -qL 50
            read -r  choice
            echo
case $choice 
in 
    1 ) create_db.sh ;;
    2 ) exit ;;
    * ) apt-get moo ; echo -e "\n$choice is not a valid option try again \n" | pv -qL 50;;
esac
