#!/bin/bash

# Напишите сценарий, который будет выводить себя на stdout, но в обратном порядке.

FILE_NAME="$1"

if test -z "$FILE_NAME"
then
  echo "Аргументы командной строки отсутствуют."
  echo "Введите путь до файла! В формате:"
  echo "./3.sh file"
else
  cat "$FILE_NAME" | rev
fi

exit 0
