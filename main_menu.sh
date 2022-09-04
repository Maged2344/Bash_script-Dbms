#! /bin/bash
cd ~
toilet -w200 -f mono12 -F metal Dbms Devops 

figlet "Please Enter your name : " 
echo
read -r n
toilet "hello"  
toilet -w200 -f mono12 -F gay $n 


if [ -d "databases" ]
then
    echo
    echo "======================================================================================="
    echo "      ==================== data base is running correctly ====================" 
    echo "======================================================================================="
else
    mkdir ./databases
fi
while true
do
    echo
    echo "======================================= main menu ======================================"
    echo
    echo "1. create Database"
    echo "2. list Databases"
    echo "3. Connect To Databases"
    echo "4. Drop Database"
    echo "5. Exit"
    echo
    echo "Please enter your choice : " | pv -qL 50
    read -r  choice
    echo
    
case $choice in
    1 ) create_db.sh ;;
    2 ) list_db.sh ;;
    3 ) connect_db.sh ;;
    4 ) drop_db.sh ;;
    5 ) sl -e ; break ;; 
    * ) apt-get moo ; play ~/Music/*.mp3 ;echo -e "\n$choice is not a valid option try again \n" ;;
esac
done
banner " M A G E D"
banner "     &"
banner " M A G D Y"