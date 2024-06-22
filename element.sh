#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 ]]
then
  RESULT=$($PSQL "SELECT elements.atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE elements.atomic_number=$1 OR symbol ILIKE '$1' OR name ILIKE '$1';")
  if [[ -z $RESULT ]]
  then
    echo I could not find that element in the database.
  else
    echo $RESULT | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
    do
    echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius.
    done
  fi
else 
  echo Please provide an element as an argument.
fi