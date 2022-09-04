#! /bin/bash
list_table.sh
echo "========================== Select Table =================================="
echo
echo "Enter Table You Want To Select" | pv -qL 100
read -r tablename
                                       # INPUT DATA CHEACKING
function validate(){                   # validate if the entered data is corupted or not it takes 2 arguments (1)the data (2)the type of the data str or int
      local new_col_name=$1                     #the data entered
                                                #the type of data wanted to be validate
      local value_inside_func=$2                #this variable is used to help identify the datatype of the input

        if [ "$value_inside_func" == "str" ]    #if the validation type is text then it need to avoide numbers
         then
            additional_reg=*[0-9]*
         elif [ "$value_inside_func" == "int" ]   #if the validation type is number then it need to avoide text
          then
            additional_reg=*[a-zA-Z]*
        fi 
                                                     #validate the input is not corupted
        while  [[ $new_col_name == *['!''@#/$\"*{^})(+""|,;:~`._%&/=-]>[<?']* || -z $new_col_name || $new_col_name == $additional_reg ]]
        do 
            echo  "
                      ^    
                    /_!_\ Invalid Input"
            echo
            echo "PLease Enter The Value Again: "
            read -r  new_col_name         
        done
                                                     #this conditon is a work around to return string 
        if [ "$value_inside_func" == "str" ]        #it will print the modified value in order to return it as a string 
         then
          echo $new_col_name
        else
          return "$new_col_name"
        fi #end of the return if
 }
function data_type_function(){    
    new_value=$1
    data_type=$2                                     #this condition is to make sure that the new data entered has the same data type of the column
  if [[ $data_type == *"int"* ]]                     #if the input is integer
  then
  while true                                 #this loop is to make sure that it wont get out with out the correct value
    do
    if [[ $new_value =~ [0-9] ]]
      then
          updating the data
          sed -i ''$r_num's/'$old_value'/'$new_value'/g' $tablename
          echo "data updated succesfully "
          break
          return $new_value
    else 
          echo " 
          ^    
        /_!_\ somthing wrong excpected number"
          echo "enter value again: "
          read -r  new_value        
    fi 
  done
  elif  [[ $data_type == *"str"* ]]                  #if the input is string
  then
  while true                                       #this loop is to make sure that it wont get out with out the correct value
    do
    if [[ $new_value =~ [a-zA-Z] ]]
      then
          sed -i ''$r_num's/'$old_value'/'$new_value'/g' $tablename                  
          echo "data updated succesfully "
  break
    else
          echo " 
          ^    
        /_!_\ somthing wrong excpected string"
        echo "enter value again: "
        read -r  new_value
    fi 
  done
                                        #if the input is date

  elif  [[ $data_type == *"date"* ]]
  then
  while true                                         #this loop is to make sure that it wont get out with out the correct value
    do
    if [[ $new_value =~ [0-9]{2}\-[0-1]{1}[0-9]{1}\-[0-9]{4} ]]
      then
          sed -i ''$r_num's/'$old_value'/'$new_value'/g' $tablename        #updating the date
          echo "data updated succesfully "
  break
    else
          echo " 
          ^    
        /_!_\ somthing wrong excpected dd-mm-yyyy"
        echo "enter a valid date: "
        read -r  new_value
    fi 
  done
  else                                               #wrong datatype
    echo " 
            ^    
          /_!_\ somthing wrong datatype cheack the table meta data"    
  fi 
 }

function update_field(){               # update the data in the corect place making sure that the input data is like the old data of type and the existance of the columns
        names=$(head -4 "$table_meta_data" | tail -1)     #getting the columns names
        col_names=($(echo "$names" | sed 's/:/ /g'))      #spliting the names of the columns
  while true                                            
   do                                                          #make sure that the column name entered is one of the columns
      state='false'                                             #identify the state of input date if it is false the loop will contiue until its true
      echo "=============== Select Column ==============="
      echo
      echo "***********************************"
      echo ${col_names[@]} 
      echo "***********************************"
      echo "enter the column you want to update :"
      read -r  column                   
                                                      #this variable is used to help identify the datatype of the input
      col_type="str"                                  #used for the validation function
                                                      #validating the input data
      validate_column=$(validate $column $col_type)   #this is a work around to return string
    for element in "${col_names[@]}";                #this loop is to make sure that the input column exist
     do 
      if [ $validate_column == $element ]          #this condition is used to make sure that the current input is correct and change the state to true 
       then
            state='true'
            break
      fi 
    done 
      if [ $state == 'true' ]                           #this condition is used to continue the rest of the code 
        then
            break
      fi
      echo "
                ^    
              /_!_\  wrong column name!"
  done 
        #gettting the right index of the column
        column_index=$(awk -F: '{for(i=1;i<=NF;i++){if($i=="'$validate_column'") print i}}' $table_meta_data)
                                                  #reading the datatype of the current column to modify the input correctly
        data_type_index=$column_index-1           #this var is used because the array index start with 0 and the awk index start with 1
        data_type=${column_datatype_array[$data_type_index]}
                                               #retriving the old value by cheacking if the row number (r_num) is eq to the current NR then loop in it to get the value of the cloumn entered e.g row number 3 column number 2 
        old_value=$(awk -F: '{if(NR=='$r_num'){for(i=1;i<=NF;i++){if(i=='$column_index') print $i}}}' $tablename)
        echo "-----------------------------------------"
        echo "current $validate_column is $old_value"
        echo "-----------------------------------------"
        echo "enter the new value :"
        read -r  new_value
                                                  # SAVING THE DATA         
        data_type_function $new_value $data_type
                                                  #updating the date
        new_value_mod=${?}
        sed -i ''$r_num's/'$old_value'/'$new_value_mod'/g' $tablename
        echo "############ data updated succesfully ###############"
 }

if [ -f $tablename ]                   # THE MAIN BODY  
 then
    echo "==========$tablename selected=========="
    table_meta_data=".${tablename}.meta"
    column_datatype=$(head -3 $table_meta_data | tail -1)                  #data types
    column_datatype_array=($(echo "$column_datatype" | sed 's/:/ /g'))     #adding data types to array 
    r_num=0                                                                #row number
    pkey_index=$(head -2 $table_meta_data | tail -1)                       #reading the primary key index
    echo "Please enter the primary key of the record you want to update!"
    read -r  input_pkey
    value="int"                                                            #input data type  
    validate $input_pkey $value                                           #validate the input is not corupted
    input_pkey=${?}
    let pkey_index=$pkey_index+1                                           #bec. there is no pk =0 & index in array start by 0 
    #cheacking if the record exist and getting its index and saving the row number
    r_num=$(awk -F: '{if ("'$input_pkey'"==$'$pkey_index')  print NR }' $tablename) #row number
              #this condition is used to make sure that the updated date is for the right record
    if [ $((r_num)) -eq 0 ]
     then
        echo "
                      ^    
                    /_!_\  primary key does not exist"
    else
      update_field        #starting the update

    fi
else
            echo
            echo  "
                      ^    
                    /_!_\  $tablename table does not exist"
            echo
fi