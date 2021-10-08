#!/bin/bash

# Сценарий должен вывести (на stdout) все простые числа, в диапазоне от 60000 до 63000.
# Вывод должен быть отформатирован по столбцам (подсказка: воспользуйтесь командой printf)

LOWER_LIMIT=5
UPPER_LIMIT=100

def_division_function()
{
  arr_division=()
  for a in `seq 1 $UPPER_LIMIT`; do
    division=$(bc -l <<< "$b/$a")
    if division_1=$(grep '.00000000000000000000' <<< "$division"); then
      remove_numbers_after_point=$(awk -F'.' '{print $1}' <<< $division_1)
      arr_division+=( $remove_numbers_after_point )
    fi
  done
}

def_prime_numbers()
{
  count=0
  for number_prime in ${arr_division[@]}; do
    (( count++ ))
  done
  if (( $count <= 2 )); then
    printf "%d === %s\n" $b "Простое число"
  fi
}

for b in `seq $LOWER_LIMIT $UPPER_LIMIT`; do
  def_division_function $UPPER_LIMIT $b
  def_prime_numbers ${arr_division[@]} $b $count_number
done

exit 0
