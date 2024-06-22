#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 ]]
then
  # check if integer for atomic_number elif check symbol else check name
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER_RESULT=$($PSQL "SELECT elements.atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE elements.atomic_number=$1;")
    if [[ -z $ATOMIC_NUMBER_RESULT ]]
    then
      echo I could not find that element in the database.
    else
      echo $ATOMIC_NUMBER_RESULT | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
      do
      echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius.
      done
    fi
    
  elif [[ $1 =~ ^..?$ ]]
  then
  SYMBOL_RESULT=$($PSQL "SELECT elements.atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1';")
    if [[ -z $SYMBOL_RESULT ]]
    then
      echo I could not find that element in the database.
    else
      echo $SYMBOL_RESULT | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
      do
      echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius.
      done
    fi

  else
    NAME_RESULT=$($PSQL "SELECT elements.atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1';")
    if [[ -z $NAME_RESULT ]]
    then
      echo I could not find that element in the database.
    else
      echo $NAME_RESULT | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
      do
      echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius.
      done
    fi

  fi
else 
  echo Please provide an element as an argument.
fi