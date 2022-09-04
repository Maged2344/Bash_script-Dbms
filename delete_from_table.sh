# #! /bin/bash
# list_table.sh

#         echo "==================================Select Table======================================="
#         echo
#         echo "Enter Table You Want To Select"
#         read -r tablename
# if [ -f $tablename ] 
#  then
#    table_meta_data=".${tablename}.meta"
#    echo "==============================================================================="
#    echo "========================$tablename selected===================================="
#    echo "===============================================================================" 

#    column_datatype=$(head -3 $table_meta_data | tail -1)                      #data types
#    column_datatype_array=($(echo "$column_datatype" | sed 's/:/ /g'))         #adding data types to array 
#    r_num=0                                                                    #row number
#    names=$(head -4 $table_meta_data | tail -1)                                #reading columns names
#    col_names=($(echo "$names" | sed 's/:/ /g'))                               #adding the colmunns name to array
#    pkey_index=$(head -2 $table_meta_data | tail -1)                           #reading the primary key index
#    data_type=${column_datatype_array[$pkey_index]}                            #reading the datatype of the primary key to modify the input correctly
#                                                                               #this var is used because the array index start with 0 and the awk index start with 1
#                                                                               #adding because there is no pk =0 and the index in the array start by 0 
#    let y=$pkey_index+1                                                        #pk index
#    echo "Please enter the primary key that you want to delete :"              #reading the primary key for the record to delete
#    read -r  input_pkey
#  while  [[ $input_pkey == *['!''@#/$\\"*{^})(+|,;:~`._%&/=-]>[<?']* || $tablenamename == ""  ]]           #valinput_pkeyate the input is not corupted
#   do 
#         echo  "
#                         ^    
#                 /_!_\ Invalinput_pkey Input"
#         echo "PLease Enter primary key Again: "
#         read -r  input_pkey           
#  done
#                                    #INT valinput_pkeyation         
#                                     #this condition is to make sure that the new data entered has the same data type of the column
#          if [[ $data_type == *"int"* ]]                                 #if the input is integer
#           then
#            while true                #this loop is to make sure that it wont get out with out the correct value
#             do
#              if [[ $input_pkey =~ [0-9] ]]
#               then                                                 #cheacking if the record exist and getting its index and saving the row number
#                 r_num=$(awk 'BEGIN{FS=":"}{if ($'$y'=="'$input_pkey'")print NR}' $tablename)
#                 if [ $((r_num)) -eq 0 ]                        #this condition is to make sure that the entered primary key does exist in the table
#                  then
#                         echo "${col_names[$pkey_index]} does not exist"      #the entered primary key doesnt exist
#                         exit
#                 else
#                         sed -i ''$r_num'd' $tablename                            #deleting data
#                         echo "================================================="
#                         echo "  ========= data deleted succesfully =========== "
#                         echo "================================================="
#                 fi
#           break
#            else 
#                 echo " 
#                 ^    
#                 /_!_\ somthing wrong excpected number"
#                 echo "enter value again: "                 
#                 read -r new_value        
#                 fi 
#           done
#  #--STR valinput_pkeyation        

#       #if the input is string
#         elif  [[ $data_type == *"str"* ]]
#         then
#                 #this loop is to make sure that it wont get out with out the correct value
#                 while true
#                 do
#                 if [[ $new_value =~ [a-zA-Z] ]]
#                 then
#                         #cheacking if the record exist and getting its index and saving the row number
#                         r_num=$(awk 'BEGIN{FS=":"}{if ($'$y'=="'$input_pkey'")print NR}' $tablename)
#                         #this condition is to make sure that the entered primary key does exist in the table
#                         if [ $((r_num)) -eq 0 ]
#                         then
#                                 #the entered primary key doesnt exist
#                                 echo "${col_names[$pkey_index]} does not exist"
#                                 #moving back
#                                 exit
#                         else
#                                 #deleting data
#                                 sed -i ''$r_num'd' $tablename

#                                 echo "data deleted succesfully "
#                         fi
                        
#                         break
#                 else
#                 echo " 
#                        ^    
#                      /_!_\ somthing wrong excpected string"
                     
#                      read -p "enter value again: " new_value
                
#                 fi #end of the string regax if
#                 done
# #-----------------------------------------------------DATE valinput_pkeyation---------------------------------------------------------------------------------        
       
       
#        elif  [[ $data_type == *"date"* ]]
#         then
#                 #this loop is to make sure that it wont get out with out the correct value
#                 while true
#                 do
#                 if [[ $new_value =~ [0-9]{2}\-[0-1]{1}[0-9]{1}\-[0-9]{4} ]]
#                 then
#                         #cheacking if the record exist and getting its index and saving the row number
#                         r_num=$(awk 'BEGIN{FS=":"}{if ($'$y'=="'$input_pkey'")print NR}' $tablename)
                        
#                         #this condition is to make sure that the entered primary key does exist in the table
#                         if [ $((r_num)) -eq 0 ]
#                         then
#                                 #the entered primary key doesnt exist
#                                 echo "${col_names[$pkey_index]} does not exist"
                                
#                                 #moving back
#                                         exit
#                         else
#                                 #deleting data
#                                 sed -i ''$r_num'd' $tablename

#                                 echo "data deleted succesfully "
#                         fi                  
#                         break
#                 else
#                 echo " 
#                        ^    
#                      /_!_\ somthing wrong excpected dd-mm-yyyy"
#                      echo "enter a valinput_pkey date: "
#                      read -r  new_value
                
#                 fi #end of the date regax if
#                 done
# #--------------------------------------------------------------------------------------------------------------------------------------       
#         else
#                 echo " 
#                        ^    
#                      /_!_\ somthing wrong datatype cheack the table meta data"
               
#         fi #end of data type if
# else
#             echo
#             echo  "$tablename table does not exist"
#             echo
# fi










list_table.sh
        echo "==================================Select Table======================================="
        echo
        echo "Enter Table You Want To Select"
        read -r tablename
if [ -f $tablename ] ;
 then
   echo "==============================================================================="
   echo "========================$tablename selected===================================="
   echo "===============================================================================" 

   pkey_index_real=$(head -2 $table_meta_data | tail -1)                           #reading the primary key index
   table_meta_data=".${tablename}.meta" 
        echo "Please enter the primary key that you want to delete :"              #reading the primary key for the record to delete
        read -r  input_pkey
pkey_index=$pkey_index_real+1
if [[ $(($input_pkey)) ]]; then
    NR=$(awk -F ':' '{ if($'$pkey_index'=="'$input_pkey'") print NR }' $tablename)
    echo $(($NR))
    if [[ -z $NR ]]; then
        echo "pk not found"
    else
        sed -i ''$NR'd' $tablename
          echo " $tablename removed"
    fi
else
    NR=$(awk -F ':' '{ if($'$pkey_index'=='$(($input_pkey))' print NR }' $tablename)
    if [[ -z $NR ]]; then
        echo "pk not found"
    else
        sed -i ''$NR'd' $tablename
         echo " $tablename removed"
    fi
fi
else
            echo
            echo  "$tablename table does not exist"
            echo
fi