#!/usr/bin/env bash

# Сценарий должен имитировать работу лототрона -- извлекать 5 случайных неповторяющихся
# чисел в диапазоне 1 - 50. Сценарий должен предусматривать как вывод на stdout , так и запись
# чисел в файл, кроме того, вместе с числами должны выводиться дата и время генерации
# данного набора.

arr_0=()

count=1
MAXCOUNT=5

LOWER_LIMIT=1
UPPER_LIMIT=50

WRITE_FILE=8_file.txt

COMMAND_DATE_AND_TIME=`date +"%D %T"`
COMMAND_RANDOM_NUMBER=$(( LOWER_LIMIT + RANDOM % UPPER_LIMIT ))

function random()
{
  while (( "$count" <= "$MAXCOUNT" )); do
    number_arr_0=$(( LOWER_LIMIT + RANDOM % UPPER_LIMIT ))
    arr_0+=( $number_arr_0 )
    (( count++ ))
  done
  echo "$COMMAND_DATE_AND_TIME: ${arr_0[@]}"
}

function write_to_file()
{
  local result_random=$(random)
  echo ${result_random} >> ${WRITE_FILE}
}

function output_to_terminal()
{
  local result_random=$(random)
  echo $result_random
}

echo
echo "Записать результат в файл?"
echo "Y/N"
read write_file
if [ "${write_file^^}" == "Y" ]; then
  write_to_file
else
  output_to_terminal
fi

exit 0
