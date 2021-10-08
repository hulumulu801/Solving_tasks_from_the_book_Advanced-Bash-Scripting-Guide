#!/bin/bash

# Сценарий должен сгенерировать "уникальный" 6-ти разрядный шестнадцатиричный
# идентификатор системы. Не пользуйтесь дефектной утилитой hostid. Подсказка: md5sum,
# затем отберите первые 6 цифр.

PATH_FILE="$1"
COMMAND_GEN_MD5SUM="md5sum ${PATH_FILE}"

if test -z $PATH_FILE; then
  echo
  echo "Аргументы командной строки отсутствуют."
  echo "Введите путь до любого файла! В формате:"
  echo "./5.sh /path/path/folder/file"
  echo
else
  if test -e $PATH_FILE; then
    echo
    echo "Оригинальная md5sum файла: ${PATH_FILE}"
    $COMMAND_GEN_MD5SUM
    echo
    echo "Уникальный 6-ти разрядный шестнадцатиричный идентификатор системы:"
    $COMMAND_GEN_MD5SUM | sed -e 's/[^0-9]//g' | awk '{print substr($0,0,6)}'
    echo
  else
    echo
    echo "Файл: ${PATH_FILE} НЕ СУЩЕСТВУЕТ!"
    echo
  fi
fi

exit 0
