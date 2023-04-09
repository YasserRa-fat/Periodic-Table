#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else
if [[ ! $1 =~ ^[0-9]+$ ]]
then
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'OR name= '$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1' OR name= '$1'")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1' OR name= '$1'")
TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE  symbol='$1 'OR name= '$1'")
MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name= '$1'")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol= '$1'")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name= '$1'")
if [[ -z $SYMBOL ]]
then 
echo "I could not find that element in the database."
else
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi 

else
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'OR name= '$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1' OR name= '$1'")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1' OR name= '$1'")
TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name= '$1'")
MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1 OR symbol='$1' OR name= '$1'")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol='$1' OR name= '$1'")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name= '$1'")
if [[ -z $SYMBOL ]]
then 
echo "I could not find that element in the database."
else
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi 

fi

fi
