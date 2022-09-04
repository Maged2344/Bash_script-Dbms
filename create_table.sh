#! /bin/bash
#this file is to create the table and the coulmns inside it with its data type (int,string,date)
echo
echo "===================================create table========================================="
echo "Enter table name want to create : " | pv -qL 100
read  -r  tbname
echo
#this loop is cheacking the validation of the name
while [[ -z $tbname ]] || [[ $tbname == *['!''@#/$\"*{^})(+|,;:~`._%&/=-]>[<?']* ]] || [[ $tbname =~ [0-9] ]]
 do          
            echo  "
              ^    
            /_!_\  Invalid Input"
            echo
            echo "PLease Enter table Name Again: " | pv -qL 100
            read -r tbname
                         
done
#--------------------------------------------------------------------------------------------------------------------------------------

if [ -f $tbname ] #check_existance
 then
        echo "
          ^    
        /_!_\ Table $tbname already exists!!"
        create_table.sh
else
    declare -a values                   #array for columns names
    declare -a types                    #array for data types 
    counter=0                           #index of the currrent column
    pkeycounter=-1 
    #--------------------------------------------------------------------------------------------------------------------------------------
  select add in addcolumn exit
    do 
      case $add in
          addcolumn )
                          echo "Please enter column name and data types below!" | pv -qL 100
                          echo "column name: "
                          read -r columnname
                          echo "Data type (int or str or date): "
                          read -r  dattypea
          
                      if [[ $dattypea == int || $dattypea == str || $dattypea == date ]] #correct data type
                        then
                                  
                          if [ $pkeycounter -eq  -1 ]                    #no pk inserted
                            then
                                  echo "do you wanna make this attribute primary key!?( 'y' for yes 'n' for no ): " | pv -qL 100
                                  read -r  answer
                                  
                              case $answer in
                                  [Yy]* ) 
                                          values[$counter]="$columnname:"  #saving the column name in the column array
                                          types[$counter]="(p)$dattypea:" #saving the data type of the column in the data type array
                                          let pkeycounter=$counter        #saving the primary key column by saving the column number in the array primary key index
                                          let counter=$counter+1          #incremanting the counter to countine reading
                                          ;;
                                  [Nn]* ) 
                                          values[$counter]="$columnname:"  #saving the column name in the column array
                                          types[$counter]="$dattypea:"     #saving the data type of the column in the data type array
                                          let counter=$counter+1           #incremanting the counter to countine reading
                                      ;;
                                  * ) 
                                          echo " 
                                            ^    
                                          /_!_\ Please, press y or n"
                                      ;;
                              esac
                          else                                           #there is pk 
                              values[$counter]+="$columnname:"           #saving the column name in the column array
                              types[$counter]+="$dattypea:"              #saving the data type of the column in the data type array
                              let counter=$counter+1                     #incremanting the counter to countine reading

                          fi                                             #end of data saving
                      else
                          echo " 
                                        ^    
                                      /_!_\ Wrong data type!"
                      fi
                                  echo "1) add column"
                                  echo "2) exit"                                                 #end of data type condition
                    ;;
          exit )
                            break
                    ;;
          *)   
                            echo " 
                        ^    
                      /_!_\ Wrong choice"
                    ;;
      esac
  done    
 #--------------------------------------------------------------------------------------------------------------------------------------
 function pkey_fun {                        #this function is used to make sure that the table have primary key    
  if [ $pkeycounter -eq -1 ]
    then
              echo "Ouch! You forgot to specify pkey! please select the index of your primary key: " | pv -qL 100
              echo ${values[@]}                       #printing all of the array (all columns names)
              read x
              re='^[0-9]+$'
      if [[ $x =~ $re && $x -le $counter-1 ]] #check if index is integer and within values array range
       then
              types[$x]="(p)${types[$x]}"
              let pkeycounter=$x
       else
                echo " 
                        ^    
                      /_!_\ Table wrong index please try again! "
              pkey_fun
      fi
  fi
  }
    pkey_fun
 #-------------------------------------------SAVING THE DATA -------------------------------------------------------------------------------------------
    touch $tbname                                            #creating table
    touch .$tbname.meta                                      #creating meta data file
    echo $counter >  .$tbname.meta                           #adding the number of columns
    echo $pkeycounter >> .$tbname.meta                       #adding the primary key index
    printf %s "${types[@]}" $'\n' >> .$tbname.meta           #adding the columns datatypes
    printf %s "${values[@]}" $'\n' >> .$tbname.meta          #adding the colmns names
    echo "==========================================================================="
    echo " ===================== $tbname created Successfully ====================="
    echo "==========================================================================="
    echo
fi