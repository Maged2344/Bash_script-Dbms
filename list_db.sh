#! /bin/bash
echo
echo  "======================================= list database ======================================"
echo
if [ `ls ./databases/ | wc -l` == 0 ]
then     
    echo  "No Database Found" 
    echo
    echo  
   main_menu.sh
else
    ls ./databases/
    echo
    echo "===========================================================================================" 
fi