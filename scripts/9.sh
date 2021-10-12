#!/usr/bin/env bash

# Сценарий должен отыскать в каталоге заданном пользователем файлы, имеющие
# размер больше *Mb. Каждый раз предоставляя пользователю возможность удалить, сжать или пропустить
# этот файл, затем переходить к поиску следующего файла.

arr_0=()

CATALOG="$1"

RE_SIZE_Mb='^[0-9]+$'

COMMAND_CLEAR_TERM=`/bin/clear`

function find_file()
{
  PATH=$(pwd ${CATALOG})
  FULL_PATH="$PATH/"
  FIND_FILE=$(/bin/find ${FULL_PATH} -size +${size_Mb}M)
  arr_0+=( $FIND_FILE )
}

function remove_or_compress_file()
{
  for file in ${arr_0[@]}; do
    if test -f "$file"; then
      echo "Что сделать с файлом: $file"
      echo "0 - удалить/remove;"
      echo "1 -  сжать/compress;"
      echo "2 - пропустить/skip"
      read number_0_2
      if ! [[ $number_0_2 =~ $RE_SIZE_Mb ]]; then
        echo $COMMAND_CLEAR_TERM
        echo "Это не число!"
        echo "Выход!"
        exit $E_XCD
      else
        if [ "$number_0_2" -ge 3 ]; then
          echo $COMMAND_CLEAR_TERM
          echo "Ошибка! Только числа от 0 до 2 включительно!"
          echo "Выход!"
          exit $E_XCD
        elif [ "$number_0_2" -eq 0 ]; then
          echo $COMMAND_CLEAR_TERM
          /bin/rm -rf $file
          echo "Файл: $file удален!"
          echo
        elif [ "$number_0_2" -eq 1 ]; then
          echo $COMMAND_CLEAR_TERM
          /bin/bzip2 -9 $file
          echo "Файл: $file сжат!"
          echo
        elif [ "$number_0_2" -eq 2 ]; then
          echo $COMMAND_CLEAR_TERM
        fi
      fi
    fi
  done
}


if test -z "$CATALOG"; then
  echo $COMMAND_CLEAR_TERM
  echo "Аргументы командной строки отсутствуют."
  echo "Введите путь до любого каталога"
  echo "./9.sh /path/path/CATALOG/"
else
  cd "$CATALOG" || {
    echo $COMMAND_CLEAR_TERM
    echo "НЕВОЗМОЖНО ПЕРЕЙТИ В КАТАЛОГ: $CATALOG"
    echo "Это не каталог!"
    exit $E_XCD;
  }
  echo $COMMAND_CLEAR_TERM
  echo "Введите размер в Мегабайтах(например: 10):"
  read size_Mb
  if ! [[ $size_Mb =~ $RE_SIZE_Mb ]]; then
    echo $COMMAND_CLEAR_TERM
    echo "Это не число!"
    echo "Выход!"
    exit $E_XCD
  else
    echo $COMMAND_CLEAR_TERM
    echo "Будет произведен поиск файлов больше и равно: $size_Mb Mb!"
    echo "Продолжить? Y/N"
    read next_y_n
    if [ "${next_y_n^^}" == "Y" ]; then
      echo $COMMAND_CLEAR_TERM
      echo "Идет поиск файлов..."
      echo
      find_file $CATALOG $size_Mb
      if (( ${#arr_0[@]} )); then
        remove_or_compress_file ${arr_0[@]}
      else
        echo $COMMAND_CLEAR_TERM
        echo "В каталоге: ${CATALOG} нет файлов равных или больше данного размера: ${size_Mb} Mb!"
        exit $E_XCD
      fi
    else
      echo $COMMAND_CLEAR_TERM
      echo "Выход!"
      exit $E_XCD
    fi
  fi
fi
