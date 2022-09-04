#! /bin/bash
list_table.sh

echo "=============================Select Table==================================="
echo
echo "Enter Table You Want To Select" | pv -qL 100
read -r tablename
    
function validate(){        
        new_col_name=$1                                          #the data entered
        value=$2                                                 #the type of data wanted to be validate
        if [ $value == "text" ]                                  #if the validation type is text then it need to avoide numbers
         then
            additional_reg=*[0-9]*
        elif [ $value == "num" ]                                  #if the validation type is number then it need to avoide text
         then
            additional_reg=*[a-zA-Z]*
        fi
                                                                 #validate the input is not corupted
        while  [[ $new_col_name == *['!''@#/$\\"*{^})(+|,;:~`._%&/=-]>[<?']* || $new_col_name == "" || $new_col_name == $additional_reg || $new_col_name == [\\] || $new_col_name == [\'] ]]
         do 
            echo  "
                      ^    
                    /_!_\ Invalid Input"
            echo
            echo "PLease Enter The Value Again: "
            read -r  new_col_name         
        done
        return $new_col_name    
 }
function selectall(){                                     
        if      [ $(cat "$tablename" | wc -l) -eq 0 ]      #this condition is used to make sure that the table have data on it
         then
                echo "
                      ^    
                    /_!_\ This Table is empty"
        else
                head -4 $table_meta_data | tail -1                 #printing the table head (columns names)
                awk -F: '{print $0}' $tablename                    #printing the table data (columns data)                
        fi
 }

function select_col(){       
            names=$(head -4 $table_meta_data | tail -1)    #reading table heads(columns names)
            col_names=($(echo "$names" | sed 's/:/ /g'))
            counter=0
            echo ${col_names[@]} 
            echo "Enter column name: "
            read -r  col_name
            text="text"                                      #the type of data wanted to be validate
            validate $col_name $text                         #validate the input
            col_name=${?}                                    #the input after validation

        for el in "${col_names[@]}";
         do                                                   #incrementing the column number starting with one in order to match the selected column 
            let counter=$counter+1                            #index of input column
            if [ $col_name = $el ]                            #this condition is to make sure that the inserted column name is the one printed
             then
                 awk -F: '{print $'$counter'}' $tablename     #printing the counter which will represent the number of column which is the column name inserted
        break
            elif [ $counter -eq ${#col_names[@]} ]             #this condition is to make sure that the counter isn't greater than the nymber of columns 
             then
                echo "
                          ^    
                        /_!_\ Column $col_name does not exist"
            fi
        done
 } 

function select_record(){
            pkey_index=$(head -2 "$table_meta_data" | tail -1)
            echo "Please enter the primary key of the record :"
            read -r  input_pkey
            text="num"
            validate $input_pkey $text
            input_pkey=${?}
            let y=$pkey_index+1
            r_num=0
            r_num=$(awk -F: '{if ($'$y'=="'$input_pkey'")print NR}' $tablename)
            # check if pkey doesnt exist
        if [ $((r_num)) -eq 0 ]
         then
            echo "${col_names[$pkey_index]} does not exist"
        else
            #search for the required value then print it
            data=$(awk  'BEGIN{FS=":"}{if (NR=="'$r_num'")print $0}' $tablename)
            echo "************************"
            echo "***  $data   ***" 
            echo "************************"
            echo '============================================================'
        fi
 }

if [ -f $tablename ] 
 then
        echo "==========$tablename selected=========="
        table_meta_data=".${tablename}.meta"
    while true
     do
            echo
            echo 1.select all
            echo 2.select column
            echo 3.select record
            echo 4.exit
            echo "Enter your choice: "
            read -r  choice
        case $choice in
                1) selectall ;;
                2) select_col ;;
                3) select_record ;;
                4) exit  ;;
                *) echo "$choice is not a valid option"
        esac
    done
else
            echo
            echo  "$tablename table does not exist"
            echo
fi