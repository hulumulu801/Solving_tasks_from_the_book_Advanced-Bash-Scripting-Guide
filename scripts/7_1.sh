#!/usr/bin/bash

# Сценарий должен вывести (на stdout) все простые числа, в диапазоне от 60000 до 63000.
# Вывод должен быть отформатирован по столбцам (подсказка: воспользуйтесь командой printf)
# Решето Эратосфена

p=2
count=0
array_number=0

arr_0=()
arr_1=()
arr_2=()

LOWER_LIMIT=5
UPPER_LIMIT=100

def_arr_0()
{
  for number_arr_0 in ${arr_0[@]}; do
    if (( number_arr_0 <= 2 )); then
      arr_1+=( $number_arr_0 )
    fi
    if (( number_arr_0 >= 3 )); then
      division_arr_0=$(bc -l <<< "$number_arr_0 / $p")
      remove_all_zeros_after_point_arr_0=$(sed '/\./ s/\.\{0,1\}0\{1,\}$//' <<< $division_arr_0)
      if dell_number_arr_0=$(grep "[.]" <<< $remove_all_zeros_after_point_arr_0); then
        arr_1+=( $number_arr_0 )
      fi
    fi
  done
  if (( ${#arr_0[@]} )); then
    arr_0=()
  fi
}

def_arr_1()
{
  the_first_number_of_the_array=${arr_1[0]}
  if (( p >= the_first_number_of_the_array )); then
    p=${arr_1[$array_number]}
    for number_arr_1 in ${arr_1[@]}; do
      if (( number_arr_1 <= p )); then
        arr_2+=( $number_arr_1 )
      fi
      if (( number_arr_1 > p )); then
        division_arr_1=$(bc -l <<< "$number_arr_1 / $p")
        remove_all_zeros_after_point_arr_1=$(sed '/\./ s/\.\{0,1\}0\{1,\}$//' <<< $division_arr_1)
        if dell_number_arr_1=$(grep "[.]" <<< $remove_all_zeros_after_point_arr_1); then
          arr_2+=( $number_arr_1 )
        fi
      fi
    done
    (( array_number++ ))
  else
    (( p+=1 ))
    for number_arr_1 in ${arr_1[@]}; do
      if (( number_arr_1 <= p )); then
        arr_2+=( $number_arr_1 )
      fi
      if (( number_arr_1 > p )); then
        division_arr_1=$(bc -l <<< "$number_arr_1 / $p")
        remove_all_zeros_after_point_arr_1=$(sed '/\./ s/\.\{0,1\}0\{1,\}$//' <<< $division_arr_1)
        if dell_number_arr_1=$(grep "[.]" <<< $remove_all_zeros_after_point_arr_1); then
          arr_2+=( $number_arr_1 )
        fi
      fi
    done
  fi
  if (( ${#arr_1[@]} )); then
    arr_1=()
  fi
}

def_arr_2()
{
  the_first_number_of_the_array_1=${arr_2[0]}
  if (( p >= the_first_number_of_the_array_1 )); then
    p=${arr_2[$array_number]}
    for number_arr_2 in ${arr_2[@]}; do
      if (( number_arr_2 <= p )); then
        arr_1+=( $number_arr_2 )
      fi
      if (( number_arr_2 > p )); then
        division_arr_2=$(bc -l <<< "$number_arr_2 / $p")
        remove_all_zeros_after_point_arr_2=$(sed '/\./ s/\.\{0,1\}0\{1,\}$//' <<< $division_arr_2)
        if dell_number_arr_2=$(grep "[.]" <<< $remove_all_zeros_after_point_arr_2); then
          arr_1+=( $number_arr_2 )
        fi
      fi
    done
    (( array_number++ ))
  else
    (( p+=1 ))
    for number_arr_2 in ${arr_2[@]}; do
      if (( number_arr_2 <= $p )); then
        arr_1+=( $number_arr_2 )
      fi
      if (( number_arr_2 > p )); then
        division_arr_2=$(bc -l <<< "$number_arr_2 / $p")
        remove_all_zeros_after_point_arr_2=$(sed '/\./ s/\.\{0,1\}0\{1,\}$//' <<< $division_arr_2)
        if dell_number_arr_2=$(grep "[.]" <<< $remove_all_zeros_after_point_arr_2); then
          arr_1+=( $number_arr_2 )
        fi
      fi
    done
  fi
  if (( ${#arr_2[@]} )); then
    arr_2=()
  fi
}

def_initialization()
{
  for number in `seq $LOWER_LIMIT $UPPER_LIMIT`; do
    arr_0+=( $number )
  done
  def_arr_0
  echo "Поиск простых чисел, ожидайте!"
  echo
  while (( count < UPPER_LIMIT )); do
    def_arr_1
    def_arr_2
    (( count++ ))

    if (( ${#arr_1[@]} )); then
      last_number_arr_1=${arr_1[-1]}
      if [[ $p = $last_number_arr_1 ]]; then
        echo "Все простые числа от $LOWER_LIMIT до $UPPER_LIMIT:"
        echo ${arr_1[@]}
        break
      fi
    fi

    if (( ${#arr_2[@]} )); then
      last_number_arr_2=${arr_2[-1]}
      if [[ $p = $last_number_arr_2 ]]; then
        echo "Все простые числа от $LOWER_LIMIT до $UPPER_LIMIT:"
        echo ${arr_2[@]}
        break
      fi
    fi
  done
  exit 0
}

def_initialization
