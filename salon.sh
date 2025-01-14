#!/bin/bash
#psql --username=freecodecamp --dbname=salon -c "SQL QUERY HERE"
#pg_dump -cC --inserts -U freecodecamp salon > salon.sql

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c "
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [[ $1 ]]
  then  
    echo -e "\n$1"
  fi
  SERVICES=$($PSQL "SELECT service_id , name FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do 
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED

  # service availability
  SERVICE_AVAIL=$($PSQL "SELECT service_id ,name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  # if not found 
  if [[ -z $SERVICE_AVAIL ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    # get customer info
    # phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers where phone='$CUSTOMER_PHONE'")
    # if customer doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
    then
      # get customer name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # insert new customer
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # time schedule
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id =$SERVICE_ID_SELECTED")
    INSERT_APPOINTMENTS_RESULT=$($PSQL "INSERT INTO appointments (customer_id , service_id) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED)")
    
    echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
    read SERVICE_TIME
    UPDATE_TIME=$($PSQL "UPDATE appointments SET time = '$SERVICE_TIME' WHERE service_id = $SERVICE_ID_SELECTED AND customer_id=$CUSTOMER_ID")
    SERVICE_TIME=$($PSQL "SELECT time FROM appointments WHERE service_id = $SERVICE_ID_SELECTED AND customer_id=$CUSTOMER_ID")
    echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
  fi
}

# function call
MAIN_MENU

